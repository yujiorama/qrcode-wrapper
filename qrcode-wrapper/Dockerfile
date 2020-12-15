FROM debian:stable-slim

RUN set -x \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq -y \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -qq -y --no-install-recommends \
                    qrencode=4.0.2-1 \
                    zbar-tools=0.22-1 \
 && useradd -d / -s /sbin/nologin -g users -M -u 1001 user

COPY ./docker-entrypoint.sh /

RUN chmod 755 /docker-entrypoint.sh

WORKDIR /var/tmp
USER user
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["help"]
