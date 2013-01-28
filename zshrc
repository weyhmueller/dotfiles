PATH=$HOME/bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
DEFAULT_USER=oliver

# DO NOT EDIT BELOW THIS LINE

# GRC colorizes nifty unix tools all over the place
GRC=`which grc`
if [ "$TERM" != dumb ] && [ $? = 0 ]
then
    alias colourify="$GRC -es --colour=auto"
    alias configure='colourify ./configure'
    alias diff='colourify diff'
    alias make='colourify make'
    alias gcc='colourify gcc' 
    alias g++='colourify g++' 
    alias as='colourify as'
    alias gas='colourify gas' 
    alias ld='colourify ld'
    alias netstat='colourify netstat'
    alias ping='colourify ping'
    alias traceroute='colourify /usr/sbin/traceroute'
    alias tail='colourify tail'
fi

export VISUAL=vim
export PAGER=less
export LESS='--ignore-case --LONG-PROMPT --raw-control-chars'
# Setup terminal, and turn on colors
# [ -z "$TMUX" ] && export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='3;33'

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# use vim as an editor
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode
bindkey jj vi-cmd-mode

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# handy keybindings
bindkey "^P" history-search-backward
bindkey "^Y" accept-and-hold
bindkey "^N" insert-last-word
bindkey -s "^T" "^[Isudo ^[A" # "t" for "toughguy"

# look for ey config in project dirs
export EYRC=./.eyrc

source $HOME/.zprezto/runcoms/zshrc
