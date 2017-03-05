#!/bin/bash


function vundle-init() {
  if [ ! -d ~/.vim/bundle/vundle/ ]
  then
    mkdir -p ~/.vim/bundle/vundle/
  fi

  if [ ! -d ~/.vim/bundle/vundle/.git/ ]
  then
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
    echo "\n\tRead about vim configuration for vundle at https://github.com/gmarik/vundle\n"
  fi
}

function vimplug-init() {
  if [ ! -f ~/.vim/autoload/plug.vim ]
  then
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    vim -c "execute \"PlugUpdate\" | q | q"
  fi
}

function vundle() {
  vundle-init
  vim -c "execute \"BundleInstall\" | q | q"
}

function vimplug() {
  vimplug-init
  vim -c "execute \"PlugUpdate\" | q | q"
  
}

function vundle-update() {
  vundle-init
  vim -c "execute \"BundleInstall!\" | q | q"
}

function tpm-init() {
  if [ ! -d ~/.tmux/plugins/tpm/ ]
  then
    mkdir -p ~/.tmux/plugins/tpm/
  fi

  if [ ! -d ~/.tmux/plugins/tpm/.git/ ]
  then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi
}

function tpm-update() {
  tpm-init
  ~/.tmux/plugins/tpm/bin/clean_plugins
  ~/.tmux/plugins/tpm/bin/install_plugins
  ~/.tmux/plugins/tpm/bin/update_plugins all

  tmux source ~/.tmux.conf
}
cutstring="DO NOT EDIT BELOW THIS LINE"

rm -rf $HOME/.vim

for name in *; do
  target="$HOME/.$name"
  if [ -e "$target" ]; then
    if [ "$name" = 'bin' ]; then
      echo "Populating ~/bin"
      mkdir -p $HOME/bin
      cp -a $PWD/$name/* $HOME/bin/
    elif [ ! -L "$target" ]; then
      cutline=`grep -n -m1 "$cutstring" "$target" | sed "s/:.*//"`
      if [ -n "$cutline" ]; then
        cutline=$((cutline-1))
        echo "Updating $target"
        head -n $cutline "$target" > update_tmp
        startline=`sed '1!G;h;$!d' "$name" | grep -n -m1 "$cutstring" | sed "s/:.*//"`
        if [ -n "$startline" ]; then
          tail -n $startline "$name" >> update_tmp
        else
          cat "$name" >> update_tmp
        fi
        mv update_tmp "$target"
      else
        echo "WARNING: $target exists but is not a symlink."
      fi
    fi
  else
    if [ "$name" != 'install.sh' ] && [ "$name" != 'bin' ]; then
      echo "Creating $target"
      if [ -n "$(grep "$cutstring" "$name")" ]; then
        cp "$PWD/$name" "$target"
      else
        ln -s "$PWD/$name" "$target"
      fi
    elif [ "$name" = 'bin' ]; then
      echo "Populating ~/bin"
      mkdir -p $HOME/bin
      cp -a $PWD/$name/* $HOME/bin/
    fi
  fi
done

vimplug
tpm-update

if [ ${SHELL:${#SHELL}-3:3} != "zsh" ]; then
  chsh -s `which zsh`
fi
