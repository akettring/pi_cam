Instructions, configuration files, and scripts for setting up a cloud-based security camera on a raspberry pi.

<img src="https://raw.githubusercontent.com/akettring/pi_cam/main/pi_cloud.png">

Why would anyone want to do this ?
- Privacy. Sync to *your* choice of cloud storage provider.
- Security. Sync to *multiple* cloud folders.
- Budget. No monthly/yearly fees. Parts for under $100.
- Edutainment. Learn about raspberry pi programming!
    
These instructions cover syncing with Dropbox using rsync, which is surprisingly easy. Also tested for Goole Drive.




## Step 0. Prepare the pi

- Buy a raspberry pi and whatever camera you like, USB or ribbon cable.
- Install the default Raspbian OS. Headless/minimal installation never works for me.
- Boot and set up wifi. I suggest to enable SSH using `raspi-config` or in the preferences menu, and then go headless from this point.
- Clone the contents of this git repo into your home directory. It may be necesseary to run `chmod +x /home/pi/bin/ -Rv`




## Step 1. Set up the cam


Make the following directories on your raspberry pi. 
The camera first dumps files into the pi_cam folder, and then move_files.sh splits them to pics and vids.
This is especially convenient if you wish to send pics and vids to different cloud services.

    mkdir /home/pi/pi_cam
    mkdir /home/pi/pi_pics
    mkdir /home/pi/pi_vids

Inistall motion and configure.

    sudo apt install motion
    cp /etc/motion/motion.conf ~/motion.conf.bak

The provided `motion.conf` has the following changes made:

    daemon on
    process_id_file /home/pi/motion.pid
    logfile /home/pi/motion.log    
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

Test that it is working properly. Files should show up. Lights should flash.

    sudo motion -n




## Step 2. sync using rclone

Get rclone. The flux capacitor of this operation.

    sudo apt-get install rclone

Run `rclone config` and follow the instructions.
Keep it simple, but be descriptive with names.
Also note that if running headless the pi will need to talk to the host machine.
If so, install rclone on the host machine too and run `rclone authorize "dropbox".`

An example 'rclone config':

    e/n/d/r/c/s/q> n
    name> dropbox_remote
    Storage> dropbox
    client_id> 
    client_secret> 
    Edit advanced config? (y/n)
    y/n> n
    Use auto config?
     * Say Y if not sure
     * Say N if you are working on a remote or headless machine
    y) Yes
    n) No
    y/n> y

The host machine will generate a token that needs to be passed to the pi, such as:

    {"access_token":"XXXXXXXXXXXXXX","token_type":"bearer","expiry":"XXXXXXXX"}


If things worked as planned you should be able to see the contents of your Dropbox.

    rclone lsd dropbox_remote

Now set up the directories to receive files from the pi.

    rclone mkdir dropbox_remote:pi_pics
    rclone mkdir dropbox_remote:pi_vids




## Step 3. Finalize the installation

The last step is to edit rc.local so that motion and rsync run at startup.

    sudo cp /etc/rc.local ~/rc.local.bak
    sudo nano /etc/rc.local

Add the following lines BEFORE `exit 0` as in the provided example:

    motion
    /home/pi/bin/rclone_sync.sh

Restart your pi and you should be good to go!

