#!/bin/sh

dotfiles="/workspaces/.codespaces/.persistedshare/dotfiles"
backup_dir="${HOME}/backup"
mkdir -p "${backup_dir}"

for file in \
  bash_profile \
  bashrc \
  gitconfig \
  gitignore \
  profile \
  rc \
  tmux.conf \
  zshenv \
  zshrc
do
  echo "Backing up ${HOME}/.${file} to ${backup_dir}/.${file}.bak ..."
  cp "${HOME}/.${file}" "${backup_dir}/.${file}.bak"
  echo "Linking ${HOME}/.${file} to ${dotfiles}/${file} ..."
  ln -sf "${dotfiles}/${file}" "${HOME}/.${file}"
done
