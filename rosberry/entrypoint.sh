#!/bin/bash
set -e

# print first argument in blue with white background
function cmd {
    echo -e "$(tput bold)$(tput setaf 4)$(tput setab 7)${1}$(tput sgr0)"
}
# print first argument in red with white background
function err {
    echo -e "$(tput bold)$(tput setaf 1)$(tput setab 7)${1}$(tput sgr0)"
}


cmd "--------------------------------------------------------------------------------"
cmd "------------------------------ Starting container ------------------------------"
cmd "--------------------------------------------------------------------------------"
echo

# led ON
python /led_on.py

# setup ros environment
echo 'source /opt/ros/kinetic/setup.bash' >> ~/.bashrc
echo 'source /pp-robot-2018/raspberry/devel/setup.bash' >> ~/.bashrc
echo 'export ROS_IP=$(hostname -I | cut -d " " -f 1)' >> ~/.bashrc
echo 'export ROS_MASTER_URI=http://laser_bot_master.local:11311' >> ~/.bashrc

source /opt/ros/kinetic/setup.bash

# move to project folder
cd pp-robot-2018/raspberry/


cmd "--------------------------------------------------------------------------------"
cmd "--------------------------- Starting service client ----------------------------"
cmd "--------------------------------------------------------------------------------"
echo

# call blinking led script
python /blink_led.py & BLINK_ID=$!

# launch robot script
./src/laser_bot_battle/scripts/ID_service_client.py


err "--------------------------------------------------------------------------------"
err "------------------------------------ ERROR -------------------------------------"
err "--------------------------------------------------------------------------------"
echo

# If Here, an error has occurerd
# kill blinking led
if ps -p $BLINK_ID > /dev/null
then
    kill -HUP $BLINK_ID
fi


exec "$@"
