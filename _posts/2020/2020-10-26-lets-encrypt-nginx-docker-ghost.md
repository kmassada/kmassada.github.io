---
layout: single
title: "Running ghost blog with nginx reverse proxy and let's encrypt"
excerpt: "I've been using the blog platform ghost for hosting tadbit.cc, and now twdspodcast.com, this is a quick brain dump on how I host the blog. It's simply nginx reverse proxy, ghost platform backed by mysql, and now the reverse proxy gets it's cert from let's encrypt"
date: 2020-10-20 00:00 -0400
tags: [ghost, blog]
---

I've been using the blog platform ghost for hosting [tadbit](https://tadbit.cc), and now [twdspodcast](https://twdspodcast.com), this is a quick brain dump on how I host the blog. It's simply nginx reverse proxy, ghost platform backed by mysql, and now the reverse proxy gets it's cert from let's encrypt. This is let's get this to work fast and re-iterate later.

I create a gcp instance only running container optimized OS, allow http/https with a public IP. This public IP becomes A record in my domain records.

```
@      A      1h       ##.##.##.###
```

I ssh into the instance in the UI 

## House keeping

We create a network, this network is super helpful so we don't manage ips and routes for container to container

```shell
docker network create znet
mkdir -p "$data_path"
```

## Environment

First I create a `.env` file to keep all the variables I need for my setup. 

```
domains=(example.org www.example.org)
domain=example.org
email="admin@example.org" 
mysql_local_pass=STUFFMAN
data_path="/tmp/data/certbot"
```

*quick note:* /tmp/ is not a good path for saving data... I eventually create a disk that I mount to /tmp/data, I omit this in this setup.

```
source .env
```

Now that this is sourced , let's move on to running the blog platform itself. 


## Ghost

Run an instance of mysql first.

```shell
docker run --name=mysql --restart=always -d -p 3306:3306 \
 --net=znet \
-e MYSQL_ROOT_PASSWORD=$mysql_local_pass mysql
```

use those credentials to then run the blog 

```shell
docker run --name=ghost --restart=always -d \
-v $data_path/blog:/var/lib/ghost/content \
-p 3001:2368 \
 --net=znet \
-e url=http://$domain \
-e database__client=mysql \
-e database__connection__host=mysql \
-e database__connection__user=root \
-e database__connection__password=$mysql_local_pass \
-e database__connection__database=ghost \
ghost
```

### quirk of mysql

I did run into a small issue with how ghost authenticates against mysql, it's well documented: [https://github.com/mysqljs/mysql/issues/1507](https://github.com/mysqljs/mysql/issues/1507)

this was the quick fix

```shell
docker exec -it YOUR_CONTAINER mysql -u root -p
Enter password:
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY '{your password}';
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '{your password}';
SELECT plugin FROM mysql.user WHERE User = 'root';
```

in my case after the quick fix, restart ghost `docker restart ghost`

## Nginx + certbot

First we download the recommended ssl configs for nginx provided by certbot and ssl params, then we make a make belief cert that we later delete, we configure nginx and start it with make belief cert. Now when that's complete we use certbot to gain staging cert, when successful we get production certs.

### Download SSL Conf and ssl-dhparams.pem

Download required files from github.

```shell
mkdir -p "$data_path/conf"
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "$data_path/conf/options-ssl-nginx.conf"
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "$data_path/conf/ssl-dhparams.pem"
```

### make belief certificate

```shell
path="/etc/letsencrypt/live/$domains"
mkdir -p "$data_path/conf/live/$domains"
mkdir -p "$data_path/conf/nginx"
```

use the nginx pod to run openssl for obtaining make belief cert

```
docker run  --rm -it \
  -v $data_path/conf:/etc/letsencrypt -v $data_path/www:/var/www/certbot \
   nginx sh -c "mkdir -p $path && openssl req -x509 -nodes -newkey rsa:1024 -days 1\
    -keyout '$path/privkey.pem' \
    -out '$path/fullchain.pem' \
    -subj '/CN=localhost'"
```

### start nginx 

this stage is important because here we are testing the vailidity of our nginx reverse proxy settings.

