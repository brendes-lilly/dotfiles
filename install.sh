#!/bin/sh

dotfiles="/workspaces/.codespaces/.persistedshare/dotfiles"
dotfiles_home="$HOME/usr"
manifest_file="manifest"
pkg="zsh tmux tree ripgrep rsync neovim jq"

link_into() {
  src=$1 dest=$2
  { [ -e "$dest" ] || [ -L "$dest" ]; } && rm -rf -- "$dest"
  ln -sfnvT -- "$src" "$dest" 2>/dev/null || ln -sfnv -- "$src" "$dest"
}

dry_run=false
if [ "$1" = "-d" ]; then
  dry_run=true
  echo "DRY RUN: No changes will be made."
  echo
fi

if $dry_run; then
  echo "cd $dotfiles"
else
  cd "$dotfiles" || exit 1
fi

pkg_to_install=""
for p in $pkg; do
  case $p in
    neovim) cmd=nvim ;;
    *) cmd=$p ;;
  esac

  if ! command -v "$cmd" >/dev/null 2>&1; then
    pkg_to_install="$pkg_to_install $p"
  fi
done
pkg="$pkg_to_install"

if command -v apt >/dev/null 2>&1; then
  if [ -z "$pkg" ]; then
    echo "All packages already installed, skipping apt install"
  elif $dry_run; then
    echo "Would install packages: $pkg"
  elif [ "$(id -u)" = "0" ]; then
    DEBIAN_FRONTEND=noninteractive apt update
    DEBIAN_FRONTEND=noninteractive apt install -y \
      -o Dpkg::Options::="--force-confold" \
      -o Dpkg::Options::="--force-confdef" \
      $pkg
  elif command -v sudo >/dev/null 2>&1; then
    sudo DEBIAN_FRONTEND=noninteractive apt update
    sudo DEBIAN_FRONTEND=noninteractive apt install -y \
      -o Dpkg::Options::="--force-confold" \
      -o Dpkg::Options::="--force-confdef" \
      $pkg
  else
    echo "Not root and sudo not available, skipping package installation"
  fi
else
  echo "apt not found, skipping package installation"
fi

if command -v tic >/dev/null 2>&1; then
  for t in ghostty kitty; do
    if [ -f "terminfo/${t}.terminfo" ]; then
      if $dry_run; then
        echo "Would compile: terminfo/${t}.terminfo"
      else
        echo "Compiling terminfo: ${t}"
        tic -x "terminfo/${t}.terminfo"
      fi
    fi
  done
  echo
fi

if [ -f "$manifest_file" ]; then
  echo "Fetching files from source repo..."
  user="brendes"
  repo="usr"

  while IFS= read -r src; do
    case "$src" in
    "" | \#*) continue ;;
    esac
    src="${src%%#*}"
    src="${src%% *}"
    [ -z "$src" ] && continue

    if $dry_run; then
      echo "Would fetch: $src"
    else
      echo "Fetching: $src"
      mkdir -pv "$(dirname "$src")"
      curl -L "https://raw.githubusercontent.com/$user/$repo/main/$src" \
        -o "$src"
    fi
  done <"$manifest_file"
  echo

  # Clean up files not in manifest
  if [ -d "etc" ]; then
    echo "Cleaning up files not in manifest..."
    find etc -type f | while read -r file; do
      # Check if file is in manifest directly
      if ! grep -Fxq "$file" "$manifest_file"; then
        # Remove the file
        if $dry_run; then
          echo "Would remove: $file"
        else
          echo "Removing: $file"
          rm -f "$file"
        fi

        # Remove corresponding symlink
        base_name="${file#etc/}"
        if [ "$base_name" = "${base_name#config/}" ]; then
          link_dest="${HOME}/.${base_name}"
        else
          link_dest="${HOME}/.config/${base_name#config/}"
        fi

        if [ -L "$link_dest" ]; then
          target=$(readlink "$link_dest")
          if [ "$target" = "${dotfiles}/$file" ]; then
            if $dry_run; then
              echo "Would unlink: $link_dest"
            else
              echo "Unlinking: $link_dest"
              rm -f "$link_dest"
            fi
          fi
        fi
      fi
    done
    if ! $dry_run; then
      find etc -type d -empty -delete
    fi
  fi
fi

if [ -d "${dotfiles}/bin" ]; then
  if $dry_run; then
    echo "Would sync: ${dotfiles}/bin -> ${dotfiles_home}/bin"
  else
    mkdir -p "${dotfiles_home}"
    rsync -a --chmod=D755,F755 "${dotfiles}/bin/" "${dotfiles_home}/bin/"
  fi
fi

if [ -d "${dotfiles}/etc" ]; then
  if $dry_run; then
    echo "Would sync: ${dotfiles}/etc -> ${dotfiles_home}/etc"
  else
    mkdir -p "${dotfiles_home}"
    rsync -a "${dotfiles}/etc/" "${dotfiles_home}/etc/"
  fi
fi

if [ -d "${dotfiles_home}/etc" ]; then
  for file in "${dotfiles_home}/etc"/*; do
    [ -e "$file" ] || continue
    name=$(basename "$file")
    [ "$name" = "config" ] && continue
    dest="${HOME}/.${name}"
    if $dry_run; then
      echo "Would link: $dest -> $file"
    else
      if [ -d "$dest" ] && [ ! -L "$dest" ]; then
        rm -rf "$dest"
      fi
      link_into "$file" "$dest"
    fi
  done
fi

if [ -d "${dotfiles_home}/etc/config" ]; then
  if ! $dry_run; then
    mkdir -pv "${HOME}/.config"
  else
    echo "Would create: ${HOME}/.config"
  fi
  for item in "${dotfiles_home}/etc/config"/*; do
    [ -e "$item" ] || continue
    name=$(basename "$item")
    dest="${HOME}/.config/${name}"
    if $dry_run; then
      echo "Would link: $dest -> $item"
    else
      if [ -d "$dest" ] && [ ! -L "$dest" ]; then
        rm -rf "$dest"
      fi
      link_into "$item" "$dest"
    fi
  done
fi

key='url.git@github.com:.insteadOf'
if $dry_run; then
  echo "Would run: git config --global --unset-all $key"
else
  git config --file $HOME/usr/etc/config/git/config --unset-all 'url.git@github.com:.insteadOf'
fi

if command -v zsh >/dev/null 2>&1; then
  current_shell=$(getent passwd "$(whoami)" | cut -d: -f7)
  zsh_path=$(command -v zsh)
  if [ "$current_shell" != "$zsh_path" ]; then
    if $dry_run; then
      echo "Would change shell to: $zsh_path"
    else
      echo "Changing default shell to zsh..."
      if [ "$(id -u)" = "0" ]; then
        chsh -s "$zsh_path"
      elif command -v sudo >/dev/null 2>&1; then
        sudo chsh -s "$zsh_path" "$(whoami)"
      else
        echo "Cannot change shell: not root and sudo not available"
      fi
    fi
  fi
else
  echo "zsh not installed, cannot set as default shell"
fi

$dry_run && echo && echo "Dry run complete. No changes made."
