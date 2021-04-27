---
layout: single
title: "Ghost Maintenance and Backup on GCS"
excerpt: "I've been using the blog platform ghost for hosting tadbit.cc, and now twdspodcast.com. Migrating to Ghost 4, this post is explores Ghost maintenance and backups"
date: 2021-04-27 00:00 -0400
tags: [ghost, blog, gcp]
---

I've been using the blog platform ghost for hosting tadbit.cc, and now twdspodcast.com. Migrating to Ghost 4, this post is explores Ghost maintenance and backups. This article isn't really useful if you aren't familiar with my setup. [Running Ghost on GCP](/running-ghost-on-gcp) and [Running ghost blog with nginx reverse proxy and let’s encrypt](/lets-encrypt-nginx-docker-ghost).

The TLDR is I build a gce instance that runs 2 containers, one for ghost and one for nginx. I use nginx as a reverse proxy to the ghost container. Recently I've added the complexity of saving the ghost data in mysql instead of a volume attached to the ghost container. Also, I now use let's encrypt to generate or manage my certificates.

Few important assumptions to note for this post
* I created my instance in `us-west1-a` and I created my storage bucket in `us-west1` to reduce cost.
* I created my instance with a service account, that service account and it's scope is what allows me to backup to GCS without having to download keys. 

## Backup

```shell
now=$(date +'%Y-%m-%d_%H-%M')
mkdir -p /tmp/data/$now
```

when we created the blog, we saved the blog files at `$data_path/blog`, we'll tar the relevant files in that folder. I do use `data/redirect.json` and `settings/routes.yaml` quite a bit, and I have purchased 2 themes `{Massively-master,hue}`, this should exclude `logs`, `themes/casper` 

```shell
cd $data_path
tar -zcvf /tmp/data/blog-$now.tar.gz blog/images blog/data blog/settings blog/themes/{Massively-master,hue}
```

when we launched the mysql container, we used **mysql** as the name, therefore `docker exec mysql` will exec into our container

```shell
docker exec mysql sh -c 'exec mysqldump ghost -uroot -p"$MYSQL_ROOT_PASSWORD"' > /tmp/data/ghost-$now.sql
```

After backing up I have 2 files I can use.

```shell
/tmp/data $ sudo du -sh *
37M     blog-2021-04-26_01-31.tar.gz
3.4M    ghost_prod-2021-04-26_01-31.sql
```

## Storage 

