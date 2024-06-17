FROM alpine:3.19

LABEL maintainer="limingxinleo <l@hyperf.io>" version="1.0" license="MIT"

RUN set -ex \
    && apk update \
    && apk add --no-cache curl openssl git \
    && git clone https://gitee.com/neilpang/acme.sh.git \
    && cp ./acme.sh/acme.sh /usr/local/bin/acme.sh \
    && chmod u+x /usr/local/bin/acme.sh
