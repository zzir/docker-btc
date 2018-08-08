FROM debian:9

WORKDIR /tmp

ENV BITCOIN_VERSION=0.17.2
ENV BITCOIN_DATA=/home/bitcoin/.bitcoin
ENV GOSU_VERSION=1.10

COPY sources.list /tmp/sources.list
COPY docker-entrypoint.sh /entrypoint.sh

RUN useradd -r bitcoin \
    && cat /tmp/sources.list > /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get install -y libboost-all-dev libzmq3-dev build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils python3 libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev \
    && apt-get install -y curl unzip gnupg \
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

RUN curl -SLO https://github.com/Bitcoin-ABC/bitcoin-abc/archive/v${BITCOIN_VERSION}.zip \
    && unzip v${BITCOIN_VERSION}.zip && cd bitcoin-abc-${BITCOIN_VERSION}\
    && ./autogen.sh \
    && ./configure --disable-wallet --disable-gui \
    && make && make install \
    && make check \
    && rm -rf /tmp/* \
    && chmod +x /entrypoint.sh

VOLUME ["/home/bitcoin/.bitcoin"]

EXPOSE 8332 8333 18332 18333 18443 18444

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bitcoind"]