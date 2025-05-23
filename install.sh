#!/bin/sh

dotfiles="/workspaces/.codespaces/.persistedshare/dotfiles"
backup_dir="${HOME}/backup"
mkdir -p "${backup_dir}" "${HOME}/.config"

for t in ghostty kitty; do
  command -v tic >/dev/null 2>&1 &&
    tic -x terminfo/${t}.terminfo ||
    echo "tic not found, skipping terminfo"
done

for file in \
  bin \
  .bash_profile \
  .bashrc \
  .config/git \
  .config/nvim \
  .gitconfig \
  .gitignore \
  .profile \
  .rc \
  .tmux.conf \
  .vim \
  .zshenv \
  .zshrc
do
  if [ ! -e "${backup_dir}/${file}" ] || [ -e "${backup_dir}/${file}.bak" ]
  then
    echo "Linking ${HOME}/${file} to ${dotfiles}/${file} ..."
    ln -sf "${dotfiles}/${file}" "${HOME}/${file}"
  else
    echo "Copying ${HOME}/${file} to ${backup_dir}/${file}.bak ..."
    cp -r "${HOME}/${file}" "${backup_dir}/${file}.bak"
    echo "Linking ${HOME}/${file} to ${dotfiles}/${file} ..."
    ln -sf "${dotfiles}/${file}" "${HOME}/${file}"
  fi
done
