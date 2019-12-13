FROM golang:1.13.4-stretch

ENV SERVERLESS serverless@1.59.3
ENV GOPATH /go
ENV PATH $GOPATH/bin:/root/.yarn/bin:$PATH

RUN mkdir /.cache && \
    mkdir /.cache/go-build
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y unzip git-core curl build-essential openssl libssl-dev git
RUN	go get -u github.com/rancher/trash

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
    apt-get install -y nodejs
RUN npm install -g $SERVERLESS
RUN curl -s -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip -o sonarscanner.zip  && \
    unzip -qq sonarscanner.zip && \
    rm -rf sonarscanner.zip && \
    mv sonar-scanner-3.3.0.1492-linux /usr/bin/sonar-scanner

ENV PATH /usr/bin/sonar-scanner/bin:$PATH