# weichao-wiki
wiki setup for weichao

1. install docker and docker-compse.

    on ubuntu you could use `apt install`.

1. to test on localhost

    modify /etc/hosts, add domain names like `traefik.example.com`, point them to 127.0.0.1

    You can find the domain names required in each compose file. (search `rule=Host`)

    Then modify .env file, update `DOMAINNAME`, change it to `example.com`

    If you host it on web, modify `ACME_EMAIL` in .env as well. It will become your letsencrypt account.

1. make a folder and change `VOLUMEPATH` in .env.

1. change to root `sudo -s`
    then call setup-script/traefik_acme.sh

1. optionally if you want to visit the traefik dashboard or gollum, you need setup authelia (for authorization).

    firstly change to root `sudo -s`
    then call setup-script/authelia-gen-pw.sh, and type a user name and password

    modify the domain name in ./volumes/authelia/etc/configuration.yml (currently it is set to `example.com`)

1. optionally setup gollum git database

1. start services using docker-compose

    It reads the .env file from the current folder. Some variables in the docker-compose file are read from the .env file.

    firstly, setup a network.
    sudo docker-compose -f ./compose/network.yml up -d

    The order of the rest services does not matter.
    But you need to start traefik, authelia and mailhot, unless you modify the corresponding configuration files to remove the dependence.

    You could use setup.sh as well

1. visit xwiki.example.com (or the domains set in the compose files)
    Many services have default user name and password, see the comments in docker-compose files or google it.
    Once you login, you can add new users.

1. To run mediawiki:
   
   1. comment the following line in `./compose/mediawiki.yml`
      - ${VOLUMEPATH}/mediawiki/LocalSettings.php:/var/www/html/LocalSettings.php 
   1. start mediawiki: `sudo docker-compose -f ./compose/mediawiki.yml up -d`
   1. visit mediawiki.example.com, setup and download `LocalSettings.php`
      use db host: mediawiki_db, db user/password: mediawiki. They are set in ./compose/mediawiki.yml
   1. Enable visual editor, by adding the following line to the end of `LocalSettings.php`.
      - wfLoadExtension( 'VisualEditor' );
   1. copy `LocalSettings.php` to `${VOLUMEPATH}/mediawiki/LocalSettings.php`
   1. uncomment 
      - ${VOLUMEPATH}/mediawiki/LocalSettings.php:/var/www/html/LocalSettings.php 
   1. stop mediawiki: `sudo docker-compose -f ./compose/mediawiki.yml down`
   1. start mediawiki again: `sudo docker-compose -f ./compose/mediawiki.yml up -d`

1. To debug
    find the names of running containers using `sudo docker ps`
    use `sudo docker logs <container name>` to see logs of a container
    for example if you did not set the correct permission to the acme.json file, traefik will not work correctly. You will see an error in `sudo docker logs traefik`

1. The compose files arr working on standalone docker (single host). They do not work with docker swarm mode.
