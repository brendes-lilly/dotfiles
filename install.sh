#!/bin/sh

dotfiles="/workspaces/.codespaces/.persistedshare/dotfiles"
manifest_file="manifest"
pkg="tmux tree neovim jq"

cd "$dotfiles"

dry_run=false
if [ "$1" = "-d" ]; then
    dry_run=true
    echo "DRY RUN: No changes will be made."
    echo
fi

if ! command -v apt >/dev/null 2>&1; then
    echo "apt not found, skipping package installation"
    return
fi
if $dry_run; then
    echo "Would install packages: $pkg"
    return
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

if [ -f "$manifest_file" ]; then
    echo "Fetching files from source repo..."
    github_user="brendes"
    repo="usr"
    while IFS= read -r src; do
        case "$src" in
            ""|\#*) continue ;;
        esac
        src="${src%%#*}"
        src="${src%% *}"
        [ -z "$src" ] && continue
        if $dry_run; then
            echo "Would fetch: $src"
        else
            echo "Fetching: $src"
            mkdir -pv "$(dirname "$src")"
            curl -L "https://raw.githubusercontent.com/$github_user/$repo/main/$src" \
                 -o "$src"
        fi
    done < "$manifest_file"
    echo
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
            ln -sfv "$file" "$dest"
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
            ln -sfv "$item" "$dest"
        fi
    done
fi

if [ -d "${dotfiles}/bin" ]; then
    dest="${HOME}/bin"
    if $dry_run; then
        echo "Would link: $dest -> ${dotfiles}/bin"
    else
        chmod +x "${dotfiles}"/bin/*
        ln -sfv "${dotfiles}/bin" "$dest"
    fi
fi

git config --global --unset-all url."git@github.com:".insteadof

$dry_run && echo && echo "Dry run complete. No changes made."
