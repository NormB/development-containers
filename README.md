Rough (very rough) environement that creates a development
environment consisting of

* Vault - not configured
* FreeSWITCH
* OpenSIPS
* Mosquitto
* PostgreSQL

Interesting commands:

```clone.sh``` - Should be run the first time this repo is cloned.

```clean.sh``` - Tries to remove the docker images

```pull.sh``` - Updates the various repositories

```docker compose build``` - Rebuilds the containers

```docker compose up``` - Starts the containers - output is in the foreground, good for debugging

```docker compose up -d``` - Starts the containers - daemon / detached mode

```docker compose down``` - Shuts down the containers

```docker logs opensips -f``` - Tails the opensips container logs. Can also be adjusted to log the output from any other container

```docker exec -it --user root opensips bash``` - Logs into the OpenSIPS container

