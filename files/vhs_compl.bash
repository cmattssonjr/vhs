#!/usr/bin/env bash
# bash completition for Video Handler Script (VHS)
# file: /etc/bash_completion.d/vhs_compl.bash
# 2014.11.29 by sea
# ---------------------------------
function _vhs_module()
{
#
#	Variables
#
	local cur prev OPTS DIR audio_codecs video_codecs sub_codecs
	COMPREPLY=()
	cur="${COMP_WORDS[COMP_CWORD]}"
	prev="${COMP_WORDS[COMP_CWORD-1]}"
	OPTS="-2 -a -A -b -B -c -C -d -D -e -f -F -G -i -I -j -J -K -l -L -p -q -Q -r -R -S -t -T -v -V -x -X -y -z"
	CONTAINER="$HOME/.config/vhs/container"
	containers=$(grep -v "#" $CONTAINER|awk '{print $1}')
	#echo $containers ; return
	langs="ara bul chi cze dan eng fin fre ger hin hun ice nor pol rum spa srp slo slv swe tur"
	audio_rates="a96 a128 a192 a256 a384 a512 a768 a1024"
	video_rates="v256 v384 v512 v768 v1024 v1280 v1664 v1792 v2048 v3072 v4096"
	pip="tl tc tr cl cc cr bl bc br"
	presets="$(grep -v "#" $HOME/.config/vhs/presets|awk '{print $1}'|sed s,scrn,,)"
#
#	Fill codec lists
#
	source ~/.config/vhs/vhs.list
	for a in $codecs_audio;do audio_codecs+=" a$a";done
	for v in $codecs_video;do video_codecs+=" v$v";done
	for s in $codecs_subtitle;do sub_codecs+=" t$s";done
#
#	Action
#
	# This completes the custom entries from $DIR
	# But only use this, if 'prev' was one using entries from $DIR
	# This list is dynamicly (automaticly) updated
	case $prev in
	-[2aABFiJRtvVy)
		# Continue file-read for any non-optarg option
		# Or options that require a file as argument
		COMPREPLY=( $(compgen -f -- $cur) )
		return 0
		;;
	-b)
		case "$cur" in
		a*)		COMPREPLY=( $( compgen -W "$(echo $audio_rates|grep ${cur:1}*)" -- "$cur" ) ) 
				return 0
				;;
		v*)		COMPREPLY=( $( compgen -W "$(echo $video_rates|grep ${cur:1}*)" -- "$cur" ) ) 
				return 0
				;;
		esac
		;;
	-c)
		case "$cur" in
		a*)
				COMPREPLY=( $( compgen -W "$audio_codecs" -- "$cur" ) ) 
				return 0
				;;
		v*)		COMPREPLY=( $( compgen -W "$video_codecs" -- "$cur" ) ) 
				return 0
				;;
		t*)		COMPREPLY=( $( compgen -W "$sub_codecs" -- "$cur" ) ) 
				return 0
				;;
		"")		COMPREPLY=( $( compgen -W "a t v" -- "$cur" ) ) 
				return 0
				;;
		esac
		;;
	-e)	if [ -z "$cur" ]
		then	COMPREPLY=( $( compgen -W "$(echo $containers)" -- "$cur" ) )
		else	COMPREPLY=( $( compgen -W "$(echo $containers|grep $cur)" -- "$cur" ) ) 
		fi
		return 0
		;;
	-l)	if [ -z "$cur" ]
		then	COMPREPLY=( $( compgen -W "$(echo $langs)" -- "$cur" ) )
		else	COMPREPLY=( $( compgen -W "$(echo $langs|grep $cur)" -- "$cur" ) ) 
		fi
		return 0
		;;
	-p)	if [ ! -z "$cur" ]
		then	case "${cur:0:2}" in
			[tcb][lcr])
				COMPREPLY=( $( compgen -W "$(echo ${cur:0:2}240 ${cur:0:2}360 ${cur:0:2}480 ${cur:0:2}512 ${cur:0:2}640 ${cur:0:2}720|grep $cur*)" -- "$cur" ) ) 
				return 0
				;;
			*)
				COMPREPLY=( $( compgen -W "$(echo $pip|grep $cur)" -- "$cur" ) ) 
				return 0
				;;
			esac
		else	COMPREPLY=( $( compgen -W "tl tc tr cl cc cr bl bc br" -- "$cur" ) ) 
			return 0
		fi
		;;
	-[qQ])	if [ -z "$cur" ]
		then	COMPREPLY=( $( compgen -W "$(echo $presets)" -- "$cur" ) )
		else	COMPREPLY=( $( compgen -W "$(echo $presets|grep $cur)" -- "$cur" ) ) 
		fi
		return 0
		;;
	esac
	
	# This completes the word you are currently writing
	# These need manual maintainance
	case "$cur" in
	-*)	COMPREPLY=( $(compgen -W "${OPTS[*]}" -- $cur) )
		return 0
		;;
	[atv]*)	case "$prev" in
		-c)	
			case "$cur" in
			a*)	COMPREPLY=( $( compgen -W "$(echo $audio_codecs|grep $cur*)" -- "$cur" ) ) 
				return 0
				;;
			v*)	COMPREPLY=( $( compgen -W "$(echo $codecs_video|grep ${cur:1}*)" -- "$cur" ) ) 
				return 0
				;;
			t*)	COMPREPLY=( $( compgen -W "$(echo $sub_codecs|grep $cur*)" -- "$cur" ) ) 
				return 0
				;;
			esac
			;;
		-[aiJ]|*)
			COMPREPLY=( $(compgen -f -- $cur) )
			return 0
			;;
		esac
		;;
	esac
	
	# This shows a list of words applying to your last argument
	# These need manual maintainance
	case "$prev" in
		-a|-i)
			COMPREPLY=( $(compgen -f -- $cur) )
			return 0
			;;
		#vhs|vhs.sh)
		#	COMPREPLY=( $(compgen -W "calc ip build-ffmpeg" -f -- $cur) )
		#	return 0
		#	;;
		-b)	COMPREPLY=( $(compgen -W "a v" -- $cur) )
			return 0
			;;
		-c)	COMPREPLY=( $(compgen -W "a v t" -- $cur) )
			return 0
			;;
		-d)	COMPREPLY=( $( compgen -W "todo +0.5db 50% 200%" -- "$cur" ) ) 
			return 0
			;;
		-e)	COMPREPLY=( $( compgen -W "$(echo $containers | grep $cur*)" -- "$cur" ) ) 
			return 0
			;;
		-f)	COMPREPLY=( $( compgen -W "23.9 24 25 26 29 29.9 33 48 50 60 75 100" -- "$cur" ) ) 
			return 0
			;;
		-l)	COMPREPLY=( $(compgen -W "$(echo $langs)" -- $cur) )
			return 0
			;;
		-p)	COMPREPLY=( $(compgen -W "bl br bc cl cr cc tl tr tc" -- $cur) )
			return 0
			;;
		-q|-Q)	COMPREPLY=( $( compgen -W "$presets" -- "$cur" ) ) 
			return 0
			;;
		-r)	COMPREPLY=( $(compgen -W "41000 44000 96000" -- $cur) )
			return 0
			;;
		-z)	COMPREPLY=( $( compgen -W "0:01-1:23:45.99" -- "$cur" ) ) 
			return 0
			;;
		-h)	return 0
			;;
	esac
}
# Actualy make it available to the shell
# Cover with and without extension
complete -F _vhs_module vhs
complete -F _vhs_module vhs.sh