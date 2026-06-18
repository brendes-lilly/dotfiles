XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
BACKUP_DIR="${XDG_DATA_HOME}/dotfiles-backup"

backup() {
	target=$1
	[ -e "$target" ] || [ -L "$target" ] || return 0
	rel=${target#"$HOME"/}
	dest="${BACKUP_DIR}/${rel}.bak"
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
	mkdir -p "$2"
	cp -Rv "$1"/. "$2"/
}

vim_runtime() {
	command -v vim >/dev/null 2>&1 || return 1
	vim --clean -es \
		-c 'redir >> /dev/stdout' \
		-c 'echon $VIMRUNTIME' \
		-c 'redir END' \
		-c 'quit' 2>/dev/null
	}

vim_sync_opt_packs() {
	dest_vim=$1
	shift
	runtime=$(vim_runtime) || return 0
	packs="comment helptoc"
	[ -n "$runtime" ] || return 0
	for p in $packs; do
		src="${runtime}/pack/dist/opt/${p}"
		[ -d "$src" ] && copy_tree "$src" "${dest_vim}/pack/dist/opt/${p}"
	done
	return 0
}
