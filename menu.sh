#!/bin/bash

PS3='Choose an option: '
options=("SYSTEM" "MANAGEMENT" "INSTALLATION" "BACKUP" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "SYSTEM")
            echo "you chose $REPLY which is $opt"
            ;;
        "MANAGEMENT")
            echo "you chose $REPLY which is $opt"
            ;;
        "INSTALLATION")
            echo "you chose choice $REPLY which is $opt"
            ;;
        "BACKUP")
            echo "you chose choice $REPLY which is $opt"
            ;;            
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done