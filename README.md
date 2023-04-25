Rough (very rough) environement that creates a development
environment consisting of

* Vault - not configured
* FreeSWITCH
* OpenSIPS
* Mosquitto
* PostgreSQL

Interesting commands:

```clean.sh``` - tries to remove the docker images
```pull.sh``` - updates the various repositories

```docker compose build``` - rebuilds the containers

```docker compose up``` - starts the containers - output is in the foreground

```docker compose up -d``` - starts the containers - daemon / detached mode

```docker compose down``` - shuts down the containers
