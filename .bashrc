[ -f ~/.profile ] && . ~/.profile
[ -f $ENV ] && . $ENV

HISTTIMEFORMAT="%F %T "
shopt -s histappend
shopt -s checkwinsize
shopt -s nocaseglob
shopt -s cdspell
shopt -s autocd
bind '\C-w:unix-filename-rubout'
bind 'set show-all-if-ambiguous on'
stty werase undef

h () { [ $# -eq 0 ] && history 1 || history 1 | grep -i --color "$1"; }

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  PS1='\[\033[90m\]\w \[\033[0;1m\]$(__git_info)\[\033[0m\]\[\033[90m\]\n\$\[\033[0m\] '
else
  PS1='\[\033[90m\]\h:\w \[\033[0;1m\]$(__git_info)\[\033[0m\]\[\033[90m\]\n\$\[\033[0m\] '
fi

# Check if the terminal is xterm
if [[ "$TERM" == "xterm" ]]; then
  preexec() {
    local cmd="${BASH_COMMAND}"
    echo -ne "\033]0;${USER}@${HOSTNAME}: ${cmd}\007"
  }
  # reset title after command is executed
  precmd() {
    echo -ne "\033]0;${USER}@${HOSTNAME}: ${SHELL}\007"
  }
  trap 'preexec' DEBUG
  PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND; }precmd"
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
  elif [ -r /usr/local/etc/profile.d/bash_completion.sh ]; then
  . /usr/local/etc/profile.d/bash_completion.sh
  fi
fi

