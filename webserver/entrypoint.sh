#!/bin/bash
set -e


# setup ros environment
echo 'source /opt/ros/kinetic/setup.bash' >> ~/.bashrc
echo 'source /pp-robot-2018/server_ws/devel/setup.bash' >> ~/.bashrc
echo 'export ROS_IP=$(hostname -I | cut -d " " -f 1)' >> ~/.bashrc
source ~/.bashrc

# move to project folder
cd pp-robot-2018/server_ws

# launch roscore
roscore & ROSCORE_ID=$!
sleep 2

# launch rosbridge webserver
./src/laser_bot_battle/scripts/rosbridge_launch.sh & ROSBRIDGE_ID=$!
sleep 2

# launch main (app + service server)
./src/laser_bot_battle/scripts/main.py & MAIN_ID=$!
sleep 2

# print process id message
echo "In the eventuality of a crash, signle processes can be killed running:"
echo "    \$ kill <ID>"
echo "The list of the processes IDs is below:"

printf "\n %-20s | %-10s\n" "PROCESSES" "ID"
printf " %s\n" "-------------------- | ----------"
printf " %-20s | %-10s\n" "roscore" "$ROSCORE_ID"
printf " %-20s | %-10s\n" "rosbridge" "$ROSBRIDGE_ID"
printf " %-20s | %-10s\n\n" "main" "$MAIN_ID"


exec "$@"
