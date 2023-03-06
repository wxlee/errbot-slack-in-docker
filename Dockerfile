FROM ubuntu:22.04

ENV JENKINS_USER_TOKEN ""
ENV JENKINS_PRJ_TOKEN ""
ENV JENKINS_URL ""
ENV BOT_TOKEN ""

RUN apt-get update && \
    apt-get install -y openssh-server vim git curl python3.11 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd
RUN echo 'root:YouNeverSeeThat' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
  
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
  
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Create errbot user
RUN useradd -ms /bin/bash errbotuser
USER errbotuser
WORKDIR /home/errbotuser 

# Install errbot
RUN pip install errbot[slack]

RUN mkdir chatops && cd chatops && /home/errbotuser/.local/bin/errbot --init && \
	python3 -m pip install -U pyOpenSSL cryptography

RUN mkdir /home/errbotuser/chatops/backend && \
	cd /home/errbotuser/chatops/backend && \
	git clone https://github.com/errbotio/err-backend-slackv3 && \
	cd err-backend-slackv3/ && pip install .

COPY --chown=errbotuser:errbotuser errbot_config.py /home/errbotuser/chatops/config.py

CMD ["/home/errbotuser/.local/bin/errbot", "--config", "/home/errbotuser/chatops/config.py"]
