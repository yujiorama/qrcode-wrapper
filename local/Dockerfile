FROM golang:1.15-alpine as golang

FROM docker:19-dind

COPY --from=golang /usr/local/go /usr/local/go
COPY --from=golang /go /go

ARG HADOLINT=1.19.0
ARG TRIVY=0.13.0

RUN set -x \
 && apk add --no-cache shellcheck xmlstarlet git

RUN set -x \
 && sh -c "$(wget -O - https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin \
 && task --version

RUN set -x \
 && wget -O /usr/local/bin/hadolint "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT}/hadolint-Linux-x86_64" \
 && chmod +x /usr/local/bin/hadolint \
 && hadolint --version

RUN set -x \
 && sh -c "$(wget -O - https://git.io/shellspec)" -- -d /usr/local/shellspec -b /usr/local/bin --yes \
 && shellspec --version

RUN set -x \
 && wget -O - https://github.com/aquasecurity/trivy/releases/download/v${TRIVY}/trivy_${TRIVY}_Linux-64bit.tar.gz | \
    tar xzvf - -C /usr/local/bin \
 && trivy --version

WORKDIR /app
COPY . /app
