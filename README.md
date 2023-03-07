# Errbot + Slack

Docker version 23.0.1

Docker Compose version v2.16.0



## Build up docker image
```bash
git clone https://github.com/wxlee/errbot-slack-in-docker.git
cd errbot-slack-in-docker
docker build --no-cache -t errbot-slack .
```

## Create Env variables
```bash
mkdir ../env_file/

vim ../env_file/errbot.env

# tokens
# jenkins api
JENKINS_USER_TOKEN="..."
JENKINS_PRJ_TOKEN="..."
JENKINS_URL="...:8080"

# slack token
BOT_TOKEN="xoxb-..."
```

## Run use docker-compose
```bash
# run as daemon
docker-compose up -d

# tail log
docker-compose logs -f
```

## Change the config.py for ACL and restart
```bash
# edit ACL
docker exec -it CONTAINER_ID vim /home/errbotuser/chatops/config.py

# restart
docker-compose restart app
```

## Add plugins
```bash
docker exec -it CONTAINER_ID bash

# In container
cd chatops/plugins
git clone YOUR_PLUGIN

docker-compose restart app
```

## Volumes for plugin develop

If you run docker-compose using root, you need to change the owner of folder on HOST.

```bash
chown 1000:1000 -R ~/container_errbot
```

And create link to plugin path in container.
```bash
cd ~/chatops/host_vol
git clone YOUR_PLUGINS

cd ~/chatops/plugins
ln -s ../host_vol/YOUR_PLUGINS YOUR_PLUGINS
```

Restart App
```bash
docker-compose restart app
```

