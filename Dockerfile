FROM alpine:3.18

LABEL maintainer="limingxinleo <l@hyperf.io>" version="1.0" license="MIT"

RUN set -ex \
    && apk update \
    && apk add --no-cache curl openssl \
    && curl https://get.acme.sh | sh \
    && ln -s /root/.acme.sh/acme.sh /usr/local/bin/acme.sh \
    && chmod u+x /usr/local/bin/acme.sh
