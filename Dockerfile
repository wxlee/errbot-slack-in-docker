FROM ubuntu:22.04
  
RUN apt-get update && apt-get install -y openssh-server vim virtualenv supervisor git curl
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

# Setup virtualenv and install errbot
RUN virtualenv .venv
ENV VIRTUAL_ENV=/home/errbotuser/.venv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN $VIRTUAL_ENV/bin/pip install errbot[slack]

RUN mkdir chatops && cd chatops && \
	$VIRTUAL_ENV/bin/errbot --init

RUN mkdir /home/errbotuser/chatops/backend && \
	cd /home/errbotuser/chatops/backend && \
	git clone https://github.com/errbotio/err-backend-slackv3 && \
	cd err-backend-slackv3/ && pip install .

COPY --chown=errbotuser:errbotuser errbot_config.py /home/errbotuser/chatops/config.py
ADD supervisor_errbot.conf /etc/supervisor/conf.d/errbot.conf

COPY --chmod=755 run.sh /run.sh

USER root

EXPOSE 22
CMD ["/run.sh"]
