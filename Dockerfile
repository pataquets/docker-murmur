FROM pataquets/ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

RUN \
  apt-get update && \
  apt-get -y install \
    ca-certificates \
    gpg \
  && \
  . /etc/lsb-release && \
  echo "deb http://ppa.launchpad.net/mumble/release/ubuntu ${DISTRIB_CODENAME} main" \
    | tee /etc/apt/sources.list.d/mumble.list && \
  apt-key adv --keyserver hkps://keyserver.ubuntu.com --recv-keys 85DECED27F05CF9E \
  && \
  apt-get -y purge --autoremove \
    gpg \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN \
  apt-get update && \
  apt-get -y install mumble-server \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 64738/tcp
EXPOSE 64738/udp

ENTRYPOINT [ "murmurd", "-fg", "-v" ]
