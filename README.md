# magento-php7-docker

Base docker environment to test magento 1.9 project on php7 with XDebug. Based on my experience and parts founded in web.

## Installation
### Linux

* Install [docker] (https://docs.docker.com/engine/installation/ubuntulinux/)
* Install [docker-compose] (https://docs.docker.com/compose/install/)
* Copy content of that repository to your project root
* Replace {$local_ip} in docker-compose.yaml with your real local IP
* Into docker/dump copy .sql dump of your database
* Run folloving commands:
    ```sh
    $ docker-compose build mysql
    $ docker-compose build web
    $ docker-compose up
    ```

## Debug
* Create 'PHP Remote Debug' configuration in PHPStorm (session key as you wish)
* In PHPStorm go to: `Languages & Frameworks` > `PHP` > `Debug` > `DBGp Proxy` and set the following settings:
  * `Host`: your IP address
  * `Port`: 9000
* Debug with entered session key (?XDEBUG_SESSION_START=111, for example)
* If you have problems with file mapping, resolve it in Settings/Preferences | Languages & Frameworks | PHP | Servers | {$Your server}
