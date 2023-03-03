# Errbot + Slack

## Build up docker container
```bash
git clone https://github.com/wxlee/errbot-slack-in-docker.git
cd errbot-slack-in-docker
docker build -t errbot-slack .
docker run -d -p 3333:22 -v /opt/data:/mnt/data --name my-errbot errbot-slack
```

## Setup Config

Change the setting of following file

/etc/supervisor/conf.d/errbot.conf

/home/errbotuser/chatops/config.py


## Run it
```bash
systemctl enable supervisor
systemctl restart supervisor
```

