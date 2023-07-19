FROM ubuntu:latest

ARG VERSION=22.0
ARG TRUSTED_PUB_KEY_FINGERPRINT=01EA5486DE18A882D4C2684590C8019E36C2E964
ARG ARCH=x86_64

RUN apt update
RUN apt install wget gnupg -y

RUN cd /tmp  \
    && gpg --keyserver hkp://keyserver.ubuntu.com --recv-keys ${TRUSTED_PUB_KEY_FINGERPRINT} \
    && wget https://bitcoincore.org/bin/bitcoin-core-${VERSION}/SHA256SUMS.asc \
    https://bitcoincore.org/bin/bitcoin-core-${VERSION}/SHA256SUMS \
    https://bitcoincore.org/bin/bitcoin-core-${VERSION}/bitcoin-${VERSION}-${ARCH}-linux-gnu.tar.gz

COPY ./scripts/verify_downloads.sh /tmp
RUN cd /tmp \
    && chmod u+x verify_downloads.sh \
    && ./verify_downloads.sh ${TRUSTED_PUB_KEY_FINGERPRINT}

WORKDIR /app

RUN mv /tmp/bitcoin-${VERSION}-${ARCH}-linux-gnu.tar.gz /app \
    && rm -rf /tmp/bitcoin-${VERSION}-${ARCH}-linux-gnu.tar.gz 

RUN cd /app && tar -xvzf bitcoin-${VERSION}-${ARCH}-linux-gnu.tar.gz 
COPY ./configuration/bitcoin.conf /app/bitcoin-${VERSION}/bin

EXPOSE 8333

ENTRYPOINT ["/app/bin/bitcoin-${VERSION}/bin/bitcoind", "-conf=/app/bin/bitcoin-${VERSION}/bin/bitcoin.conf"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]

