#!/bin/sh

dotfiles="/workspaces/.codespaces/.persistedshare/dotfiles"
backup_dir="${HOME}/backup"
mkdir -p "${backup_dir}"

for t in ghostty kitty; do
  command -v tic >/dev/null 2>&1 && tic -x terminfo/${t}.terminfo || echo "tic not found, skipping terminfo"
done

for file in \
  bash_profile \
  bashrc \
  bin \
  config \
  gitconfig \
  gitignore \
  profile \
  rc \
  tmux.conf \
  vim \
  zshenv \
  zshrc
do
    if [ -e "${backup_dir}/.${file}.bak" ]; then
      echo "${backup_dir}/.${file}.bak appears to exist already. Manually symlink your updated file and be careful not to clobber the original file installed on the system."
    else
      echo "Backing up ${HOME}/.${file} to ${backup_dir}/.${file}.bak ..."
      cp "${HOME}/.${file}" "${backup_dir}/.${file}.bak"
      echo "Linking ${HOME}/.${file} to ${dotfiles}/${file} ..."
      ln -sf "${dotfiles}/${file}" "${HOME}/.${file}"
    fi
done
