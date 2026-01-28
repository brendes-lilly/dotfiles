[ -r $HOME/.profile ] && . $HOME/.profile
HISTFILE=$XDG_STATE_HOME/zsh_history
SAVEHIST=$HISTSIZE

setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_verify
setopt inc_append_history
setopt prompt_subst
setopt interactive_comments

autoload -z edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey -M vicmd '_' insert-last-word
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^U' backward-kill-line

autoload -Uz compinit
compinit

case $TERM in
dumb|eterm-color)
	unsetopt PROMPT_CR PROMPT_SP
	unset zle_bracketed_paste
esac

case $INSIDE_EMACS in
vterm)
    vterm_prompt_notify() {
        printf "\e]51;Eprompt\e\\"
    }
    add-zsh-hook -d precmd
    add-zsh-hook precmd vterm_prompt_notify
    PROMPT="%# "
    [ -n "${EMACS_VTERM_PATH-}" ] &&
        [ -r "${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh" ] &&
        . "${EMACS_VTERM_PATH}/etc/emacs-vterm-zsh.sh"
    ;;
*,eat)
    [ -n "$EAT_SHELL_INTEGRATION_DIR" ] && \
        source "$EAT_SHELL_INTEGRATION_DIR/zsh"
    ;;
esac
