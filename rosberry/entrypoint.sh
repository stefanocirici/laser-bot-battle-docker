#!/bin/bash
set -e

#call blinking led sccript
python /blink_led.py & BLINK_ID=$!

# setup ros environment
echo 'source /opt/ros/kinetic/setup.bash' >> ~/.bashrc
echo 'source /pp-robot-2018/raspberry/devel/setup.bash' >> ~/.bashrc
echo 'export ROS_IP=$(hostname -I | cut -d " " -f 1)' >> ~/.bashrc
echo 'export ROS_MASTER_URI=http://laser_bot_master.local:11311' >> ~/.bashrc

source /opt/ros/kinetic/setup.bash

cd pp-robot-2018/
git checkout beta
git pull origin beta

cd raspberry
#rm -rf build devel
#catkin_make clean
catkin_make
source devel/setup.bash

# kill blinking led
kill -HUP $BLINK_ID

tmux -2
./src/laser_bot_battle/scripts/ID_service_client.py

exec "$@"
