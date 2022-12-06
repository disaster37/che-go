# Copyright (c) 2019 Red Hat, Inc.
# This program and the accompanying materials are made
# available under the terms of the Eclipse Public License 2.0
# which is available at https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Contributors:
#   Red Hat, Inc. - initial API and implementation

FROM golang:1.19.3-bullseye

ENV HOME=/home/theia \
    DAGGER_VERSION="v0.2.36"

RUN mkdir /projects ${HOME} && \
    # Change permissions to let any arbitrary user
    for f in "${HOME}" "/etc/passwd" "/projects"; do \
      echo "Changing permissions on ${f}" && chgrp -R 0 ${f} && \
      chmod -R g+rwX ${f}; \
    done

# Install / Configure Golang
RUN set -e -x && \
    go install github.com/acroca/go-symbols@latest &&\
    go install github.com/cweill/gotests/gotests@latest &&\
    go install github.com/davidrjenni/reftools/cmd/fillstruct@latest &&\
    go install github.com/haya14busa/goplay/cmd/goplay@latest &&\
    go install github.com/stamblerre/gocode@latest &&\
    mv /go/bin/gocode /go/bin/gocode-gomod &&\
    go install github.com/mdempsky/gocode@latest &&\
    go install github.com/ramya-rao-a/go-outline@latest &&\
    go install github.com/rogpeppe/godef@latest &&\
    go install github.com/sqs/goreturns@latest &&\
    go install github.com/uudashr/gopkgs/v2/cmd/gopkgs@latest &&\
    go install github.com/zmb3/gogetdoc@latest &&\
    go install honnef.co/go/tools/cmd/staticcheck@latest &&\
    go install golang.org/x/tools/cmd/gorename@latest &&\
    go install github.com/go-delve/delve/cmd/dlv@latest &&\
    go install golang.org/x/tools/gopls@latest &&\
    chmod -R 777 /go && \
    mkdir -p /.cache && chmod -R 777 /.cache && \
    mkdir -p /usr/local/go && chmod -R 777 /usr/local/go &&\
    cd /usr/local/go && wget -O- -nv https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s v1.46.2
ENV GOPATH /go
ENV GOCACHE /.cache
ENV GOROOT /usr/local/go

# Install some tools like docker
RUN \
  apt-get update &&\
  apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    gnupg \
    lsb-release \
    vim &&\
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg &&\
  echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null &&\
apt-get update &&\
apt-get install -y --no-install-recommends docker-ce-cli

# Install dagger
RUN echo "Install dagger" &&\
    curl -o- -L https://github.com/dagger/dagger/releases/download/${DAGGER_VERSION}/dagger_${DAGGER_VERSION}_linux_amd64.tar.gz | tar xvz -C /usr/local/bin --strip-components=0 &&\
    chmod +x /usr/local/bin/dagger

ADD etc/entrypoint.sh /entrypoint.sh

RUN \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ${HOME}/.cache

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ${PLUGIN_REMOTE_ENDPOINT_EXECUTABLE}