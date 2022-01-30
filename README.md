# Dotfiles

These are my dotfiles, managed by [chezmoi](https://www.chezmoi.io/).

## Installation

### Prerequisites

The following packages are required to clone the repository
and install 1password-cli to access the key for the encrypted files:

* curl
* git
* git-lfs
* gpg
* unzip

```bash
apt install curl git git-lfs gpg unzip
```

### Install chezmoi and clone the dotfiles

```bash
sh -c "$(curl -fsLS git.io/chezmoi)" -- -b "${HOME}/bin" -d init  --apply weyhmueller
```

### Install vim-Plugins

```bash
vim -c "execute \"PlugUpdate\"
```
