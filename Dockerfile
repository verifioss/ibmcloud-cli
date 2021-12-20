FROM alpine:3.15.0
LABEL description="IBM Cloud CLI Docker Image"
MAINTAINER habbdt@gmail.com

ENV IBMCLOUD_CLI_VERSION=2.3.0

USER root
WORKDIR "/tmp"

RUN apk update && \
    apk add --no-cache curl git wget bash bash-completion ncurses && \
    curl -LO https://download.clis.cloud.ibm.com/ibm-cloud-cli/${IBMCLOUD_CLI_VERSION}/IBM_Cloud_CLI_${IBMCLOUD_CLI_VERSION}_amd64.tar.gz && \
    tar -xvf  IBM_Cloud_CLI_${IBMCLOUD_CLI_VERSION}_amd64.tar.gz && \
    ./Bluemix_CLI/install && \
    ibmcloud plugin install infrastructure-service && \
    ibmcloud plugin install container-registry && \
    ibmcloud plugin install container-service && \
    ibmcloud plugin install fn && \
    ibmcloud plugin install cis && \
    ibmcloud plugin install dbaas-cli && \
    ibmcloud plugin install dns && \
    ibmcloud plugin install secrets-manager && \
    ibmcloud plugin install logging && \
    ibmcloud plugin install monitoring && \
    ibmcloud plugin install push && \
    ibmcloud plugin install code-engine && \
    ibmcloud plugin install tg-cli && \
    ibmcloud plugin install catalogs-management && \
    ibmcloud plugin install dl-cli && \
    ibmcloud plugin install cloudant && \
    ibmcloud plugin install schematics && \
    ibmcloud plugin install event-streams && \
    ibmcloud plugin install doi && \
    ibmcloud plugin install kp && \
    ibmcloud plugin install at && \
    ibmcloud plugin install cra && \
    ibmcloud plugin install en && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    kubectl version --client && \
    kubectl completion bash > /etc/profile.d/bash_completion.sh && \
    rm -rf kubectl IBM_Cloud_CLI_${IBMCLOUD_CLI_VERSION}_amd64.tar.gz Bluemix_CLI 

COPY bash_profile /root/.bash_profile
COPY bashrc /root/.bashrc

WORKDIR "/root"
ENV TERM linux
ENTRYPOINT ["/bin/sh", "-c"]