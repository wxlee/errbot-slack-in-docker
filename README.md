# Errbot + Slack

## Build up docker container
```bash
git clone https://github.com/wxlee/errbot-slack-in-docker.git
cd errbot-slack-in-docker
docker build -t errbot-slack .
docker run -d -p 3333:22 -v /opt/data:/mnt/data --name my-errbot errbot-slack
```

## Setup Config

Login and change the setting of following file

docker exec -it CONTAINER_ID bash

/etc/supervisor/conf.d/errbot.conf

/home/errbotuser/chatops/config.py


## Run it
```bash
/etc/init.d/supervisor start
```

