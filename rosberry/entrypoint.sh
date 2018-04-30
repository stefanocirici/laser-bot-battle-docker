#!/bin/bash
set -e

# change the owner and group of /dev/mem to root and gpio respectively.
#chown root.gpio /dev/mem
# gives the group read write access to this /dev/mem object.
#chmod g+rw /dev/mem

#call blinking led sccript
#python /blink_led.py & BLINK_ID=$!

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
#if ps -p $BLINK_ID > /dev/null
#then
#   kill -HUP $BLINK_ID
#fi

## prepare tmux 3 split view
#tmux new-session -d -s session
#tmux split-window -v -d -t session:0.0
## launch roscore on first panel
#tmux send-keys -t session:0.0 "./src/laser_bot_battle/scripts/ID_service_client.py" Enter

## get tmux view (attach)
#tmux attach-session -t session


exec "$@"
