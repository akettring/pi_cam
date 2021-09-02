#!/bin/bash

sleep 5s

# move pics and vids to separate folders
find /home/pi/pi_cam/ -name \*.jpg -exec mv {} /home/pi/pi_pics/ \;
find /home/pi/pi_cam/ -name \*.mkv -exec mv {} /home/pi/pi_vids/ \;
# echo "Moved files"