#!/bin/bash

while [ 1 ]
do

    # if vids > 10gb (in bytes) 
    # check the current size, delete 10 if too big
    SIZE="10737418240"
    CHECK=$(du --max-depth=0 -b /home/pi/pi_vids | cut -f1)
    if (( $(echo "$CHECK > $SIZE" ) )) 
    then
    DELFILES=$(ls -t /home/pi/pi_vids | tail -10)
    rm $DELFILES
    fi

    # if pics > 1gb (in bytes) 
    # check the current size, delete 10 if too big
    SIZE="1073741824"
    CHECK=$(du --max-depth=0 -b /home/pi/pi_pics | cut -f1)
    if (( $(echo "$CHECK > $SIZE" ) ))
    then
    DELFILES=$(ls -t /home/pi/pi_pics | tail -10)
    rm $DELFILES
    fi
    # echo "Checked space"

    # sync the folders
    su -c 'rclone sync /home/pi/pi_pics/ dropbox_remote:pi_pics -P' pi
    su -c 'rclone sync /home/pi/pi_vids/ gdrive_remote:pi_vids -P' pi
    # echo "Sync'd folders"

    # wait
    sleep 5m
    # echo "Wait 5 min"

done


