# -*- mode: shell-script; -*-
# vim: ft=bash

[ -r ~/.profile ] && . ~/.profile

HISTFILE=$XDG_STATE_HOME/bash_history
HISTIGNORE='ls:lc:pwd:bg:fg:history'
HISTFILESIZE=$HISTSIZE
HISTTIMEFORMAT="%F %T "
shopt -s histappend

case $INSIDE_EMACS in
vterm)
    [ -n "${EMACS_VTERM_PATH-}" ] &&
        [ -r "${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh" ] &&
        . "${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh"
    ;;
esac

if [ "$HOMEBREW_PREFIX" ] && ! shopt -oq posix; then
	f=$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh
	[ -r $f ] && . $f
fi
