
alias cd="cd -P"
alias p='cd ..'
alias pp='cd ../..'

alias ff="find . -name"

alias ts="ctags * -R"

alias grep="grep --color=always --exclude=tags -n"

alias ls='ls --color'
alias la='ls --color -l'
alias ll='ls --color -la'
alias lh='ls --color -lh'


#export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
#export PATH=$JAVA_HOME/bin:$PATH

export PYTHONSTARTUP=~/.pythonrc
export PATH=$HOME/bin:$PATH

export USE_CCACHE=1
export EDITOR=vim
export VISUAL=vim

PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '
