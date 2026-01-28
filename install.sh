#!/bin/sh

set -e

dotfiles="/workspaces/.codespaces/.persistedshare/dotfiles"
backup_dir="${HOME}/.local/share/dotfiles-backup"
pkg="zsh tmux tree ripgrep rsync neovim jq"

backup() {
	target=$1
	[ -e "$target" ] || [ -L "$target" ] || return 0

	rel=${target#"$HOME"/}
	dest="${backup_dir}/${rel}.bak"
	[ -e "$dest" ] && return 0

	mkdir -p "$(dirname "$dest")"
	mv "$target" "$dest"
}

copy_file() {
	backup "$2"
	mkdir -p "$(dirname "$2")"
	cp "$1" "$2"
}

copy_tree() {
	backup "$2"
	mkdir -p "$(dirname "$2")"
	cp -R "$1" "$2"
}

cd "$dotfiles" || exit 1

if command -v apt-get >/dev/null 2>&1; then
	if [ "$(id -u)" = "0" ]; then
		DEBIAN_FRONTEND=noninteractive apt-get update
		DEBIAN_FRONTEND=noninteractive apt-get install -y $pkg
	elif command -v sudo >/dev/null 2>&1; then
		sudo DEBIAN_FRONTEND=noninteractive apt-get update
		sudo DEBIAN_FRONTEND=noninteractive apt-get install -y $pkg
	fi
fi

if command -v tic >/dev/null 2>&1 && [ -d "terminfo" ]; then
	for t in terminfo/*.terminfo; do
		[ -f "$t" ] && tic -x "$t"
	done
fi

if [ -d "bin" ]; then
	find bin -type f | while read -r f; do
		dest="${HOME}/bin/${f#bin/}"
		mkdir -p "$(dirname "$dest")"
		cp "$f" "$dest"
		chmod 755 "$dest"
	done
fi

for f in ./.*; do
	[ -e "$f" ] || continue
	name=$(basename "$f")
	case "$name" in
		.|..|.config|.git) continue ;;
	esac
	dest="${HOME}/${name}"
	if [ -d "$f" ]; then
		copy_tree "$f" "$dest"
	else
		copy_file "$f" "$dest"
	fi
done

for f in .gitconfig .gitignore; do
	[ -e "${HOME}/${f}" ] || [ -L "${HOME}/${f}" ] || continue
	backup "${HOME}/${f}"
	rm -f "${HOME}/${f}"
done

if [ -d ".config" ]; then
	mkdir -p "${HOME}/.config"
	for f in .config/*; do
		[ -e "$f" ] || continue
		dest="${HOME}/.config/$(basename "$f")"
		if [ -d "$f" ]; then
			copy_tree "$f" "$dest"
		else
			copy_file "$f" "$dest"
		fi
	done
fi

gitconfig="${HOME}/.config/git/config"
[ -f "$gitconfig" ] && git config --file "$gitconfig" \
	--unset-all 'url.git@github.com:.insteadOf' 2>/dev/null || true

# vim < 9.1.0327 doesn't look in ~/.config/vim
if command -v vim >/dev/null 2>&1; then
	if ! vim --version 2>/dev/null | grep -q '\$XDG_CONFIG_HOME/vim/vimrc'; then
		ln -sfn "${HOME}/.config/vim" "${HOME}/.vim"
	fi
fi
