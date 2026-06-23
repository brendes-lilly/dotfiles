[[ -f $HOME/.profile ]] && . $HOME/.profile

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh_history"
setopt inc_append_history
setopt prompt_subst
setopt interactive_comments
autoload -Uz compinit &&
	compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

case $TERM in
xterm*|tmux*)
	autoload -z edit-command-line
	zle -N edit-command-line
	bindkey -M vicmd v edit-command-line
	bindkey -M vicmd '_' insert-last-word
	bindkey -M viins '^?' backward-delete-char
	bindkey -M viins '^H' backward-delete-char
	bindkey -M viins '^W' backward-kill-word
	bindkey -M viins '^U' backward-kill-line
	PROMPT=$'%{\e]0;'"${P:+$P:}"'$(_gitinfo)'$'\a%}'"${L:+$L }"'%# '
	;;
dumb)
	unsetopt zle prompt_cr prompt_sp
	;;
*)
	PROMPT="$P"'%~$(_gitinfo) %# '
esac

case $INSIDE_EMACS in
*comint)
	PROMPT=$(printf '\033]0;$(_gitinfo)\007\033]7;file://%%m%%~\007%%# ')
	;;
vterm)
	vterm_prompt_notify() {
		printf "\e]51;	Eprompt\e\\"
	}
	autoload -Uz add-zsh-hook
	add-zsh-hook -d precmd vterm_prompt_notify
	add-zsh-hook precmd vterm_prompt_notify
	f=${EMACS_VTERM_PATH:+$EMACS_VTERM_PATH/etc/emacs-vterm-zsh.sh}
	[ -r "$f" ] && . "$f"
	unset f
	PROMPT='%# '
esac

