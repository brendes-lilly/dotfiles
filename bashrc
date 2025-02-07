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

# hideous function from github
__git_info() {
  if [ "$(git config --get devcontainers-theme.hide-status 2>/dev/null)" != 1 ] && [ "$(git config --get codespaces-theme.hide-status 2>/dev/null)" != 1 ]; then
    BRANCH="$(git --no-optional-locks symbolic-ref --short HEAD 2>/dev/null || git --no-optional-locks rev-parse --short HEAD 2>/dev/null)"
    if [ "${BRANCH:-}" != "" ]; then
      printf "[%s" "${BRANCH}"
      if [ "$(git config --get devcontainers-theme.show-dirty 2>/dev/null)" = 1 ] && \
        git --no-optional-locks ls-files --error-unmatch -m --directory --no-empty-directory -o --exclude-standard ":/*" > /dev/null 2>&1; then
        printf " ✗"
      fi
      printf "] "
    fi
  fi
  unset -f __gitinfo
}

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  PS1='\[\033[90m\]\h:\w \[\033[0;1m\]$(__git_info)\[\033[0m\]\[\033[90m\]\n\$\[\033[0m\] '
else
  PS1='\[\033[90m\]\w \[\033[0;1m\]$(__git_info)\[\033[0m\]\[\033[90m\]\n\$\[\033[0m\] '
fi

# Check if the terminal is xterm
if [[ "$TERM" == "xterm" ]]; then
  # Function to set the terminal title to the current command
  preexec() {
    local cmd="${BASH_COMMAND}"
    echo -ne "\033]0;${USER}@${HOSTNAME}: ${cmd}\007"
  }

  # Function to reset the terminal title to the shell type after the command is executed
  precmd() {
    echo -ne "\033]0;${USER}@${HOSTNAME}: ${SHELL}\007"
  }

  # Trap DEBUG signal to call preexec before each command
  trap 'preexec' DEBUG

  # Append to PROMPT_COMMAND to call precmd before displaying the prompt
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

