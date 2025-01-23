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
