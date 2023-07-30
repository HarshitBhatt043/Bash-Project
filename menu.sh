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
fn_both() { echo; sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y; }
fn_useradd() { echo; read -p "Enter the number of users to create: " num_users
for (( i=1; i<=$num_users; i++ ))
do
    read -p "Enter username for user $i: " username
    read -p "Enter password for user $i: " password
    sudo useradd -m $username
    echo "$username:$password" | sudo chpasswd
    grep -w "^$username" /etc/passwd
    echo "User account $username created successfully!"
done ; }
fn_userdel() { echo; read -p "Enter the number of users to delete: " num_users
for (( i=1; i<=$num_users; i++ ))
do
    read -p "Do you know the username for user $i: ,if yes press 1 " yes
    if [ $yes -eq 1 ]
    then
        read -p "Enter username for user $i: " username
        sudo userdel -r $username
        echo "User account $username deleted  successfully!"
    else
        echo "All Users In System Are Listed Below"
        echo ""
        echo ""
        awk -F":" '{print $1}' /etc/passwd | sed -e 'N;N;N;N;s/\n/ /g'
        read -p "Enter username from above for user $i: " username
        sudo userdel -r $username
        echo "User account $username deleted  successfully!"
    fi
done ; }
fn_groupadd() { echo; read -p "Enter the number of groups to create: " num_groups
for (( i=1; i<=$num_groups; i++ ))
do
    read -p "Enter groupname for group $i: " groupname
    sudo groupadd $groupname
    grep -w "^$groupname" /etc/group
    echo "User group $groupname created successfully!"
done ; }
fn_groupdel() { echo; read -p "Enter the number of groups to delete: " num_groups
for (( i=1; i<=$num_groups; i++ ))
do
    read -p "Do you know the groupname for group $i: ,if yes press 1 " yes
    if [ $yes -eq 1 ]
    then
        read -p "Enter groupname for group $i: " groupname
        echo "Primary user of this group will be deleted"
        read -rsn1 -p"Press any key to continue";echo
        sudo userdel -r $groupname
        sudo groupdel $groupname
        echo "User group $groupname deleted  successfully!"
    else
        echo "All Groups In System Are Listed Below"
        echo ""
        echo ""
        awk -F":" '{print $1}' /etc/group | sed -e 'N;N;N;N;s/\n/ /g'
        read -p "Enter groupname from above for group $i: " groupname
        echo "Primary user of this group will be deleted"
        read -rsn1 -p"Press any key to continue";echo
        sudo userdel -r $groupname
        sudo userdel -r $groupname
        echo "User group $groupname deleted  successfully!"
    fi
done ; }
fn_docker() { echo; echo "This will install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin"
                    read -rsn1 -p"Press any key to continue";echo
                    echo "Installation started"
                    for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do sudo apt-get remove $pkg; done
                    sudo apt-get update
                    sudo apt-get install ca-certificates curl gnupg
                    sudo install -m 0755 -d /etc/apt/keyrings
                    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
                    sudo chmod a+r /etc/apt/keyrings/docker.gpg
                    echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
                    sudo apt-get update
                    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
                    echo "Installation completed"
                    sudo docker --version
                    sudo docker compose version
                    echo "Adding $USER to docker group "
                    sudo usermod -aG docker $USER ; }
fn_quit() { echo "Bye bye."; exit 0; }
fn_wrong() { echo "Wrong option,try again." exit 1; }
###############################################################################################

ssm1() {
    echo -ne "
$(greenprint 'UPDATE SYSTEM SUBMENU')
$(greenprint '1)') UPDATE
$(greenprint '2)') UPGRADE
$(greenprint '3)') UPDATE,UPGRADE AND AUTOREMOVE UNUSED
$(cyanprint '4)') Go Back to SYSTEM SUBMENU
$(magentaprint '5)') Go Back to MAIN MENU
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
        fn_both
        ssm1
        ;;
    4)
        sm1
        ;;
    5)
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

ssm2() {
    echo -ne "
$(blueprint 'USER MANAGEMENT SUBMENU')
$(blueprint '1)') ADD USERS
$(blueprint '2)') DELETE USERS
$(cyanprint '3)') Go Back to MANAGEMENT SUBMENU
$(magentaprint '4)') Go Back to MAIN MENU
$(redprint '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        fn_useradd
        ssm2
        ;;
    2)
        fn_userdel
        ssm2
        ;;
    3)
        sm2
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

ssm3() {
    echo -ne "
$(blueprint 'GROUP MANAGEMENT SUBMENU')
$(blueprint '1)') ADD GROUPS
$(blueprint '2)') DELETE GROUPS
$(cyanprint '3)') Go Back to MANAGEMENT SUBMENU
$(magentaprint '4)') Go Back to MAIN MENU
$(redprint '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        fn_groupadd
        ssm3
        ;;
    2)
        fn_groupdel
        ssm3
        ;;
    3)
        sm2
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

ssm4() {
    echo -ne "
$(whiteprint 'SCRIPTS INSTALLATION SUBMENU')
$(whiteprint '1)') FULL DOCKER
$(cyanprint '2)') Go Back to MANAGEMENT SUBMENU
$(magentaprint '3)') Go Back to MAIN MENU
$(redprint '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        fn_docker
        ssm4
        ;;
    3)
        sm3
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
###############################################################################################

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

sm2() {
    echo -ne "
$(blueprint 'MANAGEMENT SUBMENU')
$(blueprint '1)') USER
$(blueprint '2)') GROUP
$(blueprint '3)') NETWORK
$(magentaprint '4)') Go Back to Main Menu
$(redprint '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        ssm2
        sm2
        ;;
    2)
        ssm3
        sm2
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

sm3() {
    echo -ne "
$(whiteprint 'INSTALLATION SUBMENU')
$(whiteprint '1)') SCRIPTS
$(magentaprint '2)') Go Back to Main Menu
$(redprint '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        ssm4
        sm3
        ;;
    3)
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
###############################################################################################

menu() {
    echo -ne "
$(magentaprint 'WELCOME TO MAIN MENU')
$(greenprint '1)') SYSTEM
$(blueprint '2)') MANAGEMENT
$(whiteprint '3)') INSTALLATION
$(yellowprint '4)') BACKUP
$(redprint '0)') Exit
Choose an option:  "
    read -r ans
    case $ans in
    1)
        sm1
        menu
        ;;
    2)
        sm2
        menu
        ;;
    3)
        sm3
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