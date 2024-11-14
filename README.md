# SBGvm

## ACS Bypasses
Manual Buid: https://github.com/benbaker76/linux-acs-override
Prebuilt: https://xanmod.org/

Make sure to reconfigure the driver detach and kvm.conf.

Don't mention the depracted use of nodedev-detach, it works for me and the auto detach doesn't.
Hook manager was hit or miss so I find manually starting it thru bash works better. Especially with a SSH client on my phone.

# You can find more information on the tehcniques I used here:
https://gitlab.com/Karuri/vfio
https://askubuntu.com/questions/1406888/ubuntu-22-04-gpu-passthrough-qemu/1410487#1410487
