#!/bin/sh

set -e

dotfiles="/workspaces/.codespaces/.persistedshare/dotfiles"
src_dir="${dotfiles}/src"
include_dir="${dotfiles}/include"
pkg="bash-completion curl tmux tree ripgrep rsync neovim vim jq"

cd "$dotfiles" || exit 1
. "${dotfiles}/scripts/lib.sh"

mkdir -p "$XDG_BIN_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME"

if [ -d "${src_dir}/bin" ]; then
	find "${src_dir}/bin" -type f | while read -r f; do
		dest="${HOME}/bin/${f#"${src_dir}/bin/"}"
		mkdir -p "$(dirname "$dest")"
		cp "$f" "$dest"
		chmod 755 "$dest"
	done
fi

for f in "${src_dir}"/.*; do
	[ -e "$f" ] || continue
	name=$(basename "$f")
	case "$name" in .|..) continue ;; esac
	dest="${HOME}/${name}"
	if [ -d "$f" ]; then
		copy_tree "$f" "$dest"
	else
		copy_file "$f" "$dest"
	fi
done

if [ -d "${src_dir}/.config" ]; then
	find "${src_dir}/.config" -mindepth 1 -maxdepth 1 | while read -r f; do
		dest="$XDG_CONFIG_HOME/$(basename "$f")"
		if [ -d "$f" ]; then
			copy_tree "$f" "$dest"
		else
			copy_file "$f" "$dest"
		fi
	done
fi

if command -v tic >/dev/null 2>&1; then
	for t in "${include_dir}"/*.terminfo; do
		[ -f "$t" ] && tic -o "$HOME/.terminfo" -x "$t"
	done
fi

if command -v apt-get >/dev/null 2>&1; then
	sudo=
	[ "$(id -u)" = 0 ] || sudo=sudo
	if [ -z "$sudo" ] || command -v sudo >/dev/null 2>&1; then
		export DEBIAN_FRONTEND=noninteractive
		$sudo apt-get update
		$sudo apt-get install -y $pkg
	fi
fi

for f in .gitconfig .gitignore; do
	[ -e "${HOME}/${f}" ] || [ -L "${HOME}/${f}" ] || continue
	backup "${HOME}/${f}"
	rm -f "${HOME}/${f}"
done

gitconfig="${XDG_CONFIG_HOME}/git/config"
[ -f "$gitconfig" ] && git config --file "$gitconfig" \
	--unset-all 'url.git@github.com:.insteadOf' 2>/dev/null || true

line='. "$XDG_DATA_HOME/bashrc"' 
grep -qF "$line" "$HOME/.bashrc" || printf '\n%s\n' "$line" >> "$HOME/.bashrc"
copy_file "${include_dir}/bashrc.local" "${XDG_DATA_HOME}/bashrc"

sh "${dotfiles}/scripts/setup-vim.sh"
sh "${dotfiles}/scripts/install-jira.sh"

