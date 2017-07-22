---
layout:
title: "Docker Lessons Learned: 3 months in"
date: 2016-03-27 11:31 -0400
excerpt: "Tips and Tricks I've acquired after using docker for close to 3 months."
categories: [projects]
---

In my primer my usage was very limited, and there are a few questions i've been able to answer and I'd like to share the top ones. These I think are questions beginners itch to answer as they become intermediates.

## Backing up image
this will create data.zip of /usr/app/data and back it up at /data/backup

```
docker run --volumes-from data-container -v $(pwd):/usr/app ubuntu zip -r /usr/app/data /data/backup
```

## Bash into image
run a bash session straight into a container, where ID=container-name

```
docker run -it $ID bash
```

## Restart Policy
I've always thought, running a container on a daemon will make it persist on error, but it doesn't you have to set always restart.

```
docker run --restart=always -d redis /bin/bash
```

## SECURITY
add some boundaries on what can and cannot be done on a container, because containers do offer a security woe when accessible from shell, it is hard to restrict from shell's access

```
--cap-add and --cap-del
```

## nginx proxy
jwilder nginx proxy allows you to, using environment variable VIRTUAL_HOST set on container, using docker remote events api, it can register any new domain you need for reverse proxy.

simply run the nginx container attached to port 80, and still run your containers as normal, it should pick your domains up and register them.

```
docker run -d -p 80:80 -v /var/run/docker.sock:/tmp/docker.sock jwilder/nginx-proxy
```

## cross-container IP/communication
when in the same docker-compose, containers whithin the compose are accessible by either service name or container name automagically, however I had the use case where I like to keep a compose with every project, so I had a Node APi backed by Mongo, and that had it's own docker-compose, but also had an angular client, with it's own compose file. the way around is to create `--links` or `external-links:` in docker-compose. referencing other containers by `name:alias`, this alias then can be used in the code.

Or you could simply attempt to get a container's IP by running

```
docker inspect --format='\{\{.NetworkSettings.IPAddress}}'  $ID
```

## labels and search

## Registry

### tag and push

```
docker tag [-f|--force[=false] IMAGE [REGISTRYHOST/][USERNAME/]NAME[:TAG]
docker push [REGISTRYHOST/][USERNAME/]NAME[:TAG]
```
