#!/bin/sh

set -e

dotfiles=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
src_dir="${dotfiles}/src"
src_bin="${src_dir}/bin"
src_lib="${src_dir}/lib"
src_include="${dotfiles}/include"
pkg="bash-completion curl tmux tree ripgrep rsync vim jq"

. "${dotfiles}/scripts/lib.sh"

mkdir -p "$XDG_BIN_HOME" "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME"

if [ -d "$src_bin" ]; then
	find "$src_bin" -type f | while read -r f; do
		dest="${HOME}/bin/${f#"${src_bin}/"}"
		mkdir -p "$(dirname "$dest")"
		cp "$f" "$dest"
		chmod 755 "$dest"
	done
fi

find "$src_dir" -type f -not -path "${src_bin}/*" | while read -r f; do
	rel=${f#"${src_dir}/"}
	case "$rel" in
		.config/*) dest="${XDG_CONFIG_HOME}/${rel#.config/}" ;;
		*) dest="${HOME}/${rel}" ;;
	esac
	copy_file "$f" "$dest"
done

copy_tree "${src_lib}" "${HOME}/lib"

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
	--unset-all 'url.git@github.com:.insteadOf' || true

repo_dir="/workspaces/${GITHUB_REPOSITORY#*/}"
mkdir -p "${repo_dir}/.github"
ln -sfn "$(realpath "${HOME}/lib/AGENT.md")" "${repo_dir}/.github/copilot-instructions.md"

sh "${dotfiles}/scripts/setup-vim.sh"
sh "${dotfiles}/scripts/install-jira.sh"
sh "${dotfiles}/scripts/install-pi.sh"
