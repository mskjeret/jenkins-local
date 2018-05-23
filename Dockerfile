FROM jenkins/jenkins:lts

COPY --chown=jenkins data/ /var/jenkins_home/

USER root
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl software-properties-common && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && apt-key fingerprint 0EBFCD88 && \
     add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu zesty stable" && apt-get update && apt-get install -y docker-ce && rm -rf /var/lib/apt/lists/*

RUN usermod -a -G root jenkins
# drop back to the regular jenkins
USER jenkins
