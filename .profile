export ENV=$HOME/.rc
export EDITOR=v
export VISUAL=$EDITOR
export GREP_COLOR='30;103'
export GREP_COLORS='mt=30;103'

OS=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
PATH=$HOME/bin/$OS:$HOME/bin/$ARCH:$HOME/bin:$PATH
export PATH

case $TERM in
  dumb)
    unset FCEDIT VISUAL
    ;;
esac
