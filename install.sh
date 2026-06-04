#!/bin/sh

set -e

XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
backup_dir="${XDG_DATA_HOME}/dotfiles-backup"
arch="$(uname -m | sed 's/aarch64/arm64/g')"
dotfiles="/workspaces/.codespaces/.persistedshare/dotfiles"
pkg="tmux tree ripgrep rsync neovim vim jq"
jira_version="1.7.0"

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
	cp -v "$1" "$2"
}

copy_tree() {
	backup "$2"
	mkdir -p "$(dirname "$2")"
	cp -Rv "$1" "$2"
}

install_jira() {
	if command -v jira >/dev/null 2>&1 && \
		jira version 2>/dev/null | grep -q "\"${jira_version}\""; then
		return 0
	fi

	jira_pkg="jira_${jira_version}_linux_${arch}.tar.gz"
	jira_url="https://github.com/ankitpokhrel/jira-cli/releases/download/v${jira_version}/${jira_pkg}"
	tmp=$(mktemp -d)

	trap 'rm -rf "$tmp"' EXIT
	curl -fsSL "$jira_url" -o "$tmp/jira.tar.gz"
	tar -xzf "$tmp/jira.tar.gz" -C "$tmp"
	mkdir -p "$XDG_BIN_HOME"
	cp "$tmp"/jira_*/bin/jira "$XDG_BIN_HOME/jira"
	chmod 755 "$XDG_BIN_HOME/jira"
	unset jira_pkg jira_url
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

if command -v tic >/dev/null 2>&1 && [ -d "terminfo" ]; then
	for t in terminfo/*.terminfo; do
		[ -f "$t" ] && tic -o "$HOME/.terminfo" -x "$t"
	done
fi

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

local_bashrc="${XDG_DATA_HOME}/bashrc"
[ -f "$local_bashrc" ] || copy_file bashrc.local "$local_bashrc"
grep 'XDG_DATA_HOME\/bashrc' $HOME/.bashrc >/dev/null ||
	printf '\n%s\n' ". $local_bashrc" >> $HOME/.bashrc

gitconfig="${HOME}/.config/git/config"
[ -f "$gitconfig" ] && git config --file "$gitconfig" \
	--unset-all 'url.git@github.com:.insteadOf' 2>/dev/null || true

# vim < 9.1.0327 doesn't look in ~/.config/vim
if command -v vim >/dev/null 2>&1; then
	if ! vim --version 2>/dev/null | grep -q '\$XDG_CONFIG_HOME/vim/vimrc'; then
		ln -sfn "${HOME}/.config/vim" "${HOME}/.vim"
	fi
fi

install_jira

