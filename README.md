# Errbot + Slack

## Build up docker image
```bash
git clone https://github.com/wxlee/errbot-slack-in-docker.git
cd errbot-slack-in-docker
docker build --no-cache -t errbot-slack .
```

## Create Env variables
```bash
mkdir ../env-file/

vim ../env-file/errbot.env

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

