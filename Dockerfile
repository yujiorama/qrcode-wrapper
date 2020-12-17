FROM atlassian/default-image:2

ARG HADOLINT=1.19.0
ARG TRIVY=0.14.0
ARG DOCKER=20.10.0

RUN set -x \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get update -qq -y \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install -qq -y \
            git \
            xmlstarlet \
 ;

RUN set -x \
 && sh -c "$(wget --quiet -O - https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin \
 && task --version \
 ;

RUN set -x \
 && wget --quiet -O /usr/local/bin/hadolint "https://github.com/hadolint/hadolint/releases/download/v${HADOLINT}/hadolint-$(uname -s | tr A-Z a-z)-$(uname -m)" \
 && chmod +x /usr/local/bin/hadolint \
 && hadolint --version \
 ;

RUN set -x \
 && wget --quiet -O - "https://github.com/aquasecurity/trivy/releases/download/v${TRIVY}/trivy_${TRIVY}_$(uname -s | tr A-Z a-z)-64bit.tar.gz" | \
    tar xzvf - -C /usr/local/bin \
 && chmod +x /usr/local/bin/trivy \
 && trivy --version \
 ;

RUN set -x \
 && sh -c "$(wget --quiet -O - https://git.io/shellspec)" -- -b /usr/local/bin --yes \
 && shellspec --version \
 ;

RUN set -x \
 && wget --quiet -O - "https://download.docker.com/linux/static/stable/$(uname -m)/docker-${DOCKER}.tgz" | \
    tar xzvpf - -C /usr/local \
 && chmod +x /usr/local/docker/docker \
 && ln -s /usr/local/docker/docker /usr/local/bin/docker \
 && docker --version \
 ;

RUN set -x \
 && curl -fsSL --output - "https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.$(uname -s | tr A-Z a-z).$(uname -m).tar.xz" | \
    tar xJvpf - -C /usr/local \
 && chmod +x /usr/local/shellcheck-stable/shellcheck \
 && ln -s /usr/local/shellcheck-stable/shellcheck /usr/local/bin/shellcheck \
 && shellcheck --version \
 ;

WORKDIR /src
COPY . /src

ENTRYPOINT ["/bin/bash", "-c"]
CMD ["bash"]
