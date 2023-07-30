#!/bin/bash

ESC=$(printf '\033') RESET="${ESC}[0m" BLACK="${ESC}[30m" RED="${ESC}[31m"
GREEN="${ESC}[32m" YELLOW="${ESC}[33m" BLUE="${ESC}[34m" MAGENTA="${ESC}[35m"
CYAN="${ESC}[36m" WHITE="${ESC}[37m" DEFAULT="${ESC}[39m"
###############################################################################################

whiteprint() { printf "${WHITE}%s${RESET}\n" "$1"; }
greenprint() { printf "${GREEN}%s${RESET}\n" "$1"; }
blueprint() { printf "${BLUE}%s${RESET}\n" "$1"; }
redprint() { printf "${RED}%s${RESET}\n" "$1"; }
yellowprint() { printf "${YELLOW}%s${RESET}\n" "$1"; }
magentaprint() { printf "${MAGENTA}%s${RESET}\n" "$1"; }
cyanprint() { printf "${CYAN}%s${RESET}\n" "$1"; }
###############################################################################################

fn_update() { echo; sudo apt update; }
fn_upgrade() { echo; sudo apt upgrade; }
fn_quit() { echo "Bye bye."; exit 0; }
fn_wrong() { echo "Wrong option,try again." exit 1; }

ssm1() {
    echo -ne "
$(greenprint 'UPDATE SYSTEM SUBMENU')
$(greenprint '1)') UPDATE
$(greenprint '2)') UPGRADE
$(cyanprint '3)') Go Back to SYSTEM SUBMENU
$(magentaprint '4)') Go Back to MAIN MENU
$(redprint '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        fn_update
        ssm1
        ;;
    2)
        fn_upgrade
        ssm1
        ;;
    3)
        sm1
        ;;
    4)
        menu
        ;;
    0)
        fn_quit
        ;;
    *)
        fn_wrong
        ;;
    esac
}

sm1() {
    echo -ne "
$(greenprint 'SYSTEM SUBMENU')
$(greenprint '1)') UPDATES
$(magentaprint '2)') Go Back to Main Menu
$(redprint '0)') Exit
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
    0)
        fn_quit
        ;;
    *)
        fn_wrong
        ;;
    esac
}

menu() {
    echo -ne "
$(magentaprint 'WELCOME TO MAIN MENU')
$(greenprint '1)') SYSTEM
$(redprint '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        sm1
        menu
        ;;

    0)
        fn_quit
        ;;
    *)
        fn_wrong
        ;;
    esac
}

menu