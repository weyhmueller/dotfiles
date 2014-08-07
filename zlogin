[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


if [[ -z $TMUX ]]; then
  export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH"
fi
# DO NOT EDIT BELOW THIS LINE

# makes color constants available
autoload -U colors
colors
setopt INTERACTIVE_COMMENTS
setopt PROMPT_SUBST

source $HOME/.zprezto/runcoms/zlogin

