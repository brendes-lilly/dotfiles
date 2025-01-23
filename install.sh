#!/bin/sh

case "$0" in
  /*) scriptdir="${0%/*}" ;;
  *) scriptdir="$PWD/${0#./}" ; scriptdir="${scriptdir%/*}" ;;
esac

backup_dir=${HOME}/backup
mkdir -p $backup_dir

for file in \
  bash_profile \
  bashrc \
  profile \
  tmux.conf \
  zprofile \
  zshrc
do
  echo "Backing up ${HOME}/.${file}/ to ${backup_dir}/.${file}.bak ..."
  cp "${scriptdir}/.${file} ${backupdir}/.${file}.bak"
  echo "Installing ${file} as .${file} ..."
  ln -sf "${scriptdir}/${file}" "{$HOME}/.${file}"
done

if command -v zsh >/dev/null 2>&1; then
  if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "Changing default shell to zsh"
    sudo chsh -s "$(command -v zsh)" "$(whoami)"
  fi
fi
