
alias cd="cd -P"
alias p='cd ..'
alias pp='cd ../..'
alias ff="find . -name"
alias ts="ctags * -R"
alias grep="grep --color=always --exclude=tags -n"

#alias alog='adb logcat -v time | grep -vE "VehicleInfo|NavCorestdout|Micom"'

alias ls='ls --color'
alias la='ls --color -l'
alias ll='ls --color -la'
alias lh='ls --color -lh'

export PYTHONSTARTUP=~/.pythonrc

export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
export PATH=/home/megamino/bin:$PATH

export USE_CCACHE=1
export EDITOR=vim
export VISUAL=vim

# Using color promt
#
#if [[ ${EUID} == 0 ]] ; then
#    PS1='\[\033[48;2;221;75;57;38;2;255;255;255m\] \$ \[\033[48;2;0;135;175;38;2;221;75;57m\]\[\033[48;2;0;135;175;38;2;255;255;255m\] \h \[\033[48;2;83;85;85;38;2;0;135;175m\]\[\033[48;2;83;85;85;38;2;255;255;255m\] \w \[\033[49;38;2;83;85;85m\]\[\033[00m\] '
#else
#    PS1='\[\033[48;2;105;121;16;38;2;255;255;255m\] \$ \[\033[48;2;0;135;175;38;2;105;121;16m\]\[\033[48;2;0;135;175;38;2;255;255;255m\] \u@\h \[\033[48;2;83;85;85;38;2;0;135;175m\]\[\033[48;2;83;85;85;38;2;255;255;255m\] \w \[\033[49;38;2;83;85;85m\]\[\033[00m\] '
#fi
