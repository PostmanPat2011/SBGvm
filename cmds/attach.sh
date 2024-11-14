#!/bin/bash
set -x

#echo "Stopping Desktop"
#systemctl stop gdm.service
#echo 0 > /sys/class/vtconsole/vtcon0/bind
#wait
echo "Attaching IO"
virsh attach-device win10 --file /home/kek/vm/files/keyboard.xml
virsh attach-device win10 --file /home/kek/vm/files/mouse.xml
