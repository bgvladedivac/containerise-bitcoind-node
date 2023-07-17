FROM ubuntu:latest

ARG VERSION=22.0
ARG KEY_FINGERPRINT=01EA5486DE18A882D4C2684590C8019E36C2E964

RUN apt update
RUN apt install wget -y

RUN cd /tmp  \
  && wget https://bitcoin.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-x86_64-linux-gnu.tar.gz \
  && wget https://bitcoin.org/bin/bitcoin-core-${VERSION}/SHA256SUMS.asc \
