PATH=$HOME/bin:$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
DEFAULT_USER=oliver

# DO NOT EDIT BELOW THIS LINE
if [[ -z $TMUX ]]; then
  PATH=$HOME/.sysadmin-util:$PATH:/usr/local/bin
fi
# GRC colorizes nifty unix tools all over the place
GRC=`which grc 2>/dev/null`
NOT_FOUND_GRC=$?
if [ "$TERM" != dumb ] && [ $NOT_FOUND_GRC = 0 ]
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

source ~/.powerlevel9k

export VISUAL=vim
export PAGER=less
export LESS='--ignore-case --LONG-PROMPT --raw-control-chars'
# Setup terminal, and turn on colors
# [ -z "$TMUX" ] && export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad

# Enable color in grep
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

# ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red
# ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=yellow
# ZSH_HIGHLIGHT_STYLES[alias]='fg=green'
# ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
# ZSH_HIGHLIGHT_STYLES[function]='fg=green'
# ZSH_HIGHLIGHT_STYLES[command]='fg=green'
# ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
# ZSH_HIGHLIGHT_STYLES[commandseparator]=none
# ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=green
ZSH_HIGHLIGHT_STYLES[path]='fg=white'
# ZSH_HIGHLIGHT_STYLES[globbing]='fg=blue'
# ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta'
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
# ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
# ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=cyan
# ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=cyan
# ZSH_HIGHLIGHT_STYLES[assign]=none

