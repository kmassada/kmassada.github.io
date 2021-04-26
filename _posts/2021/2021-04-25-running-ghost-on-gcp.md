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
export ZONE=us-west1-a

gcloud iam service-accounts create $NODE_SA --display-name 'GCE '"${VM_NAME}"' Node Service Account' \
&& sleep 10 && \
export NODE_SA_ID=`gcloud iam service-accounts list --format='value(email)' --filter='displayName:GCE '"${VM_NAME}"' Node Service Account'`
```

bind custom role

```shell
gcloud projects add-iam-policy-binding $PROJECT_ID --member=serviceAccount:${NODE_SA_ID} --role=projects/$PROJECT_ID/roles/$CUSTOM_ROLE
```

In the future will need logging and storing objects in GCE, might add `roles/logging.logWriter`, but for now only strictly need to write to buckets and read to bucket,  `roles/storage.objectCreator` and `roles/storage.objectViewer` will be sufficient 


```shell
gcloud projects add-iam-policy-binding $PROJECT_ID --member=serviceAccount:${NODE_SA_ID} --role=roles/storage.objectCreator
gcloud projects add-iam-policy-binding $PROJECT_ID --member=serviceAccount:${NODE_SA_ID} --role=roles/storage.objectViewer
```

create fw rules, certbot uses tcp:80 for the ACME challenge, instead of closing port 80, we'll use nginx to force redirect to https

```shell
gcloud compute --project=$PROJECT_ID firewall-rules create default-allow-ghostv4 --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:80,tcp:443 --source-ranges=0.0.0.0/0 --target-tags=$VM_NAME-server
```

we run on COS

```shell
COS_STABLE=`gcloud compute images list --format="value(NAME)" --filter="selfLink~cos-cloud AND family~stable" --limit=1`
```

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

