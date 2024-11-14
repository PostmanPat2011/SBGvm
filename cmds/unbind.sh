#!/bin/bash
source "/home/kek/vm/files/kvm.conf"
if systemctl is-active --quiet gdm.service; then
	systemctl stop gdm.service
	echo 0 > /sys/class/vtconsole/vtcon0/bind
	while systemctl is-active --quiet gdm.service; do
	 	sleep 1
	done
fi
modprobe -r nouveau
wait
virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO
wait
echo 1 > /sys/class/vtconsole/vtcon0/bind
systemctl start gdm.service
