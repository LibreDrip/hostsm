#!/usr/bin/env sh

# mac OS (until 10.14.x macOS Mojave), iOS, Android, Linux: /etc/hosts
# Windows: %SystemRoot%\system32\drivers\etc\hosts
# hosts file MacOS Catalania /private/etc/hosts
# hostsm config dir: ~/.config/hostm/

usage()
{
    echo "No options were passed.";
    echo
    echo "SYNOPSIS:"
    echo
    echo "hostsm [Option ...] FILE"
    echo
    echo "OPTIONS:"
    echo
    echo -e "-l, --list \t lists all available hosts files"
    echo -e "-f, --file FILE \t symlinks the selected file to /etc/hosts and overwrite old one"
    echo
    echo "Github page:"

    exit 1
}

# _hostsm () {
#     case $COMP_CWORD in
#         1) COMPREPLY=( $(compgen -W "staandda sooos" "$2") ) ;;
#         2) local IFS=$'\n'
#            COMPREPLY=( $(cd ~/.config/hostsm && compgen -d "$2") ) ;;
#     esac
# }

# complete -F _hostsm hostsm

# check if the user is running mac os catalania

# if [ -f /private/etc/hosts]
# then
# else
# fi

# everybody else

# detect home directory when called with sudo

#USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
#echo $USER_HOME

if [ -d ~/.config/hostsm ] #check if config folder exists
then
    cd ~/.config/hostsm
    CONFIGDIR=~/.config/hostsm
else
    echo "Config Folder created"
    mkdir ~/.config/hostsm
fi


if [ $# -eq 0 ]; #if no option is passed
then
    usage
fi

while :; do
    case $1 in
        -l|--list)
	    echo "$(ls)"
	    ;;
	-f|--file)       # Takes an option argument; ensure it has been specified.
            if [ "$2" ]; then
		input=$2
		if [ -f $input ] #check if file is empty
		then

		    # file="
		    # echo "$(find $CONFIGDIR -name 'input')"
		    # echo $CONFIGDIR

		    find $CONFIGDIR -name $input | while read line; do

			echo $line
			sudo ln -s -f $line /etc/hosts
			# sudo ln -s -f $file /private/etc/hosts
		        # -s symbolic
		        # -f force (remove file)
			
			echo "Symlink created"					
		    done
		    
		    # echo $file
		    
		    exit
		else
		    echo "Empty or non Existant File."
		    exit
		fi
		shift
            else
                echo 'ERROR: "--file" requires a non-empty option argument.'
            fi
            ;;
        --file=?*)
            file=${1#*=} # Delete everything up to "=" and assign the remainder.
            ;;
        --file=)         # Handle the case of an empty --file=
        echo 'ERROR: "--file" requires a non-empty option argument.'
        ;;
        -?*)
            printf 'WARN: Unknown option (ignored): %s\n' "$1" >&2
            ;;
        *)               # Default case: No more options, so break out of the loop.
	    break
    esac

    shift
done

