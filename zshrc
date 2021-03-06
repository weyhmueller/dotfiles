# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files source by it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
zstyle ':z4h:' auto-update      'ask'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Automaticaly wrap TTY with a transparent tmux ('integrated'), or start a
# full-fledged tmux ('system'), or disable features that require tmux ('no').
zstyle ':z4h:' start-tmux       'no'
# Move prompt to the bottom when zsh starts up so that it's always in the
# same position. Has no effect if start-tmux is 'no'.
zstyle ':z4h:' prompt-at-bottom 'yes'

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'mac'
# When fzf menu opens on TAB, another TAB moves the cursor down ('tab:down')
# or accepts the selection and triggers another TAB-completion ('tab:repeat')?
zstyle ':z4h:fzf-complete'    fzf-bindings     'tab:repeat'
# When fzf menu opens on Shift+Down, TAB moves the cursor down ('tab:down')
# or accepts the selection and triggers another Shift+Down ('tab:repeat')?
zstyle ':z4h:cd-down'         fzf-bindings     'tab:down'
# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# ssh when connecting to these hosts.
zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over ssh to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Move the cursor to the end when Up/Down fetches a command from history?
zstyle ':zle:up-line-or-beginning-search'   leave-cursor 'yes'
zstyle ':zle:down-line-or-beginning-search' leave-cursor 'yes'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
z4h install ohmyzsh/ohmyzsh || return

z4h source $Z4H/ohmyzsh/plugins/gpg-agent/gpg-agent.plugin.zsh
export GPG_AGENT_INFO="~/.gnupg/S.gpg-agent:$(pgrep gpg-agent):1"

unset SSH_AUTH_SOCK
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_ed25519 id_ed25519_sk_5c1 id_ed25519_sk_5cnfc1 id_ed25519_sk_5cnfc2

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Export environment variables.
export ZSH_CUSTOM=~/.credentials

# Extend PATH.
path=(~/bin /usr/local/opt/python@3.9/bin /opt/homebrew/opt/curl/bin /opt/homebrew/bin $path)


# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
#z4h source $Z4H/ohmyzsh/ohmyzsh/lib/diagnostics.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/lib/clipboard.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/lib/functions.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/lib/directories.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/lib/grep.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/ansible/ansible.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/aws/aws.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/brew/brew.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/common-aliases/common-aliases.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/colorize/colorize.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/copybuffer/copybuffer.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/copydir/copydir.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/copyfile/copyfile.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/cp/cp.plugin.zsh
# z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/debian/debian.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/direnv/direnv.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/docker/docker.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/doctl/doctl.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/encode64/encode64.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/extract/extract.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/gem/gem.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/git/git.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/git-extras/git-extras.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/git-lfs/git-lfs.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/helm/helm.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/httpie/httpie.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/jsontools/jsontools.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/jump/jump.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/kubectl/kubectl.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/mosh/mosh.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/nmap/nmap.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/osx/osx.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/perms/perms.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/profiles/profiles.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/rvm/rvm.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/ssh-agent/ssh-agent.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/singlechar/singlechar.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/sudo/sudo.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/systemadmin/systemadmin.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/tmux/tmux.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/vscode/vscode.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/web-search/web-search.plugin.zsh
z4h source $Z4H/ohmyzsh/ohmyzsh/plugins/zsh_reload/zsh_reload.plugin.zsh

# Source additional local files if they exist.
z4h source ~/.iterm2_shell_integration.zsh

# Define key bindings.
z4h bindkey z4h-backward-kill-word  Ctrl+Backspace Ctrl+H
z4h bindkey z4h-backward-kill-zword Ctrl+Alt+Backspace

z4h bindkey undo Ctrl+/  # undo the last command line change
z4h bindkey redo Alt+/   # redo the last undone command line change

z4h bindkey z4h-cd-back    Shift+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Shift+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Shift+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Shift+Down   # cd into a child directory

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Define named directories: ~w <=> Windows home directory on WSL.
[[ -n $z4h_win_home ]] && hash -d w=$z4h_win_home

# Define aliases.
alias tree='tree -a -I .git'

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -g"

# look for ey config in project dirs
export EYRC=./.eyrc
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red
ZSH_HIGHLIGHT_STYLES[path]='fg=7'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=magenta'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=magenta'

if [ -e "$HOME/.rvm/scripts/rvm" ]; then
  source "$HOME/.rvm/scripts/rvm"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
