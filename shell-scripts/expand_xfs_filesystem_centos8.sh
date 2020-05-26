#!/usr/bin/env bash
# https://www.miarec.com/doc/administration-guide/doc1012
# https://www.tecmint.com/extend-and-reduce-lvms-in-linux/

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

# First, check the name(s) of your scsi devices.
declare scsi_devices=$(ls /sys/class/scsi_device/)
declare -a array_scsi_devices
for word in $scsi_devices; do
   array_scsi_devices+=($word)
done

# re-scan
for scsi_device in ${array_scsi_devices[@]}; do

   declare command_scan_raw="/sys/class/scsi_device/${scsi_device}/device/rescan"
   declare command_scan=$(echo "$command_scan_raw" | sed -r 's/[:]+/\\:/g')

   bash -c "echo 1 > $command_scan"

done

fdisk /dev/sda <<EEOF
n
p
3


t
3
8e
w
EEOF

pvcreate /dev/sda3
vgextend cl /dev/sda3

declare space_to_add_raw=$(vgdisplay | awk 'FNR == 19 {print}')
declare -a array_space_to_add_raw
for word in $space_to_add_raw; do
   array_space_to_add_raw+=($word)
done

declare command="lvextend -l +${array_space_to_add_raw[4]} /dev/cl/root"

bash -c "$command"

xfs_growfs -d /
exit 0
