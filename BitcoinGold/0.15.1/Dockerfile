FROM debian:9

ENV BITCOIN_GOLD_VERSION=0.15.1
ENV BITCOIN_GOLD_DATA=/home/bitcoingold/.bitcoingold
ENV GOSU_VERSION=1.10

COPY sources.list /tmp/sources.list
COPY docker-entrypoint.sh /entrypoint.sh

RUN useradd -r bitcoingold \
    && cat /tmp/sources.list > /etc/apt/sources.list \
    && apt-get update -y \
    && apt-get install -y curl gnupg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && set -ex \
    && for key in \
    B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    38EE12EB597B4FC0 \
    ; do \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys "$key" || \
    gpg --keyserver hkps://hkps.pool.sks-keyservers.net --recv-keys "$key"; \
    done

RUN curl -o /usr/local/bin/gosu -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture) \
    && curl -o /usr/local/bin/gosu.asc -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && chmod +x /usr/local/bin/gosu

RUN curl -SLO https://github.com/BTCGPU/BTCGPU/releases/download/v${BITCOIN_GOLD_VERSION}/bitcoin-gold-${BITCOIN_GOLD_VERSION}-x86_64-linux-gnu.tar.gz \
    && curl -SLO https://github.com/BTCGPU/BTCGPU/releases/download/v${BITCOIN_GOLD_VERSION}/SHA256SUMS.asc \
    && gpg --verify SHA256SUMS.asc \
    && grep " bitcoin-gold-${BITCOIN_GOLD_VERSION}-x86_64-linux-gnu.tar.gz\$" SHA256SUMS.asc | sha256sum -c - \
    && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
    && rm *.tar.gz \
    && chmod +x /entrypoint.sh

VOLUME ["/home/bitcoingold/.bitcoingold"]

EXPOSE 9332 9333 19332 19333 19444

ENTRYPOINT ["/entrypoint.sh"]

CMD ["bgoldd"]