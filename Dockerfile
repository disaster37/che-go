FROM golang:1.12

MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>

ARG http_proxy
ARG https_proxy

ENV GO111MODULE=on

ADD https://raw.githubusercontent.com/disaster37/che-scripts/master/debian.sh /tmp/debian.sh
RUN sh /tmp/debian.sh
USER dev

# Install specific tools needed by CHE
RUN \
  go get -u github.com/ramya-rao-a/go-outline &&\
  go get -u github.com/uudashr/gopkgs/cmd/gopkgs@latest &&\
  go get -u honnef.co/go/tools &&\
  go get -u github.com/golangci/golangci-lint &&\
  go get -u github.com/mgechev/revive &&\
  go get -u github.com/ramya-rao-a/go-outline &&\
  go get -u github.com/acroca/go-symbols &&\
  go get -u github.com/mdempsky/gocode &&\
  go get -u github.com/rogpeppe/godef &&\
  go get -u golang.org/x/tools/cmd/godoc &&\
  go get -u github.com/zmb3/gogetdoc &&\
  go get -u golang.org/x/lint/golint &&\
  go get -u github.com/fatih/gomodifytags &&\
  go get -u golang.org/x/tools/cmd/gorename &&\
  go get -u sourcegraph.com/sqs/goreturns &&\
  go get -u golang.org/x/tools/cmd/goimports &&\
  go get -u github.com/cweill/gotests &&\
  go get -u golang.org/x/tools/cmd/guru &&\
  go get -u github.com/josharian/impl &&\
  go get -u github.com/haya14busa/goplay/cmd/goplay &&\
  go get -u github.com/davidrjenni/reftools/cmd/fillstruct &&\
  go get -u github.com/tylerb/gotype-live &&\
  go get -u github.com/sourcegraph/go-langserver &&\
  go get -u gotest.tools/gotestsum

WORKDIR "/projects"
VOLUME "/home/dev"

CMD ["sleep", "infinity"]


