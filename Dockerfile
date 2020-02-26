FROM golang:1.13

MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>

ARG http_proxy
ARG https_proxy

ENV GO111MODULE=on

ADD https://raw.githubusercontent.com/disaster37/che-scripts/master/debian.sh /tmp/debian.sh
RUN sh /tmp/debian.sh
USER dev

# Install specific tools needed by CHE
RUN \
    go get -u -v github.com/ramya-rao-a/go-outline@latest && \
    go get -u -v github.com/acroca/go-symbols@latest &&  \
    go get -u -v github.com/stamblerre/gocode@latest &&  \
    go get -u -v github.com/rogpeppe/godef@latest && \
    go get -u -v golang.org/x/tools/cmd/godoc@latest && \
    go get -u -v github.com/zmb3/gogetdoc@latest && \
    go get -u -v golang.org/x/lint/golint@latest && \
    go get -u -v github.com/fatih/gomodifytags@latest &&  \
    go get -u -v golang.org/x/tools/cmd/gorename@latest && \
    go get -u -v sourcegraph.com/sqs/goreturns@latest && \
    go get -u -v golang.org/x/tools/cmd/goimports@latest && \
    go get -u -v github.com/cweill/gotests@latest && \
    go get -u -v golang.org/x/tools/cmd/guru@latest && \
    go get -u -v github.com/josharian/impl@latest && \
    go get -u -v github.com/haya14busa/goplay/cmd/goplay@latest && \
    go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct@latest && \
    go get -u -v github.com/go-delve/delve/cmd/dlv@latest && \
    go get -u -v github.com/rogpeppe/godef@latest && \
    go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs@v2 && \
    go get -u -v golang.org/x/tools/cmd/gotype@latest && \
    go get -u -v golang.org/x/tools/gopls@latest && \
    go get -u -v github.com/stamblerre/gocode@latest

WORKDIR "/projects"
VOLUME "/home/dev"

CMD ["sleep", "infinity"]


