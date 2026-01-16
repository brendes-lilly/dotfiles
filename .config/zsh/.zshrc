# -*- mode: shell-script; -*-
# vim: ft=zsh

[ -r $HOME/.profile ] && . $HOME/.profile

HISTFILE=$HOME/.local/state/zsh_history
typeset -gi HISTSIZE=$HISTSIZE
typeset -gi SAVEHIST=100000
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_verify
setopt inc_append_history

setopt prompt_subst
setopt correct
setopt interactive_comments

autoload -Uz compinit
compinit

case $INSIDE_EMACS in
vterm)
    vterm_prompt_notify() {
        printf "\e]51;Eprompt\e\\"
    }
    add-zsh-hook -d precmd precmd_gitbranch
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
