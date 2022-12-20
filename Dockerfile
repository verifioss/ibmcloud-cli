FROM alpine:3.17.0
LABEL description="IBM Cloud CLI Docker Image"
MAINTAINER habbdt@gmail.com

ENV IBMCLOUD_CLI_VERSION=2.13.0

USER root
WORKDIR "/tmp"

RUN apk update && \
    apk add --no-cache curl bash bash-completion ncurses jq && \
    curl -LO https://download.clis.cloud.ibm.com/ibm-cloud-cli/${IBMCLOUD_CLI_VERSION}/IBM_Cloud_CLI_${IBMCLOUD_CLI_VERSION}_amd64.tar.gz && \
    tar -xvf  IBM_Cloud_CLI_${IBMCLOUD_CLI_VERSION}_amd64.tar.gz && \
    ./Bluemix_CLI/install && \
    ibmcloud plugin repo-plugins -r "IBM Cloud" --output json | jq -r '."IBM Cloud"|.[].name' | while read plg; do \
    ibmcloud plugin install -f -r "IBM Cloud" $plg; done || : && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl && \
    kubectl version --client && \
    rm -rf kubectl IBM_Cloud_CLI_${IBMCLOUD_CLI_VERSION}_amd64.tar.gz Bluemix_CLI 

COPY bash_profile /root/.bash_profile
COPY bashrc /root/.bashrc

WORKDIR "/root"
ENV TERM linux
ENTRYPOINT ["/bin/bash", "-c"]