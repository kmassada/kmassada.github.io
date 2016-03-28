---
layout: "post"
title: "Docker Lessons Learned: Hour 12"
date: "2016-03-27 11:31"
excerpt: "My take on docker and how it helps with my personal projects"
categories: projects
image:
  feature: baltimore-skyline-blur.png
---

Aside from it being one of the hottest trends in tech today. I truly started looking at docker for **practical** reasons. I had a node in Digital ocean. On that node I run all my private projects, which vary from Node JS api listener for git post hooks to full stack web apps.

Recently I started getting notifications:

![New Relic Alert]({{ site.url }}/images/2016/03/Screenshot_2016-03-28_10.06.2.png)

### what it may be?

I have seen this long coming, and have been trying to prepare for it.
* looked at [building my chef server ](https://gist.github.com/kmassada/578bdb2674624a40f18d), to spin smaller instances, with a common base
* looked at [my own ansbile](https://github.com/kmassada/ansible) to deploy projects.
* looked at capistrano for smaller projects
* looked at [Libvirt and Quemu](https://gist.github.com/kmassada/f3d635fb1d4b8219778d) to drive vagrant. |=.=|

### myths! design!

Let me start by debunking a few myths. The prime reason I chose containers was not solely due to cpu/memory utilization. *This is not a tool problem, this is an architecture and a resource utilization paradigm.*

However,
* re-architecting my applications in a way I could apply caps on each versus letting them all run wild on the system,
* having a fair separation in the libraries, versus using tech that isolate runtime environments,
* Not tying myself to nodes. Handling my nodes with the same maniability as I treat code,

were the reasons I decided to use docker,

### the right way (things I wish I knew first)
I jumped into the subject matter with a hast. Deadline: 12 hrs over the weekend to migrated all the projects. I learned very fast,

* Like VMs, you need to specify autostart when a container is deployed
* Once a container deployed it is not easy to change it's "state". can't re-specify `--start=always`
* Prepare for containers to be truly maniable, killed, respun, and re-killed. redeploying a container with 0 downtime looks like this: *deploy second container, switch nginx to another port, delete old container, docker run again. switch back nginx.*
* `iptables.` dodged it like I do, yes brush up on it.
* `Docker-compose` deploys containers using configuration files. After each container deploy code looks like below, you'd regret.

```
docker run --name gelf -p 127.0.0.1:12201:12201/udp --link elasticsearch:elasticsearch -v /docker/gelf:/config-dir  --log-driver=gelf --log-opt gelf-address=udp://127.0.0.1:12201 --log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}" --restart=always  -d logstash  logstash -f /config-dir/gelf.conf
```

* `DOCKER_OPTS` I have not fully figured it out on centos, but in ubuntu, you can set a series of OPTS that will get appened to your docker runs.

* `PROXY or vhosts`, because I have a series of services that serve on the same external ports. Using nginx as a proxy, that listens on that port, but with a different `server_name`
* `SWARM`, containers on their own are not clustered. Swarm resolves that problem. Don't be lame Rob Lowe. Think swarm before anything.
* `EXPOSED` is your door into the container either interacting with other nodes or your host. learn it.
* Volumes, your containers can share host resources, or if you catch it early, external resources. look into the volumes, and build solutions around deploying with or without.
* Honorable mention to: `Kitematic`. If you develop locally just freaking love it already. Its pretty on MAC.

### school of thought

This gets it's own section because it is important, and overshadows all the things previously mentioned. Containers are NOT VMs. At this point you are nodding, but take a deep breath, and think about it for a second.

![containers vs vms]({{ site.url }}/images/2016/03/containers_vs_vms.png)

### The Run Down
The big picture: With Docker create an ELK stack that monitory hosts and containers

The Details: Deploy a set of docker containers.
1- elasticsearch with logs stored on host.
```
docker run --name elasticsearch  -p 127.0.0.1:9200:9200  -v "/docker/elasticsearch/data":/usr/share/elasticsearch/data -p 127.0.0.1:9300:9300 --restart=always  -d elasticsearch
```

2- spin up a kibana dashboard that allows to search elasticsearch node.
```
docker run --name kibana -p 127.0.0.1:5601:5601 --link elasticsearch:elasticsearch --restart=always  -d kibana
```

3- spin up logstash with gelf (listens to port and sends data it recieves to elastic search)
```
docker run --name gelf -p 127.0.0.1:12201:12201/udp --link elasticsearch:elasticsearch -v /docker/gelf:/config-dir --restart=always  -d logstash  logstash -f /config-dir/gelf.conf
```

4- configure containers to talk to gelf
re-deploy each container with the following
```
--log-driver=gelf --log-opt gelf-address=udp://127.0.0.1:12201 --log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}"
```

5- Docker daemon
```
sudo mkdir /etc/systemd/system/docker.service.d
sudo vi /etc/systemd/system/docker.service.d/docker.conf
```
docker daemon options
```
/usr/bin/docker daemon -H fd:// --log-driver=gelf --log-opt gelf-address=udp://127.0.0.1:12201
```
6- nginx configured for proxy
```
server {
    listen 80;

    server_name kibana.domain.com;

    auth_basic "Restricted Access";
    auth_basic_user_file /etc/nginx/htpasswd.users;

    location / {
        proxy_pass http://localhost:5601;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```
7- the result:

![Hour 12]({{ site.url }}/images/2016/03/Screenshot_2016-03-28_11.59.40.png)
