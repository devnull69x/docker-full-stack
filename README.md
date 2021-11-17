# [docker-full-stack](https://github.com/gerekper/docker-full-stack) #
not tested yet

## What is it ##
As the title says, it allows for consolidation of the modules in docker full stack arsenal

## Create Google Cloud Compute Alpine ##

#### create your own alpine ####
```
https://riedstra.dev/2019/09/alpine-gcp
```

## Create Google Cloud Compute Sh8s ##

#### unison-master ####
```
gcloud compute instances create unison-master --project=$PROJECT_NAME --zone=asia-southeast1-a --machine-type=e2-medium \
--network-interface=network-tier=PREMIUM,private-network-ip=10.148.0.100,subnet=default --maintenance-policy=MIGRATE \
--service-account=xxxxxxxxxxxxx-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,\
https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,\
https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,\
device-name=unison-master,image=projects/$PROJECT_NAME/global/images/alpine-gcp-sshkeys,mode=rw,size=100,type=projects/$PROJECT_NAME/zones/asia-southeast1-a/diskTypes/pd-ssd \
--reservation-affinity=any
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

