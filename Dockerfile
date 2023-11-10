FROM ubuntu:latest

RUN apt update && apt install curl vim zip -y && apt install postgresql-client  postgresql-common -y

RUN apt install wget openjdk-17-jdk openjdk-17-jre maven -y  

RUN wget https://github.com/mozilla/sops/releases/download/v3.7.3/sops_3.7.3_amd64.deb && dpkg -i sops_3.7.3_amd64.deb

RUN apt install podman -y

RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg && echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list && apt update && apt install kubectl -y

RUN wget https://get.helm.sh/helm-v3.10.2-linux-amd64.tar.gz && tar xvf helm-v3.10.2-linux-amd64.tar.gz && mv linux-amd64/helm /usr/local/bin 

RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip && unzip awscliv2.zip && ./aws/install


RUN apt install python3-pip -y
RUN pip3 install requests
RUN pip3 install ansible
RUN ansible --version
#RUN pip3 install ansible==2.10.7