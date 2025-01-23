[ -f $ENV ] && . $ENV

typeset -g HISTFILESIZE=1000000
typeset -g HISTSIZE=1000000
typeset -g HISTORY_IGNORE="(ls|cd|pwd|exit)*"
typeset -g HIST_STAMPS="yyyy-mm-dd"
setopt extended_history     # write the history file in the ':start:elapsed;command' format
setopt inc_append_history   # write to the history file immediately, not when the shell exits
setopt share_history        # share history between all sessions
setopt hist_ignore_dups     # do not record an event that was just recorded again
setopt hist_ignore_all_dups # delete an old recorded event if a new event is a duplicate
setopt hist_ignore_space    # do not record an event starting with a space
setopt hist_save_no_dups    # do not write a duplicate event to the history file
setopt hist_verify          # do not execute immediately upon history expansion
setopt append_history       # append to history file (default)
setopt hist_no_store        # don't store history commands
setopt hist_reduce_blanks   # remove superfluous blanks from each command line being added to the history list

setopt prompt_subst
setopt correct
setopt auto_cd
setopt interactive_comments

# speed up shell startup: only run full compinit if it's been 24 hours since the
# dumpfile was last opened
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

autoload -Uz select-word-style
select-word-style bash
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
bindkey -M vicmd v edit-command-line
bindkey -e

h () { [ $# -eq 0 ] && history -i 1 || history -i 1 | grep -i --color "$1"; }

PROMPT='%F{8}$=%M:%~'' '$'\n''%#%f '

case $TERM in
  dumb)
    unset zle_bracketed_paste
    unsetopt prompt_cr
    unsetopt prompt_sp
  ;;
esac
