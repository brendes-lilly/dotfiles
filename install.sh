#!/bin/sh

set -e

dotfiles=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
src_dir="${dotfiles}/src"
src_include="${dotfiles}/include"
src_bin="${src_dir}/bin"
src_xdg="${src_dir}/config"

pkg="bash-completion curl tmux tree ripgrep rsync neovim vim jq"

. "${dotfiles}/scripts/lib.sh"

mkdir -p "$XDG_BIN_HOME" "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME"

if [ -d "${src_bin}" ]; then
	find "${src_bin}" -type f | while read -r f; do
		dest="${HOME}/bin/${f#"${src_bin}/"}"
		mkdir -p "$(dirname "$dest")"
		cp "$f" "$dest"
		chmod 755 "$dest"
	done
fi

for f in "${src_dir}"/*; do
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

if [ -d "${src_xdg}" ]; then
	find "${src_xdg}" -mindepth 1 -maxdepth 1 | while read -r f; do
		dest="$XDG_CONFIG_HOME/$(basename "$f")"
		if [ -d "$f" ]; then
			copy_tree "$f" "$dest"
		else
			copy_file "$f" "$dest"
		fi
	done
fi

if command -v tic >/dev/null 2>&1; then
	for t in "${src_include}"/*.terminfo; do
		[ -f "$t" ] && tic -o "$HOME/.terminfo" -x "$t"
	done
fi

if command -v apt-get >/dev/null 2>&1; then
	sudo=
	[ "$(id -u)" = 0 ] || sudo=sudo
	if [ -z "$sudo" ] || command -v sudo >/dev/null 2>&1; then
		export DEBIAN_FRONTEND=noninteractive
		$sudo apt-get update
		$sudo apt-get install -y "$pkg"
	fi
fi

for f in .gitconfig .gitignore; do
	[ -e "${HOME}/${f}" ] || [ -L "${HOME}/${f}" ] || continue
	backup "${HOME}/${f}"
	rm -f "${HOME}/${f}"
done

gitconfig="${XDG_CONFIG_HOME}/git/config"
[ -f "$gitconfig" ] && git config --file "$gitconfig" \
	--unset-all 'url.git@github.com:.insteadOf' || true

sh "${dotfiles}/scripts/setup-vim.sh"
sh "${dotfiles}/scripts/install-jira.sh"
