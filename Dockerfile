FROM debian:stable-slim

RUN DEBIAN_FRONTEND=noninteractive apt-get update --fix-missing && \
    apt-get install -y --force-yes wget && \
    wget https://github.com/bitly/oauth2_proxy/releases/download/v2.2/oauth2_proxy-2.2.0.linux-amd64.go1.8.1.tar.gz && \
    tar xzvf /oauth2_proxy-2.2.0.linux-amd64.go1.8.1.tar.gz && \
    cp /oauth2_proxy-2.2.0.linux-amd64.go1.8.1/oauth2_proxy /usr/bin/oauth2_proxy


# Install CA certificates
RUN apt-get update -y && apt-get install -y ca-certificates
