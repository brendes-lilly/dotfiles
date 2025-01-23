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

PS1='\[$(tput setaf 8)\]\h:\w\n\[$(tput sgr0)\]\$ '

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -r /usr/local/etc/profile.d/bash_completion.sh ]; then
    . /usr/local/etc/profile.d/bash_completion.sh
  fi
fi
