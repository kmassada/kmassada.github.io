---
layout: single
title: "Running ghost blog on GCP, using GCE"
excerpt: "I've been using the blog platform ghost for hosting tadbit.cc, and now twdspodcast.com. Using the Ghost 4 launch as an excuse to tidy up how I create the instances and run them on GCP using GCE instances"
date: 2021-04-25 00:00 -0400
tags: [ghost, blog, gcp]
---

I've been using the blog platform ghost for hosting tadbit.cc, and now twdspodcast.com. Using the Ghost 4 launch as an excuse to tidy up how I create the instances and run them on GCP using GCE instances. This guide will go through creating a GCE instance with minimal roles/scopes, trying to keeping instance options to the least priviledged and thinking about costs. 

## Pre-Reqs

```
PROJECT_ID=<your project>
CUSTOM_ROLE=ghostGCEnode
```

## Serivice Account and Roles

let's create the user

```shell
cat << EOF >> $HOME/$CUSTOM_ROLE.yaml
title: $CUSTOM_ROLE
description: Role for least privileged GCE user running ghost 
stage: GA
includedPermissions:
- compute.networks.use
- compute.networks.useExternalIp
- compute.subnetworks.use
- compute.instances.osLogin
- compute.disks.use
EOF
 ```

create the role

```sh
gcloud iam roles create $CUSTOM_ROLE --project=$PROJECT_ID \
  --file=$HOME/$CUSTOM_ROLE.yaml
```

create a service account

```shell
export VM_NAME=ghostv4
export NODE_SA=gce-$VM_NAME-node-sa
export ZONE=us-west1-b

gcloud iam service-accounts create $NODE_SA --display-name 'GCE '"${VM_NAME}"' Node Service Account' \
&& sleep 10 && \
export NODE_SA_ID=`gcloud iam service-accounts list --format='value(email)' --filter='displayName:GCE '"${VM_NAME}"' Node Service Account'`
```

### bind custom role

```shell
gcloud projects add-iam-policy-binding $PROJECT_ID --member=serviceAccount:${NODE_SA_ID} --role=projects/$PROJECT_ID/roles/$CUSTOM_ROLE
```

### Storage roles (Option A)
In the future will need logging and storing objects in GCE, might add `roles/logging.logWriter`, but for now only strictly need to write to buckets and read to bucket,  `roles/storage.objectCreator` and `roles/storage.objectViewer` will be sufficient...


```shell
gcloud projects add-iam-policy-binding $PROJECT_ID --member=serviceAccount:${NODE_SA_ID} --role=roles/storage.objectCreator
gcloud projects add-iam-policy-binding $PROJECT_ID --member=serviceAccount:${NODE_SA_ID} --role=roles/storage.objectViewer
```

### Storage roles (Option B)

