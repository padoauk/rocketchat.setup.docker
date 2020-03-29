#!/bin/bash

source parameters.sh
source defaults.sh

cat docker-compose.yml.tmpl |
  sed s@'{{HostFQDN}}'@${HostFQDN}@g  | \
  sed s@'{{NetworkAddr}}'@${NetworkAddr}@g | \
  sed s@'{{NetworkName}}'@${NetworkName}@g | \
  sed s@'{{MongoIPv4}}'@${MongoIPv4}@g | \
  sed s@'{{MongoName}}'@${MongoName}@g | \
  sed s@'{{RocketChatIPv4}}'@${RocketChatIPv4}@g | \
  sed s@'{{RCName}}'@${RCName}@g | \
  sed s@'{{RocketChatURL}}'@${RocketChatURL}@g \
  | cat

