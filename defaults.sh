if [ -z "${NetworkAddr}}" ];   then export NetworkAddr="172.17.2.0/24"; fi
if [ -z "${NetworkName}" ];    then export NetworkName="net172.17.2"; fi
if [ -z "${MongoIPv4}" ];      then export MongoIPv4="172.17.2.11"; fi
if [ -z "${MongoName}" ];      then export MongoName="mongo4chat"; fi
if [ -z "${RocketChatIPv4}" ]; then export RocketChatIPv4="172.17.2.10"; fi
if [ -z "${RocketChatURL}" ];  then export RocketChatURL="http://rocketchat/chat"; fi
if [ -z "${RCName}" ];         then export RCName="rocketchat"; fi

