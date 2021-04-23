if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

export PATH="$PATH:~/.local/bin"
