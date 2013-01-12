[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# DO NOT EDIT BELOW THIS LINE
export PATH="~/.bin:/usr/local/bin:/usr/local/sbin:$PATH"

# adds the current branch name in green
function git_prompt_info() {
  local ref=$(git symbolic-ref HEAD 2> /dev/null)
  local gitst="$(git status 2> /dev/null)"
  local gitrepuser="$(git config --local user.email)"
  local gitglobuser="$(git config --global user.email)"
  local gituser="${GIT_AUTHOR_EMAIL:-${gitrepuser:-${gitglobuser}}}"
  if [[ ${gituser} == 'oliver@weyhmueller.de' || ${gituser} == '' ]]; then
    gituser="[%{$fg[green]%}oli%{$reset_color%}] "
  elif [[ ${gituser} == 'oliver.weyhmueller@t-systems.com' ]]; then
    gituser="[%{$fg[magenta]%}tsi%{$reset_color%}] "
  else
    gituser="[%{$fg[red]%}???%{$reset_color%}] "
  fi

  if [[ -f .git/MERGE_HEAD ]]; then
    if [[ ${gitst} =~ "unmerged" ]]; then
      gitstatus="[%{$fg[red]%}unmerged%{$reset_color%}]"
    else
      gitstatus="[%{$fg[green]%}merged%{$reset_color%}]"
    fi
  elif [[ ${gitst} =~ "Changes to be committed" ]]; then
    gitstatus="[%{$fg[blue]%}!%{$reset_color%}]"
  elif [[ ${gitst} =~ "use \"git add" ]]; then
    gitstatus="[%{$fg[red]%}!%{$reset_color%}]"
  elif [[ -n `git checkout HEAD 2> /dev/null | grep ahead` ]]; then
    gitstatus="[%{$fg[yellow]%}*%{$reset_color%}]"
  else
    gitstatus="[%{$fg[green]%}o%{$reset_color%}]"
  fi

  if [[ -n $ref ]]; then
    echo "[%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}]$gitstatus$gituser"
  fi
}

function precmd {
  # vcs_info
  # Put the string "hostname::/full/directory/path" in the title bar:
  echo -ne "\e]2;$PWD\a"

  # Put the parentdir/currentdir in the tab
  echo -ne "\e]1;$PWD:h:t/$PWD:t\a"
}

function set_running_app {
  printf "\e]1; $PWD:t:$(history $HISTCMD | cut -b7- ) \a"
}

function preexec {
  set_running_app
}

function postexec {
  set_running_app
}

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt prompt_subst

# ===== Basics

# If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt AUTO_CD

# Allow comments even in interactive shells (especially for Muness)
setopt INTERACTIVE_COMMENTS

# ===== History

# Allow multiple terminal sessions to all append to one zsh command history
setopt APPEND_HISTORY

# Add comamnds as they are typed, don't wait until shell exit
setopt INC_APPEND_HISTORY

# Do not write events to history that are duplicates of previous events
setopt HIST_IGNORE_DUPS

# When searching history don't display results already cycled through twice
setopt HIST_FIND_NO_DUPS

# Remove extra blanks from each command line being added to history
setopt HIST_REDUCE_BLANKS

# Include more information about when the command was executed, etc
setopt EXTENDED_HISTORY

# ===== Completion

# Allow completion from within a word/phrase
setopt COMPLETE_IN_WORD

# When completing from the middle of a word, move the cursor to the end of the word
setopt ALWAYS_TO_END

# ===== Prompt

# Enable parameter expansion, command substitution, and arithmetic expansion in the prompt
setopt PROMPT_SUBST

# prompt
export PS1='$(git_prompt_info)[${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%~%{$reset_color%}] '

