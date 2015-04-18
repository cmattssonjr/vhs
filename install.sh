#!/usr/bin/env bash
# Simple default installation:
# This script is ment to help and comes without any promise or warranty.
# -----------------------
#
# 	Variables
#
	APP=vhs
	DIR_BIN=$HOME/.local/bin
	DIR_ROOT=/usr/bin
	DIR_MAN=/usr/share/man
	DIR_COMPL=/etc/bash_completion.d
	EXE="$APP.sh"
	MAN="$APP.1"
	COMPL="${APP}_compl.bash"
#
#	Action & Display
#
	echo "It is recomended to use the rpm installation"
	
	
	[ ! -f "$EXE" ] && \
		echo "$EXE not found, you are not in the proper directory." && \
		exit 1
	if [ $UID -ne 0 ]
	then	# It is a regular user
		echo "Install for your self or system wide?"
		select task in myself system;do break;done
		case $task in
		myself)		set -x
				mkdir -p $DIR_BIN $HOME/.local/share/man/man1 $HOME/.local$DIR_COMPL
				mv $EXE $DIR_BIN/$APP
				mv $MAN $HOME/.local/share/man/man1/
				mv $COMPL $HOME/.local$DIR_COMPL/
				exit $?
				set +x
				;;
		system)		echo "Please restart the script as root."
				exit 0
				;;
		esac
	elif [ $UID -eq 0 ]
	then	# User is root, system wide installation
		mv "$APP.sh" 	"$DIR_ROOT/$APP"
		mv "$MAN"	"$DIR_MAN/man1/"
		mv "$COMPL"	"$DIR_COMPL"
		exit $?
	fi