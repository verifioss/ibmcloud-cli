FROM alpine:3.15.0
LABEL description="IBM Cloud CLI Docker Image"
MAINTAINER habbdt@gmail.com

ENV IBMCLOUD_CLI_VERSION=2.3.0
ENV UID=3001
ENV GID=3001

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
    addgroup -g "$GID" ibmcli && \
    adduser -h /home/ibmcli -g "IBM Cloud Cli Docker Image User" -s /bin/bash -G ibmcli -D -u "$UID" ibmcli && \
    rm -rf kubectl IBM_Cloud_CLI_${IBMCLOUD_CLI_VERSION}_amd64.tar.gz Bluemix_CLI 

COPY bash_profile /root/.bash_profile
COPY bashrc /root/.bashrc

USER ibmcli
WORKDIR "/home/ibmcli"
ENV TERM linux
ENTRYPOINT ["/bin/sh", "-c"]