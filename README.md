# nginx-docker Chef Basic Setup

Requires: https://hub.docker.com/r/cbuisson/chef-server/

Ran the above container on a Ubuntu 14.04 VM created using Vagrant and followed the instructions supplied. Vagrant File can be found in the ubuntu-vagrant directory. You will need to switch this vm to bridge network mode. Install Docker and then pull and run the chef-server container above:

```docker run --privileged -t --name chef-server -d -p 443:443 cbuisson/chef-server```

Once my Raspberry Pi was bootstrapped to the chef-server:

```knife bootstrap <ip address> --node-name pi3 --run-list 'recipe[nginx-docker]'```

This then applied my nginx-docker recipe on the Raspberry Pi to server a simple webpage.

```pi@pi3:~ $ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
036276fa6893        nginx:latest        "nginx -g 'daemon of…"   13 minutes ago      Up 13 minutes       0.0.0.0:80->80/tcp       nginxpiece
5dcd7fe18f45        busybox:latest      "nc -ll -p 1234 -e /…"   15 minutes ago      Up 15 minutes       0.0.0.0:1234->1234/tcp   an-echo-server```
