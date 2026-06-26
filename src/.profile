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
export ENV=$HOME/.profile
export EDITOR=vi
export VISUAL=$EDITOR
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
	display=$(printf '%s' "${DISPLAY:-:0}" | tr '/' '_')
	export NAMESPACE=/tmp/ns.$LOGNAME.$display
	mkdir -p "$NAMESPACE"
fi

if [ "$KSH_VERSION" ]; then
	HOST=$(uname -n)
	export HOST=${HOST%%.*}
fi

case $- in
*i*)
	FCEDIT=$EDITOR
	HISTCONTROL=ignoredups
	[ "$KSH_VERSION" ] && HISTFILE=$XDG_STATE_HOME/ksh_history
	[ "$TERMUX_VERSION" ] && _ls_flags=--color=never
	alias v="$EDITOR"
	alias view="$EDITOR -R"
	set -o vi

	_gitinfo() {
		{
			read -r dir
			read -r branch
		} <<-EOF
		$(gitinfo 2>/dev/null)
		EOF
		if [ -n "$dir" ]; then
			printf '%s%s' "$dir" "${branch:+[$branch]}"
		else
			# try no tilde
			# case $PWD in
			# "$HOME") printf '~' ;;
			# "$HOME"/*) printf '~%s' "${PWD#"$HOME"}" ;;
			# *) printf '%s' "$PWD" ;;
			# esac
			printf '%s' "$PWD"
		fi
	}

	_ls () {
		LC_COLLATE=C \ls -AF $_ls_flags "$@"
	}

	if [ "$CODESPACES" ]; then
		C="${CODESPACE_NAME:+${CODESPACE_NAME%-*}}"
	fi

	if [ "$SSH_CONNECTION" ]; then
		P="${C:-${HOST:-$HOSTNAME}}"
		U="${GITHUB_USER:-$LOGNAME}"
	fi

	pinfo="${P:+$P:}"'$(_gitinfo)'
	title='\[\e]0;'${pinfo}'\a\]'
	psym='% '
	pmain="${U:+$U@}"${pinfo}${psym}
	PS1=${title}${psym}
	
	case $TERM in
	xterm*)
		if [ "$TERMUX_VERSION" ]; then
			PS1=${title}${pmain}
		fi
		;;
	screen*|tmux*) ;;
	dumb)
		set +o emacs +o vi
		PS1=${pinfo}${pmain}
		;;
	*) PS1=${pinfo}${pmain} ;;
	esac

	alias ..='cd ..'
	alias cp='cp -i'
	alias mv='mv -i'

	if [ "$termprog" ] || [ "$winid" ]; then
		. 9
		export EDITOR=E
		export PAGER=nobs
		cdawd() { 9 cd "$@" && awd; }
		alias cd=cdawd
		alias ls='9 ls -F'
		alias ll='9 ls -Fl'
		alias lt='9 ls -Flrt'
		alias lc='9 lc -F'
		PS1=': $0$(_gitinfo ":%s") ; '
		awd
	else
		alias rm='rm -i'
		alias l=_ls
		alias lc=_ls
		alias ls='_ls'
		alias ll='_ls -l'
		alias lt='_ls -ltr'
	fi

	case $INSIDE_EMACS in *comint)
		stty -echo
		PS1=$(printf '\033]0;$(_gitinfo)\007\033]7;file://\\H\\w\007%% ')
	esac
esac

if [ -r "$XDG_CONFIG_HOME/profile" ]; then
	. "$XDG_CONFIG_HOME/profile"
fi
