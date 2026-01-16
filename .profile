# vim: ft=sh

export H="$(uname -n)"
export OS=$(uname | tr '[:upper:]' '[:lower:]')
export ARCH=$(uname -m)

export PLAN9=$HOME/opt/plan9
export GOPATH=$HOME/opt/go
export RUSTUP_HOME=$HOME/opt/rust/rustup
export CARGO_HOME=$HOME/opt/rust/cargo
for dir in \
	/opt/homebrew/bin \
	$CARGO_HOME/bin \
	$GOPATH/bin \
	$HOME/usr/bin/p9p \
	$HOME/usr/bin/vc \
	$HOME/usr/bin/bio \
	$HOME/usr/bin \
	$HOME/usr/bin/$ARCH \
	$HOME/usr/bin/$OS \
	$HOME/bin
do
	[ -d "$dir" ] && case ":$PATH:" in
		*":$dir:"*) ;;
		*) PATH="$dir:$PATH" ;;
	esac
done
[ -d "$PLAN9/bin" ] && PATH="$PATH:$PLAN9/bin"
export PATH

if command -v vim >/dev/null 2>&1; then
    export EDITOR=vim
else
    export EDITOR=vi
fi
export VISUAL=$EDITOR
export FCEDIT=$EDITOR
export ENV="$HOME/.kshrc"

export NO_COLOR=1
export AV_LOG_FORCE_NOCOLOR=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_INSECURE_REDIRECT=1
export NODE_NO_READLINE=1
export FZF_DEFAULT_OPTS="--gutter=' ' --style=minimal --info=inline-right \
	--layout=reverse --no-bold --no-unicode --no-color --color=fg+:-1,hl+:-1 \
	--prompt=': '"

[ "$TERMUX_VERSION" ] &&
	case "$(getprop ro.product.brand 2>/dev/null)" in
		Onyx) export EINK=1 ;;
	esac

case $TERM in
dumb|eterm-color|linux) _notitle=1 ;;
*) [ -z "$TMUX" ] && [ "$TERMUX_VERSION" ] && _notitle=1 ;;
esac

_gitp() {
	b=$(gitstat 2>/dev/null)
	test -n "$b" && printf ' [%s]' "$b"
}

if [ "$SSH_CONNECTION" ] || [ "$CODESPACES" ]; then
	P='${USER}@${H}:~${PWD#$HOME}$(_gitp)'
else
	P='~${PWD#$HOME}$(_gitp)'
fi

if [ "$_notitle" ]; then
	PS1="$P \$ "
	PROMPT="$P %# "
else
	PS1='\[\e]0;'"$P"'\a\]\$ '
	PROMPT=$'%{\e]0;'"$P"$'\a%}%# '
fi
unset _notitle

if command ls --color=never /dev/null >/dev/null 2>&1; then
    _ls() { LC_COLLATE=C command ls --color=never "$@"; }
else
    _ls() { LC_COLLATE=C command ls "$@"; }
fi
alias cd='cd -P'
alias ..='cd ..'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias ls='_ls -1AF'
alias lc='_ls -AF'
alias ll='_ls -AFl'
alias lt='_ls -AFltr'
alias l=lc
alias v=$EDITOR
alias view="$EDITOR -R"

case $TERM in
dumb|eterm-color)
    [ -n "$INSIDE_EMACS" ] && stty -echo
    unset FCEDIT VISUAL
    export GIT_PAGER=cat
    set +o emacs +o vi
    alias git='git -c color.ui=never'
	if [ "$termprog" ] || [ "$winid" ]; then
		export EDITOR=E
		export PAGER=p
		export GIT_PAGER=$PAGER
		cdawd() { cd -P "$@" && awd; }
		alias cd=cdawd
		alias lc='lc -F'
	fi
    ;;
esac

HISTSIZE=100000
[ -r $HOME/.profile.local ] && . $HOME/.profile.local

