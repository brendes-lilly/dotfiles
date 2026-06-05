if shopt -q login_shell && [[ $- == *i* ]]; then
	. $HOME/.bashrc
else
	. $HOME/.profile
fi
