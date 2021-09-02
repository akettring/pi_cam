# pi_cam
Raspberry pi security camera

Why would anyone want to do this?
- Privacy. Sync to *your* favorite cloud storage provider.
- Security. Sync to *multiple* cloud folders.


mkdir /home/pi/pi_cam
mkdir /home/pi/pi_pics
mkdir /home/pi/pi_vids


sudo apt install motion

sudo nano /etc/motion/motion.conf

    daemon on
    width 800
    height 600
    threshold 2000
    noise_level 128
    event_gap 10
    pre_capture 1
    post_capture 1
    output_pictures best
    ffmpeg_output_movies on
    locate_motion_mode on
    text_changes on 
    target_dir /home/pi/pi_cam
    on_motion_detected /home/pi/bin/green_led_blink.sh
    on_event_start /home/pi/bin/red_led_on.sh
    on_event_end /home/pi/bin/red_led_off.sh
    on_movie_end /home/pi/bin/move_files.sh


sudo motion -n




sudo apt-get install rclone

    Dropbox
    [dropbox_remote]
    token = {"access_token":"XXXXXXXXXXXXXX","token_type":"bearer","expiry":"XXXXXXXX"}

    Gdrive
    [gdrive_remote]
    token = {"access_token":"XXXXXXXXXXXXXXX","token_type":"Bearer","refresh_token":"XXXXXXX","expiry":"XXXXXXXXXXXXXX"}


rclone mkdir dropbox_remote:pi_pics
rclone mkdir gdrive_remote:pi_vids



chmod +x /home/pi/bin/ -Rv


sudo nano /etc/rc.local

    motion
    
    /home/pi/bin/rclone_sync.sh



- Budget. No monthly/yearly fees. Parts for under $100.
- Edutainment. Learn about raspberry pi and BASH scripting!
    
    



## Step 0. Prepare the pi

Buy a raspberry pi and whatever camera you like, USB or ribbon cable ... doesn't matter.

Install the default Raspbian OS. Boot

If you are a pro and you can get wifi to work "out of the box" headless, my hat goes off to you.




mkdir /home/pi/pi_cam
mkdir /home/pi/pi_pics
mkdir /home/pi/pi_vids

## Step 2. Set up the cam

sudo apt install motion

sudo nano /etc/motion/motion.conf

    daemon on
    width 800
    height 600
    threshold 2000
    noise_level 128
    event_gap 10
    pre_capture 1
    post_capture 1
    output_pictures best
    ffmpeg_output_movies on
    locate_motion_mode on
    text_changes on 
    target_dir /home/pi/pi_cam
    on_motion_detected /home/pi/bin/green_led_blink.sh
    on_event_start /home/pi/bin/red_led_on.sh
    on_event_end /home/pi/bin/red_led_off.sh
    on_movie_end /home/pi/bin/move_files.sh


sudo motion -n


## Step 3. sync using rclone

sudo apt-get install rclone

    Dropbox
    [dropbox_remote]
    token = {"access_token":"XXXXXXXXXXXXXX","token_type":"bearer","expiry":"XXXXXXXX"}

    Gdrive
    [gdrive_remote]
    token = {"access_token":"XXXXXXXXXXXXXXX","token_type":"Bearer","refresh_token":"XXXXXXX","expiry":"XXXXXXXXXXXXXX"}


rclone mkdir dropbox_remote:pi_pics
rclone mkdir gdrive_remote:pi_vids



chmod +x /home/pi/bin/ -Rv


sudo nano /etc/rc.local

    motion
    
    /home/pi/bin/rclone_sync.sh




