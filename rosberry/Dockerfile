FROM armv7/armhf-ubuntu:16.04
LABEL maintainer="Stefano Cirici"
LABEL maintaineremail="stefanocirici@gmail.com"
LABEL version="1.0"
LABEL description="ubuntu 16.04 armhf image for raspberry with ROS support for \
laser_bot_battle project"
LABEL project="laser_bot_battle"
LABEL projecturl="https://github.com/ludusrusso/pp-robot-2018"

# hack to drop arm emulation from kernel
ENV QEMU_EXECVE 1
COPY bin/ /usr/bin/

# start emulation of sh
RUN [ "cross-build-start" ]

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

RUN apt-get update && apt-get upgrade -y

# install ROS
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116
RUN echo "deb http://packages.ros.org/ros/ubuntu xenial main" > /etc/apt/sources.list.d/ros-latest.list
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    g++

#packages for LaserBot Battle
RUN apt-get install --no-install-recommends -y \
    git vim tmux \
    ros-kinetic-ros-core \
    ros-kinetic-rosserial \
    ros-kinetic-rosserial-arduino \
    python-pip \
    python-dev \
    #python-rpi.gpio \
    avahi-daemon \
    avahi-utils


# clean system from unnecessary temp packages
RUN apt-get autoclean -y && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# install request python module
RUN pip install setuptools requests wheel RPi.GPIO

# clone project repository into home
RUN git clone https://github.com/ludusrusso/pp-robot-2018.git 

# copy avahi configuration file
COPY ./avahi-daemon.conf /etc/avahi/

# workaround to get dbus working, required for avahi to talk to dbus. This will be mounted
RUN mkdir -p /var/run/dbus
VOLUME /var/run/dbus

# copy gpio led scripts
COPY ./blink_led.py /
COPY ./led_on.py /
RUN chmod +x /blink_led.py /led_on.py

# setup entrypoint
COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh

# restore emulated sh
RUN [ "cross-build-end" ]

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
