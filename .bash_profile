[ -f ~/.profile ] && . ~/.profile

export HISTCONTROL=ignoreboth:erasedups
export HISTIGNORE='ls:lc:cd:pwd:bg:fg:history'
export HISTSIZE=5000
export HISTFILESIZE=10000

case "$-" in
  *i*) . ~/.bashrc
esac