```shell
docker run  --name=nginx --restart=always -d \
  -v $data_path/conf:/etc/letsencrypt -v $data_path/www:/var/www/certbot \
  -v $data_path/nginx:/etc/nginx/conf.d \
  -p 80:80 -p 443:443 \
   --net=znet \
   nginx 
```

now we delete the dummies with confidence

```
docker run -it --rm \
-v $data_path/conf:/etc/letsencrypt -v $data_path/www:/var/www/certbot \
nginx sh -c"\
  rm -Rf /etc/letsencrypt/live/$domains && \
  rm -Rf /etc/letsencrypt/archive/$domains && \
  rm -Rf /etc/letsencrypt/renewal/$domains.conf"
```

### configure nginx pre-stage

Setup the file

```shell
mkdir -p $data_path/nginx/
touch validate.conf
```

we configure nginx to allow for a callback to `/.well-known/acme-challenge/`. this will allow the staging command to verify ownership of the domain


```conf

server {
  listen        80;
  server_name   _;

  location / {
    return 301 https://$host$request_uri;
  }

  location /.well-known/acme-challenge/ {
    root /var/www/certbot;
    allow all;
    try_files $uri =404;
  }
}
```


### stage cert

We run through one example in `staging` using `--register-unsafely-without-email --agree-tos `. This confirms to us letsencrypt ability to generate a valid cert for the site, and also guards against quotas. 

```shell
docker run -it --rm \
-v $data_path/conf:/etc/letsencrypt -v $data_path/www:/var/www/certbot \
certbot/certbot \
certonly --webroot \
--webroot-path=/var/www/certbot \
--register-unsafely-without-email --agree-tos \
--staging \
-d $domain -d www.$domain
```

### prod cert

we now run this finally command to get the actual cert

```shell
docker run -it --rm \
-v $data_path/conf:/etc/letsencrypt -v $data_path/www:/var/www/certbot \
certbot/certbot \
certonly --webroot \
--webroot-path=/var/www/certbot \
--email $email --agree-tos --no-eff-email \
-d $domain -d www.$domain
```

At this stage I could docker run with a shell command wrapped in sleep to keep validating the cert and auto renew it, but since there'll have to be a subsequent post where I try to automate this, we'll leave it as it for now.

### configure nginx reverse proxy for ghost w/ ssl

Setup the file


```shell
mkdir -p $data_path/nginx/
touch site.conf
```

Few things to know
- `http://ghost:2368` is the path direct to the ghost container, because they share `znet` network
- many settings look like they are missing but they come from `options-ssl-nginx.conf`. as we downloaded earlier.

```shell
server {

    listen 443;
    server_name example.org;

    # this include is the recommended ssl settings by let's encrypt
    include /etc/letsencrypt/options-ssl-nginx.conf;

    add_header Strict-Transport-Security    "max-age=31536000; includeSubDomains" always;
    add_header X-Frame-Options              SAMEORIGIN;
    add_header X-Content-Type-Options       nosniff;
    add_header X-XSS-Protection             "1; mode=block";


    # this is the dhparam we downloaded from the onset
    ssl_dhparam                 /etc/letsencrypt/ssl-dhparams.pem;
    ssl_certificate             /etc/letsencrypt/live/example.org/fullchain.pem;
    ssl_certificate_key         /etc/letsencrypt/live/example.org/privkey.pem;

    # sometimes exporting this is useful too
    access_log            /var/log/nginx/example.org.access.log;

    location / {

      proxy_set_header    X-Real-IP           $remote_addr;      
      proxy_set_header    X-Forwarded-For     $proxy_add_x_forwarded_for;
      proxy_set_header    X-Forwarded-Proto   $scheme;
      proxy_set_header    Host                $host;
      proxy_set_header    X-Forwarded-Host    $host;
      proxy_set_header    X-Forwarded-Port    $server_port;

      # Fix the “It appears that your reverse proxy set up is broken" error.
      proxy_pass          http://ghost:2368;
      proxy_read_timeout  90;

      proxy_redirect      http://ghost:2368 https://example.org;
    }
  }
```


## issues
[no-resolver-defined-to-resolve](https://community.letsencrypt.org/t/no-resolver-defined-to-resolve-ocsp-int-x3-letsencrypt-org-while-requesting-certificate-status-responder-ocsp-int-x3-letsencrypt-org/21427)