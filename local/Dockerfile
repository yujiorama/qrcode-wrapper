FROM golang:1.15-alpine as golang

FROM docker:19-dind

COPY --from=golang /usr/local/go /usr/local/go
COPY --from=golang /go /go

ARG HADOLINT_VERSION=1.19.0

RUN set -x \
 && apk add --no-cache shellcheck xmlstarlet curl git \
 && sh -c "$(curl -sSL https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin \
 && curl -fsSL -o /usr/local/bin/hadolint "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT_VERSION}/hadolint-Linux-x86_64" \
 && chmod +x /usr/local/bin/hadolint \
 && sh -c "$(curl -fsSL https://git.io/shellspec)" -- -d /usr/local/shellspec -b /usr/local/bin --yes

WORKDIR /app
COPY . /app

RUN cp /app/local/entrypoint.sh /entrypoint.sh \
 && chmod a+x /entrypoint.sh
