# Rocketchat docker containers setup utilities

## How to Use
To start, just invoke `bash start.sh`.
To stop, just invoke `docker-compose down`.

Usually, one do not need to invoke for stopping nor restarting because of `restart: unless-stopped` of the docker-compose.yml.

## Parameters
All the configurable parameters of this utility are defined in parameter.sh whose default values are defined in defaults.sh.

## How it works
There are two essential things. One is to generaet docker-compose.yml from its template and parameters. One can see volumes for mongod and rocket.chat uploads. The other is to configure replica set of the mongod. Since the initial replica member is specified by the docker container ID, the initial configuration does not work when the container is replaced. The replica member must be specified by an constant value. To solve this, hostnames of the conatiners are explicitly specified as "mongo4chat" and "rocketchat" and the replica set member is explicitly specified by using this name. See reconfigRS.js for detail.
 
