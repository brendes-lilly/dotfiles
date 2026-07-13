#!/bin/sh

set -e

dotfiles=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
usr_dir="${dotfiles}/usr"
include_dir="${dotfiles}/include"
pkg="bash-completion curl tmux tree ripgrep rsync vim jq"

. "${dotfiles}/scripts/lib.sh"

mkdir -p "$XDG_BIN_HOME" "$XDG_CACHE_HOME" "$XDG_CONFIG_HOME" "$XDG_DATA_HOME"

# merge json, don't copy over
pi_settings_src="${usr_dir}/etc/config/pi/agent/settings.json"
pi_settings_dst="${XDG_CONFIG_HOME}/pi/agent/settings.json"

find "$usr_dir" -type f ! -path "$pi_settings_src" | while read -r f; do
	rel=${f#"${usr_dir}/"}
	case "$rel" in
	bin/*)
		dest="${HOME}/${rel}"
		mkdir -p "$(dirname "$dest")"
		cp "$f" "$dest"
		chmod 755 "$dest"
		continue
		;;
	etc/config/*) dest="${XDG_CONFIG_HOME}/${rel#etc/config/}" ;;
	etc/*) dest="${HOME}/.${rel#etc/}" ;;
	*) dest="${HOME}/${rel}" ;;
	esac
	copy_file "$f" "$dest"
done

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
	--unset-all 'url.git@github.com:.insteadOf' || true

repo_dir="/workspaces/${GITHUB_REPOSITORY#*/}"
mkdir -p "${repo_dir}/.github"
ln -sfn "$(realpath "${HOME}/lib/AGENT.md")" "${repo_dir}/.github/copilot-instructions.md"

sh "${dotfiles}/scripts/setup-vim.sh"
sh "${dotfiles}/scripts/install-jira.sh"
sh "${dotfiles}/scripts/install-pi.sh"

# merge json and overwrite existing destination keys
if [ -f "$pi_settings_src" ]; then
	mkdir -p "$(dirname "$pi_settings_dst")"
	if [ ! -f "$pi_settings_dst" ]; then
		cp "$pi_settings_src" "$pi_settings_dst"
	elif command -v jq >/dev/null 2>&1; then
		tmp=$(mktemp "${pi_settings_dst}.XXXXXX")
		if jq -s '.[0] * .[1]' "$pi_settings_dst" "$pi_settings_src" > "$tmp"; then
			mv "$tmp" "$pi_settings_dst"
		else
			rm -f "$tmp"
			printf '%s\n' "warning: failed to merge ${pi_settings_dst}" >&2
		fi
	else
		printf '%s\n' "warning: jq not found; leaving ${pi_settings_dst} unmerged" >&2
	fi
fi
