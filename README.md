# LaserBot Battle Docker

  Docker images compiled for [LaserBot Battle](https://github.com/ludusrusso/pp-robot-2018).


---

## Table of Contents
- [Install Docker](#install-docker)
- [Uninstall Docker](#uninstall-docker)
- [Get Raspberry image](#get-raspberry-image)
- [Get Master server image](#get-master-server-image)
- [License](#license)

---

  
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

  ### Get Raspberry image
  To get the Raspberry Pi docker image, pull it from Docker Cloud:
  
  ```bash
  $ docker pull stefanocirici/laserbotbattle:rosberry
  ```

  ### Get Master server image
  To get the Ubuntu docker image for the webserver, pull it from Docker Cloud:
  
  ```bash
  $ docker pull stefanocirici/laserbotbattle:server
  ```
  
---

## License

This project is licensed under the BSD 3 License - see the [LICENSE](LICENSE) file for details.
