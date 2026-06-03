#!/bin/sh

# Usage: update.sh [src] [dest]
#   src   source repo
#   dest  codespaces dotfiles repo

set -e

if [ -n "$CODESPACES" ]; then
	printf '%s\n' "update.sh: runs on the local machine, not inside a codespace" >&2
	exit 1
fi

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

src="${1:-$HOME/usr}"
dest="${2:-$script_dir}"

src_bin="${src}/bin"
src_etc="${src}/etc"
src_xdg="${src}/etc/config"

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

dots='bashrc profile'

xdg='
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
vim/colors/eink.vim
vim/colors/plain.vim
vim/plugin/bracketed-paste.vim
vim/plugin/colorscheme.vim
vim/plugin/git-auto-commit.vim
vim/plugin/plug.vim
vim/plugin/synstack.vim
vim/vimrc
'

log() { printf '%s\n' "$*"; }

copy() {
    from=$1
    to=$2
    mkdir -p "$(dirname "$to")"
    cp -v "$from" "$to"
}

log "Source: $src"
log "Dest:   $dest"
log

for f in $bins; do
    copy "${src_bin}/${f}" "${dest}/bin/${f}"
done
log

for f in $dots; do
    copy "${src_etc}/${f}" "${dest}/.${f}"
done
log

for f in $xdg; do
    copy "${src_xdg}/${f}" "${dest}/.config/${f}"
done
log

ghostty_ti=$(find ~/Applications "$HOMEBREW_PREFIX/Caskroom" -name "xterm-ghostty" 2>/dev/null -exec ls -t {} + | head -1)
if [ -f "$ghostty_ti" ]; then
	mkdir -p "$dest/terminfo"
	TERMINFO="${ghostty_ti%/*/*}" infocmp -x xterm-ghostty > "${dest}/terminfo/xterm-ghostty.terminfo"
fi

kitty_ti=$(find ~/Applications "$HOMEBREW_PREFIX/Caskroom" -name "xterm-kitty" 2>/dev/null -exec ls -t {} + | head -1)
if [ -f "$kitty_ti" ]; then
	mkdir -p "$dest/terminfo"
	TERMINFO="${kitty_ti%/*/*}" infocmp -x xterm-kitty > "${dest}/terminfo/xterm-kitty.terminfo"
fi

# old vim on codespaces
vim_runtime="/opt/homebrew/share/vim/vim91/pack/dist/opt"
vim_packs='comment helptoc'
for p in $vim_packs; do
    if [ -d "${vim_runtime}/${p}" ]; then
        mkdir -p "${dest}/.config/vim/pack/dist/opt/${p}"
        cp -Rv "${vim_runtime}/${p}/." "${dest}/.config/vim/pack/dist/opt/${p}/"
    fi
done
log

sed '/^packadd osc52/d' "${dest}/.config/vim/vimrc" > "${dest}/.config/vim/vimrc.tmp" &&
    mv "${dest}/.config/vim/vimrc.tmp" "${dest}/.config/vim/vimrc"
