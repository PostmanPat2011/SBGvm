#!/bin/bash
set -x
if systemctl is-active --quiet gdm.service; then
	systemctl stop gdm.service
	echo 0 > /sys/class/vtconsole/vtcon0/bind
fi
virsh shutdown win10
while virsh domstate win10 | grep -q running; do
	sleep 1 
done
# Load the config file with our environmental variables
source "/home/kek/vm/files/kvm.conf"

# Unload VFIO-PCI Kernel Driver
modprobe -r vfio_pci
modprobe -r vfio_iommu_type1
modprobe -r vfio
wait
# Re-Bind GPU to our display drivers
virsh nodedev-reattach $VIRSH_GPU_VIDEO
virsh nodedev-reattach $VIRSH_GPU_AUDIO
wait
# Rebind VT consoles
echo 1 > /sys/class/vtconsole/vtcon0/bind
# echo 0 > /sys/class/vtconsole/vtcon1/bind
wait
# Load nvidia drivers
modprobe nouveau
# Restart Display Manager
wait
systemctl start gdm.service
