[[ -f $HOME/.profile ]] && . $HOME/.profile

HISTFILE="${XDG_STATE_HOME}/zsh/history"
setopt inc_append_history
setopt interactive_comments
setopt prompt_subst
autoload -Uz compinit
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
	PROMPT=$'%{\e]0;'${pinfo}$'\a%}'${psuf}
	;;
dumb)
	unsetopt zle prompt_cr prompt_sp
	PROMPT=$PS1
	;;
*)
	PROMPT=$PS1
esac

case $INSIDE_EMACS in
*comint)
	PROMPT=$(printf '\033]0;$(_pwdinfo)\007\033]7;file://%%m%%~\007${psuf}')
	;;
vterm)
	f=${EMACS_VTERM_PATH:+$EMACS_VTERM_PATH/etc/emacs-vterm-zsh.sh}
	if [ -r "$f" ]; then
		. "$f"
		# 51;A syncs cwd so default-directory (and the git status the
		# mode line reads from it) tracks the shell.
		PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
	fi
	unset f
	# 51;E prompt refreshes git status within a directory, where
	# vterm-directory-change-hook alone would go stale.
	vterm_prompt_notify() { printf '\e]51;Eprompt\e\\'; }
	autoload -Uz add-zsh-hook
	add-zsh-hook -d precmd vterm_prompt_notify
	add-zsh-hook precmd vterm_prompt_notify
esac
