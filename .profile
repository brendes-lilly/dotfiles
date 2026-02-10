export H=$(uname -n)
export OS=$(uname | tr 'A-Z' 'a-z')
export ARCH=$(uname -m)

export PLAN9=$HOME/opt/plan9
export GOPATH=$HOME/opt/go
export RUSTUP_HOME=$HOME/opt/rust/rustup
export CARGO_HOME=$HOME/opt/rust/cargo
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/state
export XDG_BIN_HOME=$HOME/.local/bin

for dir in \
	/opt/homebrew/bin \
	$CARGO_HOME/bin \
	$GOPATH/bin \
	$HOME/bin/p9p \
	$HOME/bin/vc \
	$HOME/bin/bio \
	$HOME/bin \
	$HOME/bin/$ARCH \
	$HOME/bin/$OS \
	$XDG_BIN_HOME
do
	[ -d "$dir" ] && case ":$PATH:" in
		*":$dir:"*) ;;
		*) PATH="$dir:$PATH" ;;
	esac
done

if [ -d "$PLAN9" ]; then
	PATH=$PATH:$PLAN9/bin
	NAMESPACE=/tmp/ns.$USER
	mkdir -p "$NAMESPACE"
	export NAMESPACE
fi

export NO_COLOR=1
export AV_LOG_FORCE_NOCOLOR=1
export NODE_NO_READLINE=1
export FZF_DEFAULT_OPTS="--gutter=' ' --style=minimal --info=inline-right \
	--layout=reverse --no-bold --no-unicode --no-color --color=fg+:-1,hl+:-1 \
	--prompt=': '"
export LESS="--mouse"

case $OS in darwin)
	export BASH_SILENCE_DEPRECATION_WARNING=1
	export HOMEBREW_NO_EMOJI=1
	export HOMEBREW_NO_ENV_HINTS=1
	export HOMEBREW_NO_INSECURE_REDIRECT=1
esac

if command -v vim >/dev/null 2>&1; then
	export EDITOR=vim
else
	export EDITOR=vi
fi
export VISUAL=$EDITOR
export FCEDIT=$EDITOR
set -o vi

HISTSIZE=10000
HISTCONTROL=ignoredups
[ "$KSH_VERSION" ] && HISTFILE=$XDG_STATE_HOME/ksh_history

if command ls --color=never /dev/null >/dev/null 2>&1; then
	_ls="LC_COLLATE=C \ls --color=never"
else
	_ls="LC_COLLATE=C \ls"
fi
alias cd='cd -P'
alias ..='cd ..'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls="$_ls -AF"
alias ll="$_ls -AFl"
alias lt="$_ls -AFltr"
alias lc=ls
alias l=ls
alias v=$EDITOR
alias view="$EDITOR -R"

h() {
	if [ $# -eq 0 ]; then
		fc -l 1
	else
		fc -l 1 | grep -Fi -- "$*"
	fi
}

_gitinfo() { b=$(gitinfo 2>/dev/null) && printf ' [%s]' "$b"; }

_term=$TERM
if [ "$TERMUX_VERSION" ]; then
	[ -z "$TMUX" ] && _term=termux
	case "$(getprop ro.product.brand 2>/dev/null)" in
		Onyx) export EINK=1 ;;
	esac
fi

if [ "$SSH_CONNECTION" ]; then
	if [ "$CODESPACES" ]; then
		P="${CODESPACE_NAME%-*}:"
	else
		P="${USER}@${H}:"
	fi
fi

case $_term in
xterm*|tmux*)
	PS1='\[\e]0;'"$P"'\w$(_gitinfo)\a\]% '
	PROMPT=$'%{\e]0;'"$P%~"'$(_gitinfo)'$'\a%}%# '
	;;
dumb)
	unset FCEDIT VISUAL
	export PAGER=cat
	set +o emacs +o vi
	case $INSIDE_EMACS in
	*comint)
		stty -echo
		PS1=$(printf '\033]0;\\w$(_gitinfo)\007\033]7;file://\\H\\w\007%% ')
		PROMPT=$(printf '\033]0;%%~$(_gitinfo)\007\033]7;file://%%m%%~\007%%# ')
	esac
	if [ "$termprog" ] || [ "$winid" ]; then
		. 9
		export EDITOR=E
		export PAGER=p
		PS1=': $0$(b=$(gitinfo 2>/dev/null) && printf '%s' ":$b") ; '
		cdawd() { cd -P "$@" && awd; }
		alias cd=cdawd
		alias ls='9 ls -F'
		alias ll='9 ls -Fl'
		alias lt='9 ls -Flrt'
		alias lc='9 lc -F'
		awd
	fi
	;;
*)
	PS1="$P"'\w$(_gitinfo) % '
	PROMPT="$P"'%~$(_gitinfo) %# '
esac
unset _term

if [ -r "$XDG_DATA_HOME/profile.local" ]; then
	. "$XDG_DATA_HOME/profile.local"
fi
