#!/bin/sh

set -e

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$script_dir/lib.sh"

if [ -n "$CODESPACES" ] || [ -n "$SSH_CONNECTION" ]; then
	printf '%s\n' "update.sh: runs on the local machine, not on a remote machine" >&2
	exit 1
fi

from="${1:-$HOME/usr}"

dotfiles=$(git -C "$script_dir" rev-parse --show-toplevel)
manifest="$dotfiles/MANIFEST"
dest_usr="$dotfiles/usr"
dest_include="$dotfiles/include"

copy() {
	mkdir -p "$(dirname "$2")"
	cp -v "$1" "$2"
}

while read -r line; do
	line=${line%%#*}
	[ -n "$line" ] || continue
	copy "${from}/${line}" "${dest_usr}/${line}"
done < "$manifest"

ghostty_ti=$(find ~/Applications "$HOMEBREW_PREFIX/Caskroom" -name "xterm-ghostty" 2>/dev/null -exec ls -t {} + | head -1)
if [ -f "$ghostty_ti" ]; then
	TERMINFO="${ghostty_ti%/*/*}" infocmp -x xterm-ghostty > "${dest_include}/xterm-ghostty.terminfo"
fi

kitty_ti=$(find ~/Applications "$HOMEBREW_PREFIX/Caskroom" -name "xterm-kitty" 2>/dev/null -exec ls -t {} + | head -1)
if [ -f "$kitty_ti" ]; then
	TERMINFO="${kitty_ti%/*/*}" infocmp -x xterm-kitty > "${dest_include}/xterm-kitty.terminfo"
fi

# codespaces tend to have old vim
vim_sync_opt_packs "${dest_usr}/etc/config/vim"
