FROM golang:1.12

MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>

ARG http_proxy
ARG https_proxy

ENV GO111MODULE=on

ADD https://raw.githubusercontent.com/disaster37/che-scripts/master/debian.sh /tmp/debian.sh
RUN sh /tmp/debian.sh

# Install specific tools needed by CHE
RUN \
  go get -u -v github.com/ramya-rao-a/go-outline &&\
  go get -u -v github.com/uudashr/gopkgs/cmd/gopkgs@latest &&\
  go get -u -v honnef.co/go/tools &&\
  go get -u -v github.com/golangci/golangci-lint &&\
  go get -u -v github.com/mgechev/revive &&\
  go get -u -v github.com/ramya-rao-a/go-outline &&\
  go get -u -v github.com/acroca/go-symbols &&\
  go get -u -v github.com/mdempsky/gocode &&\
  go get -u -v github.com/rogpeppe/godef &&\
  go get -u -v golang.org/x/tools/cmd/godoc &&\
  go get -u -v github.com/zmb3/gogetdoc &&\
  go get -u -v golang.org/x/lint/golint &&\
  go get -u -v github.com/fatih/gomodifytags &&\
  go get -u -v golang.org/x/tools/cmd/gorename &&\
  go get -u -v sourcegraph.com/sqs/goreturns &&\
  go get -u -v golang.org/x/tools/cmd/goimports &&\
  go get -u -v github.com/cweill/gotests &&\
  go get -u -v golang.org/x/tools/cmd/guru &&\
  go get -u -v github.com/josharian/impl &&\
  go get -u -v github.com/haya14busa/goplay/cmd/goplay &&\
  go get -u -v github.com/davidrjenni/reftools/cmd/fillstruct &&\
  go get -u -v github.com/go-delve/delve/tree/master/cmd/dlv &&\
  go get -u -v github.com/tylerb/gotype-live &&\
  go get -u github.com/sourcegraph/go-langserver &&\
  gometalinter --install

WORKDIR "/projects"
VOLUME "/home/dev"

CMD ["sleep", "infinity"]