[UBL](https://cloud.google.com/storage/docs/uniform-bucket-level-access), could actually lock down access further.. 

```
gsutil iam ch serviceAccount:$NODE_SA_ID:roles/storage.objectViewer gs://_______BUCKET_____NAME_______
gsutil iam ch serviceAccount:$NODE_SA_ID:roles/storage.objectCreator gs://_______BUCKET_____NAME_______
```

### Setup Firewall

create fw rules, certbot uses tcp:80 for the ACME challenge, instead of closing port 80, we'll use nginx to force redirect to https

```shell
gcloud compute --project=$PROJECT_ID firewall-rules create default-allow-$VM_NAME --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80,tcp:443 --source-ranges=0.0.0.0/0 --target-tags=$VM_NAME-server
```

### Setup Image

we run on COS

```shell
COS_STABLE=`gcloud compute images list --format="value(NAME)" --filter="selfLink~cos-cloud AND family~stable" --limit=1`
```

### Launch Instance

create an instance with the Service account, later we can add `logging-write,storage-rw` to the scope for the scopes for future use of GCR and GCS

few cost cutting measures, they do have performance implications
* [network tier standard](https://cloud.google.com/network-tiers)
* [zone us-west1-a](https://cloud.google.com/free/docs/gcp-free-tier#free-tier-usage-limits) to qualify for free tier for GCS 
* [boot disk 10G](https://cloud.google.com/compute/disks-image-pricing#disk)
* [disk type pd-standard](https://cloud.google.com/compute/docs/disks#disk-types)
* instance type e2-micro, estimated at $10/month, [f1-micro qualifies for free tier](https://cloud.google.com/free/docs/gcp-free-tier#free-tier-usage-limits)

```shell
gcloud compute instances create $VM_NAME \
  --image=$COS_STABLE \
  --image-project=cos-cloud \
  --zone=$ZONE \
  --boot-disk-size=10G \
  --boot-disk-type=pd-standard \
  --machine-type=e2-micro \
  --scopes=compute-rw\
  --tags $VM_NAME-server \
  --network-tier STANDARD \
  --network=default \
  --service-account=$NODE_SA_ID
```

### Launch an Instance with an External SSD 

alternatively here's a slightly increased performance version 
* with a 32GB ssd to preserve data
* e2-small instead of e2-micro for 2G of ram

```shell
gcloud compute instances create $VM_NAME \
  --image=$COS_STABLE \
  --image-project=cos-cloud \
  --zone=$ZONE \
  --boot-disk-size=10G \
  --boot-disk-type=pd-standard \
  --machine-type=e2-small \
  --scopes=compute-rw\
  --tags $VM_NAME-server \
  --network-tier STANDARD \
  --network=default \
  --service-account=$NODE_SA_ID \
 --create-disk=mode=rw,size=32,type=projects/$PROJECT_ID/zones/$ZONE/diskTypes/pd-ssd,name=$VM_NAME-data,device-name=$VM_NAME-data
```

TLDR on folllowing the guide to [mount a disk on a container-optimized-os instance](https://cloud.google.com/container-optimized-os/docs/concepts/disks-and-filesystem)

You can find `DEVICE_NAME` by running `lsblk`. in our case the output looks like this

```shell
~ $ lsblk
NAME      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda         8:0    0   10G  0 disk 
|-sda1      8:1    0  5.9G  0 part /mnt/stateful_partition
|-sda2      8:2    0   16M  0 part 
|-sda3      8:3    0    2G  0 part 
| `-vroot 253:0    0    2G  1 dm   /
|-sda4      8:4    0   16M  0 part 
|-sda5      8:5    0    2G  0 part 
|-sda6      8:6    0  512B  0 part 
|-sda7      8:7    0  512B  0 part 
|-sda8      8:8    0   16M  0 part /usr/share/oem
|-sda9      8:9    0  512B  0 part 
|-sda10     8:10   0  512B  0 part 
|-sda11     8:11   0    8M  0 part 
`-sda12     8:12   0   32M  0 part 
sdb         8:16   0   32G  0 disk
```

we then use `sdb` in our script to format disk

```shell
DEVICE_NAME=sdb
MOUNT_DIR=$HOSTNAME-data
sudo mkfs.ext4 -m 0 -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/$DEVICE_NAME
sudo mkdir -p /mnt/disks/$MOUNT_DIR
sudo mount -o discard,defaults /dev/$DEVICE_NAME /mnt/disks/$MOUNT_DIR
sudo chmod a+w /mnt/disks/$MOUNT_DIR
```

here's the cloud config that will auto mount the disk, the equivalent of doing an `fstab` on debian

```shell
cat << EOF >> $HOME/$VM_NAME-cloud-config.yaml
#cloud-config

bootcmd:
- fsck.ext4 -tvy /dev/sdb
- mkdir -p /mnt/disks/$VM_NAME-data
- mount -t ext4 -o discard,defaults /dev/sdb /mnt/disks/$VM_NAME-data
EOF
```

modify instance to have cloud-config

```shell
gcloud compute instances add-metadata $VM_NAME \
    --metadata-from-file user-data=$VM_NAME-cloud-config.yaml
```

you can check by rebooting and observing `lsblk`, in our case it's mounted

```shell
~ $ lsblk
NAME      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda         8:0    0   10G  0 disk 
|-sda1      8:1    0  5.9G  0 part /mnt/stateful_partition
|-sda2      8:2    0   16M  0 part 
|-sda3      8:3    0    2G  0 part 
| `-vroot 253:0    0    2G  1 dm   /
|-sda4      8:4    0   16M  0 part 
|-sda5      8:5    0    2G  0 part 
|-sda6      8:6    0  512B  0 part 
|-sda7      8:7    0  512B  0 part 
|-sda8      8:8    0   16M  0 part /usr/share/oem
|-sda9      8:9    0  512B  0 part 
|-sda10     8:10   0  512B  0 part 
|-sda11     8:11   0    8M  0 part 
`-sda12     8:12   0   32M  0 part 
sdb         8:16   0   32G  0 disk /mnt/disks/$VM_NAME-data
```

### Verify

When you've accessed the instance, we can run `gcloud auth list` to confirm the caller, it is `$NODE_SA_ID`

```
$ docker run --rm -ti google/cloud-sdk gcloud auth list
                    Credentialed Accounts
ACTIVE  ACCOUNT
*       $NODE_SA_ID

To set the active account, run:
    $ gcloud config set account `ACCOUNT`
```