export OS=$(uname | tr 'A-Z' 'a-z')
export PLAN9=$HOME/opt/plan9
export GOPATH=$HOME/opt/go
export RUSTUP_HOME=$HOME/opt/rust/rustup
export CARGO_HOME=$HOME/opt/rust/cargo
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_BIN_HOME=$HOME/.local/bin
export ENV=$HOME/.shrc
export LESS="FRX --mouse"
export NO_COLOR=1
export AV_LOG_FORCE_NOCOLOR=1
export NODE_NO_READLINE=1
export FZF_DEFAULT_OPTS="--no-bold --no-color --no-unicode \
	--gutter='' --style=minimal	--prompt=': '"

case $OS in
darwin)
	export BASH_SILENCE_DEPRECATION_WARNING=1
	export HOMEBREW_NO_EMOJI=1
	export HOMEBREW_NO_ENV_HINTS=1
	export HOMEBREW_NO_INSECURE_REDIRECT=1
	;;
linux)
	if [ "$TERMUX_VERSION" ]; then
		case "$(getprop ro.product.brand 2>/dev/null)" in
			Onyx) export EINK=1 ;;
		esac
	fi
esac

for dir in \
	/opt/homebrew/bin \
	$CARGO_HOME/bin \
	$GOPATH/bin \
	$HOME/bin/p9p \
	$HOME/bin/bio \
	$HOME/bin \
	$HOME/bin/$OS \
	$XDG_BIN_HOME
do
	[ -d "$dir" ] &&
		case ":$PATH:" in
		*":$dir:"*) ;;
		*) PATH="$dir:$PATH" ;;
	esac
done

if [ -d "$PLAN9" ]; then
	case ":$PATH:" in
		*":$PLAN9/bin:"*) ;;
		*) PATH=$PATH:$PLAN9/bin ;;
	esac
	export NAMESPACE=/tmp/ns.$LOGNAME
	mkdir -p "$NAMESPACE"
fi

if [ "$KSH_VERSION" ]; then
	HOST=$(uname -n)
	export HOST=${HOST%%.*}
fi

if [ "CODESPACES" ]; then
	export C="${CODESPACE_NAME:+${CODESPACE_NAME%-*}}"
fi

case $TERM in
dumb)
	if [ "$termprog" ] || [ "$winid" ]; then
		export EDITOR=E
		export PAGER=nobs
	fi
	;;
*)
	export EDITOR=vi
	export VISUAL=$EDITOR
	export FCEDIT=$EDITOR
esac

[ -r "$XDG_CONFIG_HOME/profile" ] && . "$XDG_CONFIG_HOME/profile"
