[ -r $HOME/.profile ] && . $HOME/.profile

HISTFILE=$XDG_STATE_HOME/bash_history
HISTIGNORE='ls:lc:pwd:bg:fg:history'
HISTFILESIZE=$HISTSIZE
HISTTIMEFORMAT="%F %T "
shopt -s histappend

case $TERM in
dumb) ;;
*)
	bind -m emacs 'TAB:menu-complete'
	bind -m emacs '"\e[Z":menu-complete-backward'
	bind -m vi-insert 'TAB:menu-complete'
	bind -m vi-insert '"\e[Z":menu-complete-backward'
	bind -m vi-command '"\C-l": clear-screen'
	bind -m vi-insert '"\C-l": clear-screen'
	bind 'set show-all-if-ambiguous on'
	bind 'set menu-complete-display-prefix on'
esac

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
