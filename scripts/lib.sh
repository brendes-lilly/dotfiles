XDG_BIN_HOME="${XDG_BIN_HOME:-$HOME/.local/bin}"
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
