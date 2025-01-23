export ENV=$HOME/dotfiles/rc
export EDITOR=v
export VISUAL=$EDITOR
export GREP_COLOR='30;103'
export GREP_COLORS='mt=30;103'

OS=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
PATH=$HOME/etc/bin/$OS:$HOME/etc/bin/$ARCH:$HOME/etc/bin:$HOME/etc/bin/acme:$HOME/bin:$GOPATH/bin:$PATH
export PATH

case $TERM in
  dumb)
    unset FCEDIT VISUAL
    ;;
esac
