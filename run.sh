#!/bin/bash
touch ~/it_works_for_real.txt

#copies the crontab's errorlog out to the Drive
rclone copy ~/errorlog.txt gdrive:

#df -h --total | tail > diskspace.dat
#rclone copy diskspace.dat gdrive:

#Disk-space tracking
df -h --total > diskspace.txt
date >> diskspace.txt
rclone copy diskspace.txt gdrive:

#Camera-operation monitoring
echo "Cam 1" > last_images.txt
ls -1 ~/cam1/ | tail -1 >> last_images.txt
echo "Cam 2" >> last_images.txt
ls -1 ~/cam2/ | tail -1 >> last_images.txt
date >> last_images.txt
rclone copy last_images.txt gdrive:

#Debugging information
ls -lh /dev/ > dev_list.txt
date >> dev_list.txt
rclone copy dev_list.txt gdrive:

# Deep hardware debugging
lsusb > usb_devices.txt
date >> usb_devices.txt
rclone copy usb_devices.txt gdrive:

dmesg > kernel_log.txt
date >> kernel_log.txt
rclone copy kernel_log.txt gdrive:

# --- Emergency One-Time Reboot ---
REBOOT_FLAG="$HOME/emergency_reboot_mar_27.flag"

if [ ! -f "$REBOOT_FLAG" ]; then
    # Create the lock file so this never runs again
    touch "$REBOOT_FLAG"
    
    # Test passwordless sudo silently
    if sudo -n true 2>/dev/null; then
        echo "Sudo access confirmed. Initiating immediate reboot..." > ~/reboot_status.txt
        rclone copy ~/reboot_status.txt gdrive:
        
        # Flush file system buffers, then pull the plug
        sync
        sudo -n reboot
        exit 0
    else
        echo "Reboot failed: sudo requires a password." > ~/reboot_status.txt
        rclone copy ~/reboot_status.txt gdrive:
    fi
fi
# ---------------------------------
