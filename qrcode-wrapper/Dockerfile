FROM debian:stable-slim

ARG build_date="2020-12-16 15:15:12+09:00"
ARG name="yujiorama/qrcode-wrapper"
ARG description="encode/decode QR code image"
ARG usage="https://bitbucket.org/yujiorama/qrcode-wrapper/src/main/README.md"
ARG url="https://bitbucket.org/yujiorama/qrcode-wrapper.git"
ARG vcs_url="git@bitbucket.org:yujiorama/qrcode-wrapper.git"
ARG vcs_ref="8a31d9f"
ARG version="v0.0.1"

LABEL org.label-schema.build-date="${build_date}"
LABEL org.label-schema.name="${name}"
LABEL org.label-schema.description="${description}"
LABEL org.label-schema.usage="${usage}"
LABEL org.label-schema.url="${url}"
LABEL org.label-schema.vcs-url="${vcs_url}"
LABEL org.label-schema.vcs-ref="${vcs_ref}"
LABEL org.label-schema.version="${version}"

RUN set -x \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq -y \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -qq -y --no-install-recommends \
                    qrencode=4.0.2-1 \
                    zbar-tools=0.22-1 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && useradd -d / -s /sbin/nologin -g users -M -u 1001 user

COPY ./docker-entrypoint.sh /

RUN chmod 755 /docker-entrypoint.sh

WORKDIR /var/tmp
USER user
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["help"]
