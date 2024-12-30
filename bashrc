
alias cd="cd -P"
alias p='cd ..'
alias pp='cd ../..'

alias ff="find . -name"

alias ts="ctags * -R"

alias grep="grep --color=always --exclude=tags -n"
#alias dmesg="sudo dmesg --color=auto --reltime --human --nopager --decode"
#alias free="free -mht"

alias ls='ls --color'
alias la='ls --color -l'
alias ll='ls --color -la'
alias lh='ls --color -lh'

alias tree="tree --dirsfirst -C"

export PYTHONSTARTUP=~/.pythonrc
export PATH=$HOME/bin:$PATH

export USE_CCACHE=1
export EDITOR=vim
export VISUAL=vim

#export TERM=xterm-color
#export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
#export CLICOLOR=1
#export LSCOLORS=ExFxCxDxBxegedabagacad

export COLOR_NC='\e[0m' # No Color
export COLOR_NC_BOLD='\e[1m' # No Color
export COLOR_BLACK='\e[0;30m'
export COLOR_GRAY='\e[1;30m'
export COLOR_RED='\e[0;31m'
export COLOR_LIGHT_RED='\e[1;31m'
export COLOR_GREEN='\e[0;32m'
export COLOR_LIGHT_GREEN='\e[1;32m'
export COLOR_BROWN='\e[0;33m'
export COLOR_YELLOW='\e[1;33m'
export COLOR_BLUE='\e[0;34m'
export COLOR_LIGHT_BLUE='\e[1;34m'
export COLOR_PURPLE='\e[0;35m'
export COLOR_LIGHT_PURPLE='\e[1;35m'
export COLOR_CYAN='\e[0;36m'
export COLOR_LIGHT_CYAN='\e[1;36m'
export COLOR_LIGHT_GRAY='\e[0;37m'
export COLOR_WHITE='\e[1;37m'

#PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '
PS1="\[${COLOR_CYAN}\]\u\[${COLOR_LIGHT_GRAY}\]@\[${COLOR_LIGHT_GRAY}\]\h:\[${COLOR_LIGHT_BLUE}\]\w\[${COLOR_LIGHT_GRAY}\]\$\[${COLOR_NC}\] "
