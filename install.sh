#!/bin/sh

dotfiles="/workspaces/.codespaces/.persistedshare/dotfiles"
backup_dir="${HOME}/backup"
mkdir -p "${backup_dir}"

for file in \
  bash_profile \
  bashrc \
  profile \
  rc \
  tmux.conf \
  zprofile \
  zshrc
do
  echo "Backing up ${HOME}/.${file} to ${backup_dir}/.${file}.bak ..."
  cp "${HOME}/.${file}" "${backup_dir}/.${file}.bak"
  echo "Linking ${HOME}/.${file} to ${dotfiles}/${file} ..."
  ln -sf "${dotfiles}/${file}" "${HOME}/.${file}"
done

if command -v zsh >/dev/null 2>&1; then
  if [ "$SHELL" != "$(command -v zsh)" ]; then
    echo "Changing default shell to zsh"
    sudo chsh -s "$(command -v zsh)" "$(whoami)"
  fi
fi
