FROM debian:9

ENV BITCOIN_VERSION=0.17.1
ENV BITCOIN_DATA=/home/bitcoin/.bitcoin
ENV GOSU_VERSION=1.10

COPY sources.list /tmp/sources.list
COPY docker-entrypoint.sh /entrypoint.sh

RUN useradd -r bitcoin \
    && cat /tmp/sources.list > /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get install -y curl gnupg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && set -ex \
    && for key in \
        B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    ; do \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys "$key" || \
    gpg --keyserver hkps://hkps.pool.sks-keyservers.net --recv-keys "$key"; \
    done

RUN curl -o /usr/local/bin/gosu -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture) \
    && curl -o /usr/local/bin/gosu.asc -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

RUN curl -SL https://bitcoin.org/laanwj-releases.asc | gpg --import \
    && curl -SLO https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VERSION}/SHA256SUMS.asc \
    && curl -SLO https://bitcoin.org/bin/bitcoin-core-${BITCOIN_VERSION}/bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz \
    && gpg --verify SHA256SUMS.asc \
    && grep " bitcoin-${BITCOIN_VERSION}-x86_64-linux-gnu.tar.gz\$" SHA256SUMS.asc | sha256sum -c - \
    && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
    && rm *.tar.gz *.asc \
    && chmod +x /entrypoint.sh

#VOLUME ["/home/bitcoin/.bitcoin"]

EXPOSE 8332 8333 18332 18333 18443 18444

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bitcoind"]