#!/bin/bash

ssm1() {
    echo -ne "
    UPDATE SYSTEM SUBMENU
1 - UPDATE
2 - UPGRADE
3 - Go Back to SYSTEM SUBMENU
4 - Go Back to MAIN MENU
0 - Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        sudo apt update
        ssm1
        ;;
    2)
        sudo apt upgrade
        ssm1
        ;;
    3)
        sm1
        ;;
    4)
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
        ssm1
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