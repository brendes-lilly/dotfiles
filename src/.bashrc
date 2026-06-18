[[ $- != *i* ]] && return
[[ -r $HOME/.shrc ]] && . $HOME/.shrc

HISTFILE=$XDG_STATE_HOME/bash_history
HISTIGNORE='ls:lc:pwd:bg:fg:history'
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
	f=${EMACS_VTERM_PATH:+$EMACS_VTERM_PATH/etc/emacs-vterm-bash.sh}
	[ -r "$f" ] && . "$f"
	unset f
esac

if ! shopt -oq posix; then
	f=${HOMEBREW_PREFIX:+$HOMEBREW_PREFIX/etc/profile.d/bash_completion.sh}
	f=${f:-/usr/share/bash-completion/bash_completion}
	[ -r "$f" ] && . "$f"
	unset f
fi
