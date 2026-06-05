#!/bin/sh
set -e

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "${script_dir}/lib.sh"

# vim < 9 doesn't include certain plugins
# vim < 9.1.0327 doesn't use XDG_CONFIG_HOME

if command -v vim >/dev/null 2>&1; then
	vimruntime="$(vim --clean -es -c 'echon $VIMRUNTIME' -c 'quit' 2>/dev/null)"
	if [ -n "$vimruntime" ]; then
		vim_src="${vimruntime}/pack/dist/opt"
		vim_dest="${XDG_CONFIG_HOME}/vim/pack/dist/opt"
		for p in comment helptoc; do
			[ -d "${vim_src}/${p}" ] && copy_tree "${vim_src}/${p}" "${vim_dest}/${p}"
		done
	fi

	vimrc="${XDG_CONFIG_HOME}/vim/vimrc"
	[ -f "$vimrc" ] && sed -i '/^packadd osc52/d' "$vimrc"

	# vim < 9.1.0327 doesn't use XDG_CONFIG_HOME
	if ! vim --version 2>/dev/null | grep -q '\$XDG_CONFIG_HOME'; then
		ln -sfn "${XDG_CONFIG_HOME}/vim" "${HOME}/.vim"
	fi
fi

