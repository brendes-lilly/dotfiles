#!/bin/sh

# Usage: update.sh [source repo path]

set -e

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "$script_dir/lib.sh"

if [ -n "$CODESPACES" ] || [ -n "$SSH_CONNECTION" ]; then
	printf '%s\n' "update.sh: runs on the local machine, not on a remote machine" >&2
	exit 1
fi

src="${1:-$HOME/usr}"
src_bin="$src/bin"
src_etc="$src/etc"
src_xdg="$src_etc/config"

dest_src="$(git -C "$(dirname -- "$0")" rev-parse --show-toplevel)/src"
dest_include="$(git -C "$(dirname -- "$0")" rev-parse --show-toplevel)/include"
dest_bin="$dest_src/bin"
dest_xdg="$dest_src/.config"

bins='
1header
bio/bam-print-lengths
bio/fqlen
brokenlinks
collapse
csv
datehead
ddcol
dedup
delws
extract
ff
g
h
git-merge-summary
gitinfo
noansi
tailwatch
tc
tmux-url
transpose
tsv
wdump
wmd
'

dots='bash_profile bashrc profile shrc zshenv'
# add ${src_etc}/pi/agent/themes/plain.json (nothing else in pi/)
# add ${src_etc}/pi/agent/AGENT.md (nothing else in pi/)

xdgs='
git/config
git/ignore
nvim/after/lsp/lua_ls.lua
nvim/init.lua
nvim/plugin/auto-dark.lua
nvim/plugin/fzf.lua
nvim/plugin/lsp.lua
nvim/plugin/neotree.lua
nvim/plugin/pkg.lua
tmux/tmux.conf
vim/after/ftplugin/c.vim
vim/after/ftplugin/gitcommit.vim
vim/after/ftplugin/go.vim
vim/after/ftplugin/json.vim
vim/after/ftplugin/lua.vim
vim/after/ftplugin/mail.vim
vim/after/ftplugin/markdown.vim
vim/after/ftplugin/python.vim
vim/after/ftplugin/r.vim
vim/after/ftplugin/sh.vim
vim/after/ftplugin/text.vim
vim/after/ftplugin/vim.vim
vim/after/plugin/git-status.vim
vim/colors/acme.vim
vim/colors/calm.vim
vim/colors/chernila.vim
vim/colors/plain.vim
vim/plugin/bracketed-paste.vim
vim/plugin/colorscheme.vim
vim/plugin/git-auto-commit.vim
vim/plugin/plug.vim
vim/plugin/synstack.vim
vim/vimrc
zsh/.zprofile
zsh/.zshrc
'

log() { printf '%s\n' "$*"; }

copy() {
    from=$1
    to=$2
    mkdir -p "$(dirname "$to")"
    cp -v "$from" "$to"
}

copy_list() {
	from_base=$1
	to_base=$2
	shift 2
	for f in "$@"; do
		copy "${from_base}/${f}" "${to_base}/${f}"
	done
}

copy_dotlist() {
	from_base=$1
	to_base=$2
	shift 2
	for f in "$@"; do
		copy "${from_base}/${f}" "${to_base}/.${f}"
	done
}

copy_list "$src_bin" "$dest_bin" $bins
copy_list "$src_xdg" "$dest_xdg" $xdgs
copy_dotlist "$src_etc" "$dest_src" $dots

ghostty_ti=$(find ~/Applications "$HOMEBREW_PREFIX/Caskroom" -name "xterm-ghostty" 2>/dev/null -exec ls -t {} + | head -1)
if [ -f "$ghostty_ti" ]; then
	TERMINFO="${ghostty_ti%/*/*}" infocmp -x xterm-ghostty > "${dest_include}/xterm-ghostty.terminfo"
fi

kitty_ti=$(find ~/Applications "$HOMEBREW_PREFIX/Caskroom" -name "xterm-kitty" 2>/dev/null -exec ls -t {} + | head -1)
if [ -f "$kitty_ti" ]; then
	TERMINFO="${kitty_ti%/*/*}" infocmp -x xterm-kitty > "${dest_include}/xterm-kitty.terminfo"
fi

# codespaces tend to have old vim
vim_sync_opt_packs "$dest_xdg"/vim
