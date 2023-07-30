#!/bin/bash

sm1() {
    echo -ne "
 SYSTEM SUBMENU
1 - UPDATES
2 - Go Back to Main Menu
0 - Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        echo "you have selected updates"
        sm1
        ;;
    2)
        menu
        ;;
    3)
        echo "Bye bye."; exit 0;
        ;;
    *)
        echo "Wrong option,try again." exit 1;
        ;;
    esac
}


menu() {
    echo -ne "
    WELCOME TO MAIN MENU
1 - SYSTEM
0 - Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        sm1
        menu
        ;;

    0)
        echo "Bye bye."; exit 0;
        ;;
    *)
        echo "Wrong option,try again." exit 1;
        ;;
    esac
}

menu