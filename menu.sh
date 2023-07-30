#!/bin/bash

submenu () {
  local PS3='Please enter sub option: '
  local options=("item 1" "item 2" "quit")
  local opt
  select opt in "${options[@]}"
  do
      case $opt in
          "item 1")
              echo "you chose $REPLY which is $options"
              ;;
          "item 2")
              echo "you chose $REPLY which is $options"
              ;;
          "quit")
              return
              ;;
          *) echo "invalid option $REPLY";;
      esac
  done
}


PS3='Please enter main option: '
options=("SYSTEM" "MANAGEMENT" "INSTALLATION" "BACKUP" "Submenu" "Quit")
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
        "Submenu")
            submenu
            ;;      
        "Quit")
            exit
            ;;
        *) echo "invalid option $REPLY";;
    esac
done