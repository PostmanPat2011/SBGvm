#!/bin/bash
set -x

if ! systemctl is-active --quiet gdm.service; then
  	echo "GDM service is not running"
	echo "Starting Desktop"
	systemctl start gdm.service
	echo 1 > /sys/class/vtconsole/vtcon0/bind
	wait
elif systemctl is-failed --quiet gdm.service; then
  	echo "GDM service has failed"
  	echo "Starting Desktop"
	systemctl start gdm.service
	echo 1 > /sys/class/vtconsole/vtcon0/bind
	wait
else
  echo "GDM service is running"
fi


echo "Detaching IO"
virsh detach-device win10 --file /home/kek/vm/files/keyboard.xml
virsh detach-device win10 --file /home/kek/vm/files/mouse.xml
