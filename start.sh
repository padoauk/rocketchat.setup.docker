#!/bin/bash

# Copyright (C) Toshinao Ishii <padoauk@gmail.com> All Rights Reserved.

# prepare docker storage and network
# invoke docker compose

x="parameters.sh"
if [ -f $x ]; then
  source $x 
fi

source defaults.sh

StorageNames="\
  mongo.db \
  rocketchat.uploads \
"
if [ -z "$NetworkAddr" ]; then
  NetworkAddr="172.17.2.0/24"
fi
if [ -z "$NetworkName" ]; then
  NetworkName="net172.17.2"
fi

######################################################
DEBUG=""
if [ ! -z "$1" ] && [ "$1" == 'debug' ]; then
  DEBUG="echo"
fi

function stop_if_error(){
  if [ $1 != '0' ]; then
    echo $2
    exit $1
  fi
}

# prepare storage
for x in $StorageNames; do
  if [ -z "$(docker volume ls | grep $x)" ]; then
    $DEBUG docker volume create "$x"
    stop_if_error $? "failed docker volume create" 
  fi
done

# prepare network
x="$NetworkName"
y="$NetworkAddr"
if [ -z "$(docker network ls | grep $x)" ]; then
  $DEBUG docker network create --driver=bridge --subnet="$y" --ip-range="$y" "$x"
  stop_if_error $? "failed docker network create" 
fi

# dockercompose
bash gen_docker-compose.yml.sh > docker-compose.yml
$DEBUG docker-compose up -d
stop_if_error $? "docker-compose up" 

# wait some time
sleep 5

# mongodb replica set must be initialized just once
$DEBUG docker exec -it "$MongoName" mongo \
  --eval "printjson(rs.initiate( '{ _id: "rs0", members: [ {_id: 0, host: "mongo4chat:27017"} ] }' ))" 
stop_if_error $? "failed to init mongo replica set" 
$DEBUG docker cp reconfigRS.js mongo4chat:/tmp
stop_if_error $? "failed to copy reconfigRS.js" 
$DEBUG docker exec -it mongo4chat mongo /tmp/reconfigRS.js
stop_if_error $? "failed to exec reconfigRS.js" 