[https://cloud.google.com/free/docs/gcp-free-tier/#storage](https://cloud.google.com/free/docs/gcp-free-tier/#storage)

project is still in testing phase, i'm going to attempt to spend $0 on my backup. With this goal in mind, i'll setup gcs storage bucket, only keep 2 revisions, and delete objects older than 35 days, with the goal of backing up once a month. 

The location matters, only few locations have free tier. Knowing this ahead of time, my GCE instance was also built in the same Region as where the storage will reside in an attempt to get FREE local transfer. 

set some environement variables,

```shell
PROJECT_ID=<your project>
STORAGE_CLASS=STANDARD
BUCKET_LOCATION=us-west1
```
create `lifecycle.json` and edit it to contain the following.

```json
{
"lifecycle": {
  "rule": [
  {
    "action": {"type": "Delete"},
    "condition": {
      "numNewerVersions": 2
    }
  },
  {
    "action": {"type": "Delete"},
    "condition": {
      "age": 35,
      "isLive": false
    }
  }
]
}
}
```

create storage bucket and set the lifecycle policy and versioning. 

```shell
gsutil mb -b on -p $PROJECT_ID -c $STORAGE_CLASS -l $BUCKET_LOCATION -b on gs://$PROJECT_ID-ghost-backup 
gsutil versioning set on gs://$PROJECT_ID-ghost-backup
gsutil lifecycle set lifecycle.json gs://$PROJECT_ID-ghost-backup
```

now let's enable [UBL](https://cloud.google.com/storage/docs/uniform-bucket-level-access). UBL is this thing that allows you to enforce IAM roles/permissions (`roles/storage.objectViewer`) on a bucket (`gs://$PROJECT_ID-ghost-backup`) restricted only to a GCP service account (`serviceAccount:$NODE_SA_ID`).

`NODE_SA_ID` is the service account I used to create the instance in [Running Ghost on GCP](/running-ghost-on-gcp), which will allow me to bypass having to deal with credentials management.


```shell
gsutil iam ch serviceAccount:$NODE_SA_ID:roles/storage.objectViewer gs://$PROJECT_ID-ghost-backup
gsutil iam ch serviceAccount:$NODE_SA_ID:roles/storage.objectCreator gs://$PROJECT_ID-ghost-backup
```

if you set `objectViewer` and `objectCreator` at the ServiceAccount level, you can undo it by running the following

```shell
gcloud projects remove-iam-policy-binding $PROJECT_ID --member=serviceAccount:${NODE_SA_ID} --role=roles/storage.objectCreator
gcloud projects remove-iam-policy-binding $PROJECT_ID --member=serviceAccount:${NODE_SA_ID} --role=roles/storage.objectViewer
```

### Upload

before let's prepare, possible this is already in order

```shell
now=$(date +'%Y-%m-%d_%H-%M')
data_path="/tmp/data"
mkdir -p "$data_path"
sudo chown $USER "$data_path"  
sudo chmod 755 "$data_path" 
```

Now run the following 

```shell
docker run --name cloud-sdk -it \
  --restart=always -d \
  -v $data_path/backup:$data_path/backup \
  -e now=$now \
  -e data_path=$data_path \
  -e PROJECT_ID=$PROJECT_ID google/cloud-sdk
docker exec -it cloud-sdk /bash/bin/sh
```

once in the shell setup `gsutils` by running `gcloud init`, follow the prompts. 

of course `gcloud auth list` can verify the caller. 

while we're at it let's test our permissions

```shell
# gsutil ls
AccessDeniedException: 403 $NODE_SA does not have storage.buckets.list access to the Google Cloud project.
```

let's upload the latest backup to the bucket

```shell
gsutil cp $data_path/backup/blog-$now.tar.gz gs://$PROJECT_ID-ghost-backup/blog.tar.gz
gsutil cp $data_path/backup/ghost-$now.sql gs://$PROJECT_ID-ghost-backup/ghost.sql
```

now let's verify the backup is there... 

```shell
gsutil ls gs://$PROJECT_ID-ghost-backup/
```

## Retrieve

This seems redundant, but in an actual upgrade/move scenario, this will be ran from another instance.

```shell
docker run --name cloud-sdk -it \
  --restart=always -d \
  -v $data_path/backup:$data_path/backup \
  -e now=$now \
  -e data_path=$data_path \
  -e PROJECT_ID=$PROJECT_ID google/cloud-sdk
docker exec -it cloud-sdk /bash/bin/sh
```

once again setup `gsutils` by running `gcloud init`, follow the prompts. 

now let's retrieve the backup

```shell
gsutil cp gs://$PROJECT_ID-ghost-backup/blog.tar.gz $data_path/backup/blog-$now.tar.gz
gsutil cp gs://$PROJECT_ID-ghost-backup/ghost.sql $data_path/backup/ghost-$now.sql
```

now let's cleanup

```shell
docker rm -f cloud-sdk
```

## Restore

In [Running ghost blog with nginx reverse proxy and let’s encrypt](/lets-encrypt-nginx-docker-ghost), we created a mysql container and a ghost container to start the setup. 

### DB

Assuming I was to start from scratch, the first thing to do would be to create the mysql container, apply the fix for a small ghost mysql integration issue: [https://github.com/mysqljs/mysql/issues/1507](https://github.com/mysqljs/mysql/issues/1507), all of this is copiously documented in [Running ghost blog with nginx reverse proxy and let’s encrypt](/lets-encrypt-nginx-docker-ghost) and restore the backup.  

```shell
docker exec -i mysql sh -c 'mysql -u root -p'"${mysql_local_pass}"' ghost' < $data_path/backup/ghost-$now.sql
```

### Files

The second thing to do would be to restore the files before starting the ghost container.

```shell
mkdir -p $data_path/restore
tar -xvf $data_path/backup/blog-$now.tar.gz -C $data_path/restore

mv $data_path/restore/blog/images $data_path/blog/
mv $data_path/restore/blog/themes/{hue,Massively-master} $data_path/blog/themes/
mv $data_path/restore/blog/data/redirects.json $data_path/blog/data/redirects.json
mv $data_path/restore/blog/settings/routes.yaml $data_path/blog/settings/routes.yaml
```

the remaining of [Running ghost blog with nginx reverse proxy and let’s encrypt](/lets-encrypt-nginx-docker-ghost) should still be valid for creating certs and creating ways to auto-renew the certs