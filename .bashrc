# -*- mode: shell-script; -*-
# vim: ft=bash

[[ -r ~/.profile ]] && . ~/.profile

HISTFILE=$HOME/.local/state/bash_history
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE='ls:lc:cd:pwd:bg:fg:history'
HISTFILESIZE=$HISTSIZE
HISTTIMEFORMAT="%F %T "
shopt -s histappend
shopt -s checkwinsize
shopt -s cdspell

case $INSIDE_EMACS in
vterm)
    [ -n "${EMACS_VTERM_PATH-}" ] &&
        [ -r "${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh" ] &&
        . "${EMACS_VTERM_PATH}/etc/emacs-vterm-bash.sh"
    ;;
esac

if ! shopt -oq posix; then
    for f in \
        /usr/share/bash-completion/bash_completion \
        /etc/bash_completion \
        /etc/profile.d/bash_completion.sh \
        /usr/local/etc/profile.d/bash_completion.sh \
        /opt/homebrew/etc/profile.d/bash_completion.sh; do
        [ -r $f ] && . "$f" && break
    done
fi
