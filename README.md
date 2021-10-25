# [docker-full-stack](https://github.com/gerekper/docker-full-stack) #
not tested yet

## What is it ##
As the title says, it allows for consolidation of the modules in gerekper.asia arsenal

## Create Google Cloud Compute Sh8s ##

#### unison-master ####
```
gcloud compute instances create unison-master --project=$PROJECT_NAME --zone=asia-southeast1-a --machine-type=e2-medium --network-interface=network-tier=PREMIUM,subnet=default --maintenance-policy=MIGRATE --service-account=$PROJECT_CLOUD-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=unison-master,image=projects/debian-cloud/global/images/debian-10-buster-v20210916,mode=rw,size=50,type=projects/$PROJECT_NAME/zones/asia-southeast1-a/diskTypes/pd-ssd --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --reservation-affinity=any
```
#### unison-node-0 ####
```
gcloud compute here
```

#### unison-node-1 ####
```
gcloud compute here
```

#### unison-node-2 ####
```
gcloud compute here
```

#### unison-node-3 ####
```
gcloud compute here
```

## Features ###
| Function      | mgt/worker-server1    |  worker-server2   | 
| :------------ | :------:              | :------:          | 
| redis-master  |  :yes:                |  :no:       | 
| Humans.txt    |  :✓:          |  :o:       | 
| Robot Logs    |  :✓:          |  :x:       | 
| Agents        |  :o:          |  :x:       | 
| Robot Traps   |  :o:          |  :o:       | 

- Consolidate all working modules

## Thanks ##

