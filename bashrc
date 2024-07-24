
alias cd="cd -P"
alias p='cd ..'
alias pp='cd ../..'
alias ff="find . -name"
alias ts="ctags * -R"
alias grep="grep --color=always --exclude=tags -n"
alias alog='adb logcat -v time | grep -vE "VehicleInfo|NavCorestdout|Micom"'

alias ls='ls --color'
alias la='ls --color -l'
alias ll='ls --color -la'
alias lh='ls --color -lh'

export PYTHONSTARTUP=~/.pythonrc
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
export PATH=/home/minhojun/bin:$PATH

export USE_CCACHE=1
export EDITOR=vim
export VISUAL=vim

export SSH_SOCKS_SERVER='proxy-png.intel.com:1080'
export GIT_PROXY_COMMAND=$HOME/bin/socks_connect
