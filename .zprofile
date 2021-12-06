if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	exec startx
fi

export PATH="$PATH:~/.local/bin"

# Created by `userpath` on 2021-11-19 11:51:04
export PATH="$PATH:/home/alex/.local/bin"
