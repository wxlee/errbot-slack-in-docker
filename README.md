# Errbot + Slack

## Build up docker container
```bash
git clone https://github.com/wxlee/errbot-slack-in-docker.git
cd errbot-slack-in-docker
docker build -t errbot-slack .
docker run -d --name my-errbot errbot-slack
```

## Create Env variables
```bash
mkdir ../env-file/

vim ../env-file/errbot.env

# tokens
JENKINS_USER_TOKEN="..."
JENKINS_PRJ_TOKEN="..."
JENKINS_URL="...:8080"
BOT_TOKEN="xoxb-..."
```

## Build images
```bash
docker-compose create
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
docker-compose restart
```
