#!/bin/bash
touch ~/it_works_for_real.txt

df -h --total | tail > diskspace.dat
rclone copy diskspace.dat gdrive:
