# LaserBot Battle Docker

  Docker images compiled for [LaserBot Battle](https://github.com/ludusrusso/pp-robot-2018).


*This README is still a work in progess.*
*Further information about installation, usage and contribution method will be introduced after initial steps of development.*

---

## Table of Contents
- [Installation](#installation)
    - [Docker](#docker)
      - [Install Docker](#install-docker)
      - [Uninstall Docker](#uninstall-docker)
    - [Raspberry](#raspberry)
    - [Master server](#master)
- [Run](#run)
    - [Start Raspberry Container](#start-raspberry-container)
    - [Start Master Container](#start-master-container)
- [License](#license)

---

## Installation

  ### Docker
  
  #### Install Docker
  To automatically install docker-ce on the system
  
  ```bash
  $ curl -fsSL get.docker.com | sudo sh
  ```

  If you would like to use Docker as a non-root user, you should now consider adding your user to the
  "docker" group with something like:
  
  ```bash
  $ sudo usermod -aG docker $USER
  ```

  Remember to log out and back in for this to take effect!
      
  #### Uninstall Docker
  Uninstall the Docker CE package:
  
  ```bash
  $ sudo apt-get purge docker-ce
  ```

  Images, containers, volumes, or customized configuration files on your host are not automatically removed.
  To delete all images, containers, and volumes:
  
  ```bash
  $ sudo rm -rf /var/lib/docker
  ```

  You must delete any edited configuration files manually.
    
  From docker [documentation](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-using-the-convenience-script).

  ### Raspberry
  To get the Raspberry Pi docker image, pull it from Docker Cloud:
  
  ```bash
  $ docker pull stefanocirici/laserbotbattle:rosberry
  ```

  ### Master
  To get the Ubuntu docker image for the webserver, pull it from Docker Cloud:
  
  ```bash
  $ docker pull stefanocirici/laserbotbattle:server
  ```

---

## Run

  ### Start Raspberry Container
  To run the image on Raspberry:
  
  ```bash
  $ docker run -it --privileged -v /var/run/dbus:/var/run/dbus stefanocirici/laserbotbattle:rosberry
  ```
  
  Once the docker container is run, the ID_service_client script will automatically be executed (in a tmux shell).
  
  ### Start Master Container
  To run the webserver image:
  
  ```bash
  $ docker run -it --privileged -v /var/run/dbus:/var/run/dbus stefanocirici/laserbotbattle:server
  ```
  
  Once the docker container is run, the roscore, rosbridge-server and main script will automatically be executed (in a tmux shell).
  
  
---

## License

This project is licensed under the BSD 3 License - see the [LICENSE](LICENSE) file for details.
