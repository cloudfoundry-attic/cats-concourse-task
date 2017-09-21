FROM ubuntu:trusty

RUN \
  apt-get update && \
  apt-get -y install \
    build-essential \
    wget \
    curl \
    openssh-client \
    unzip \
    jq \
    git

 ENV GOPATH /go
 ENV PATH /go/bin:/usr/local/go/bin:$PATH
 RUN \
  wget https://storage.googleapis.com/golang/go1.7.4.linux-amd64.tar.gz -P /tmp && \
  tar xzvf /tmp/go1.7.4.linux-amd64.tar.gz -C /usr/local && \
  mkdir $GOPATH && \
  rm -rf /tmp/*

# Install the cf CLI
ARG version
RUN wget -q -O cf.deb "https://cli.run.pivotal.io/stable?release=debian64&version=${version}&source=github-rel"
RUN dpkg -i cf.deb
