#!/bin/bash

CHECK_INTERVAL=10
GRACE_PERIOD=900      # 15 minutes
PORT_REFRESH=300      # sshd 포트 재탐지 주기 (초)

INHIBIT_PID=""
SSH_DISCONNECTED_AT=""

SSH_PORTS=""
PORT_DETECTED_AT=0


DEBUG="${DEBUG:-0}"

log()
{
    logger -t ssh-sleep-inhibit --id=$$ -- "$*"
    return 0
}

dbg()
{
    [ "$DEBUG" = 1 ] && logger -t ssh-sleep-inhibit --id=$$ -- "DEBUG: $*"
    return 0
}


#
# sshd가 실제로 listen 중인 포트 목록을 얻는다.
#   1) sshd -T (유효 설정 dump, root 필요)
#   2) listen 소켓에서 sshd 프로세스 검색
#   3) 최후의 수단으로 22
#
detect_ssh_ports()
{
    local sshd ports

    sshd=$(command -v sshd || echo /usr/sbin/sshd)

    ports=$("$sshd" -T 2>/dev/null | awk '$1 == "port" { print $2 }' | sort -un)

    if [ -z "$ports" ]; then
        ports=$(ss -Hltnp 2>/dev/null \
            | awk '/"sshd"/ { sub(/.*:/, "", $4); print $4 }' | sort -un)
    fi

    if [ -z "$ports" ]; then
        log "Could not detect sshd port - falling back to 22"
        ports=22
    fi

    echo $ports
}


refresh_ssh_ports()
{
    local now
    now=$(date +%s)

    if [ -z "$SSH_PORTS" ] || [ $((now - PORT_DETECTED_AT)) -ge "$PORT_REFRESH" ]; then

        local ports
        ports=$(detect_ssh_ports)
        PORT_DETECTED_AT=$now

        if [ "$ports" != "$SSH_PORTS" ]; then
            log "Monitoring SSH port(s): $ports"
            SSH_PORTS=$ports
        fi
    fi
}


has_ssh_session()
{
    local port filter=""

    for port in $SSH_PORTS; do
        [ -n "$filter" ] && filter="$filter or "
        filter="${filter}sport = :$port"
    done

    ss -Htn state established "( $filter )" | grep -q .
}


inhibitor_running()
{
    [ -n "$INHIBIT_PID" ] && kill -0 "$INHIBIT_PID" 2>/dev/null
}


start_inhibitor()
{
    dbg "start_inhibitor"
    if ! inhibitor_running; then

        log "Starting suspend inhibitor"

        systemd-inhibit \
            --what=sleep \
            --who="SSH session" \
            --why="SSH active or grace period" \
            --mode=block \
            sleep infinity &

        INHIBIT_PID=$!
    else
        dbg "Already inhibitor running"
    fi
}


stop_inhibitor()
{
    dbg "stop_inhibitor"
    if inhibitor_running; then

        log "Stopping suspend inhibitor"

        #
        # systemd-inhibit는 받은 시그널을 자식에게 전달하지 않는다.
        # 자식(sleep infinity)을 먼저 정리해야 고아 프로세스가 남지 않는다.
        # 자식이 끝나면 systemd-inhibit도 스스로 종료하며 lock을 해제한다.
        #
        pkill -TERM -P "$INHIBIT_PID" 2>/dev/null
        kill "$INHIBIT_PID" 2>/dev/null
        wait "$INHIBIT_PID" 2>/dev/null

    fi

    INHIBIT_PID=""
}


trap 'stop_inhibitor; exit 0' INT TERM
trap stop_inhibitor EXIT


while true; do
    refresh_ssh_ports

    if has_ssh_session; then
        dbg "There is ssh connection."
        start_inhibitor

        # disconnect timer 취소
        SSH_DISCONNECTED_AT=""
    else
        dbg "No SSH session detected"

        if inhibitor_running; then
            dbg "inhibitor is running"

            if [ -z "$SSH_DISCONNECTED_AT" ]; then
                SSH_DISCONNECTED_AT=$(date +%s)
                log "SSH disconnected - starting ${GRACE_PERIOD}s grace period"
            fi

            NOW=$(date +%s)
            ELAPSED=$((NOW - SSH_DISCONNECTED_AT))

            if [ "$ELAPSED" -ge "$GRACE_PERIOD" ]; then
                log "Grace period expired - allowing suspend"

                stop_inhibitor

                SSH_DISCONNECTED_AT=""
            fi
        else
            dbg "inhibitor not running"

            if [ -n "$INHIBIT_PID" ]; then
                log "Inhibitor died unexpectedly - resetting state"
                INHIBIT_PID=""
            fi

            SSH_DISCONNECTED_AT=""
        fi
    fi

    #
    # background + wait: SIGTERM을 즉시 받기 위함
    # (foreground sleep이면 trap이 최대 CHECK_INTERVAL초 지연된다)
    #
    sleep "$CHECK_INTERVAL" &
    wait $!

done
