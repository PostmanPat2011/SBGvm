#!/bin/bash
cd /home/kek/vm/cmds
cls
#set -x
while true; do
  echo "Select an option:"
  select opt in "Start" "Shutdown" "Attach" "Detach" "Exit" "Unbind GPU" "Rebind GPU"; do
    case $opt in
      "Start") 
        echo "Starting VM"
        nohup sudo ./start.sh
        ;;
      "Shutdown") 
        echo "Stopping VM"
        nohup nohup sudo ./shutdown.sh
        ;;
      "Attach") 
        echo "Attaching IO"
        nohup sudo ./attach.sh
        ;;
      "Detach") 
        echo "Detaching IO"
        nohup sudo ./detach.sh
        ;;
      "Exit") 
        echo "Bye Bye"
        exit 0
        ;;
      "Unbind GPU") 
        nohup sudo ./unbind.sh
        ;;
      "Rebind GPU") 
        nohup sudo ./rebind.sh
        ;;
      *) 
        echo "Invalid option. Please try again."
        ;;
    esac
  done
done
