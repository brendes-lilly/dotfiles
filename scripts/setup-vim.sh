#!/bin/sh
set -e

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "${script_dir}/lib.sh"

# vim < 9 doesn't include certain plugins
# vim < 9.1.0327 doesn't use XDG_CONFIG_HOME

src=if
if command -v vim >/dev/null 2>&1; then
	vim_sync_opt_packs "${XDG_CONFIG_HOME}/vim" comment helptoc
	if ! vim --version 2>/dev/null | grep -q 'XDG_CONFIG_HOME'; then
		ln -sfn "${XDG_CONFIG_HOME}/vim" "${HOME}/.vim"
	fi
fi
