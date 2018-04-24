#!/bin/bash
set -e


# setup ros environment
echo 'source /opt/ros/kinetic/setup.bash' >> ~/.bashrc
echo 'source /pp-robot-2018/server_ws/devel/setup.bash' >> ~/.bashrc
echo 'export ROS_IP=$(hostname -I | cut -d " " -f 1)' >> ~/.bashrc

source /opt/ros/kinetic/setup.bash

cd pp-robot-2018/
git checkout beta
git pull origin beta

cd server_ws
#rm -rf build devel
#catkin_make clean
catkin_make
source devel/setup.bash

# prepare tmux 3 split view
tmux new-session -d -s session
tmux split-window -v -d -t session:0.0
tmux split-window -v -d -t session:0.0
# launch roscore on first panel
tmux send-keys -t session:0.0 "roscore" Enter
# launch rosbridge webserver on second panel
tmux send-keys -t session:0.1 "./src/laser_bot_battle/scripts/rosbridge_launch.sh" Enter
# launch main (app + service server) on third panel
tmux send-keys -t session:0.2 "./src/laser_bot_battle/scripts/main.py" Enter

# get tmux view (attach)
tmux attach-session -t session


exec "$@"
