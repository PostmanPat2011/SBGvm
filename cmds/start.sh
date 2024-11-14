#!/bin/bash
# Helpful to read output when debugging
set -x

if $(cat /home/kek/vm/files/isRunning.txt); then
	echo "VM Already running"
	exit 0
else
	echo "true" > /home/kek/vm/files/isRunning.txt
fi

echo "true" > /home/kek/vm/files/isRunning.txt
# Load the config file with our environmental variables
source "/home/kek/vm/files/kvm.conf"

# Stop your display manager. If you're on kde it'll be sddm.service. Gnome users should use 'killall gdm-x-session' instead
systemctl stop gdm.service

# Unbind VTconsoles
echo 0 > /sys/class/vtconsole/vtcon0/bind
# Some machines might have more than 1 virtual console. Add a line for each corresponding VTConsole
# echo 0 > /sys/class/vtconsole/vtcon1/bind
# Unbind EFI-Framebuffer
#echo efi-framebuffer.0 > /sys/bus/platform/drivers/efi-framebuffer/unbind

# Avoid a race condition by waiting a couple of seconds. This can be calibrated to be shorter or longer if required for your system

# sleep 5
# Unload all Nvidia drivers
modprobe -r nouveau
# Unbind the GPU from display driver
virsh nodedev-detach $VIRSH_GPU_VIDEO
virsh nodedev-detach $VIRSH_GPU_AUDIO

# Load VFIO kernel module
modprobe vfio
modprobe vfio_pci
modprobe vfio_iommu_type1
wait
virsh start win10
wait
virsh attach-device win10 --file /home/kek/vm/files/keyboard.xml
virsh attach-device win10 --file /home/kek/vm/files/mouse.xml
