#!/bin/sh

dotfiles="/workspaces/.codespaces/.persistedshare/dotfiles"
manifest_file="manifest"
pkg="zsh tmux tree neovim jq"

cd "$dotfiles"

dry_run=false
if [ "$1" = "-d" ]; then
  dry_run=true
  echo "DRY RUN: No changes will be made."
  echo
fi

link_into() {
  src=$1 dest=$2
  { [ -e "$dest" ] || [ -L "$dest" ]; } && rm -rf -- "$dest"
  ln -sfnvT -- "$src" "$dest" 2>/dev/null || ln -sfnv -- "$src" "$dest"
}

if ! command -v apt >/dev/null 2>&1; then
  echo "apt not found, skipping package installation"
fi
if $dry_run; then
  echo "Would install packages: $pkg"
fi
if [ "$(id -u)" = "0" ]; then
  apt update
  apt install -y $pkg
elif command -v sudo >/dev/null 2>&1; then
  sudo apt update
  sudo apt install -y $pkg
else
  echo "Not root and sudo not available, skipping package installation"
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

# After fetching files from manifest, track what should exist
if [ -f "$manifest_file" ]; then
  echo "Fetching files from source repo..."
  github_user="brendes"
  repo="usr"
  manifest_files=""
  while IFS= read -r src; do
    case "$src" in
    "" | \#*) continue ;;
    esac
    src="${src%%#*}"
    src="${src%% *}"
    [ -z "$src" ] && continue

    # Add to tracking list
    manifest_files="${manifest_files}${src}\n"

    if $dry_run; then
      echo "Would fetch: $src"
    else
      echo "Fetching: $src"
      mkdir -pv "$(dirname "$src")"
      curl -L "https://raw.githubusercontent.com/$github_user/$repo/main/$src" \
        -o "$src"
    fi
  done <"$manifest_file"
  echo

  # Clean up files not in manifest
  if [ -d "etc" ]; then
    echo "Cleaning up files not in manifest..."
    find etc -type f | while read -r file; do
      # Check if file is in manifest
      if ! printf "%s" "$manifest_files" | grep -Fxq "$file"; then
        # Remove the file
        if $dry_run; then
          echo "Would remove: $file"
        else
          echo "Removing: $file"
          rm -f "$file"
        fi

        # Remove corresponding symlink
        base_name=$(echo "$file" | sed 's|^etc/||')
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
    # Remove empty directories
    if ! $dry_run; then
      find etc -type d -empty -delete
    fi
  fi
fi

if [ -d "${dotfiles}/etc" ]; then
  for file in "${dotfiles}"/etc/*; do
    [ -e "$file" ] || continue
    name=$(basename "$file")
    [ "$name" = "config" ] && continue
    dest="${HOME}/.${name}"
    if $dry_run; then
      echo "Would link: $dest -> $file"
    else
      # Remove existing directory if it's not a symlink
      if [ -d "$dest" ] && [ ! -L "$dest" ]; then
        rm -rf "$dest"
      fi
      link_into "$file" "$dest"
    fi
  done
fi

if [ -d "${dotfiles}/etc/config" ]; then
  if ! $dry_run; then
    mkdir -pv "${HOME}/.config"
  fi
  for item in "${dotfiles}"/etc/config/*; do
    [ -e "$item" ] || continue
    name=$(basename "$item")
    dest="${HOME}/.config/${name}"
    if $dry_run; then
      echo "Would link: $dest -> $item"
    else
      # Remove existing directory if it's not a symlink
      if [ -d "$dest" ] && [ ! -L "$dest" ]; then
        rm -rf "$dest"
      fi
      link_into "$item" "$dest"
    fi
  done
fi

if [ -d "${dotfiles}/bin" ]; then
  dest="${HOME}/bin"
  if $dry_run; then
    echo "Would link: $dest -> ${dotfiles}/bin"
  else
    chmod +x "${dotfiles}"/bin/*
    link_into "${dotfiles}/bin" "$dest"
  fi
fi

key='url.git@github.com:.insteadof'
if $dry_run; then
  echo "Would run: git config --global --unset-all $key"
else
  git config --global --unset-all "$key"
fi

$dry_run && echo && echo "Dry run complete. No changes made."
