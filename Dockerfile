FROM pataquets/ubuntu:bionic

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y install gpg \
  && \
  . /etc/lsb-release && \
  echo "deb http://ppa.launchpad.net/mumble/release/ubuntu ${DISTRIB_CODENAME} main" \
    | tee /etc/apt/sources.list.d/mumble.list && \
  DEBIAN_FRONTEND=noniteractive \
    apt-key adv --keyserver hkp://hkps.pool.sks-keyservers.net --recv-keys 7F05CF9E \
  && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y purge --autoremove \
      gpg \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get -y install mumble-server \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

EXPOSE 64738/tcp
EXPOSE 64738/udp

ENTRYPOINT [ "murmurd", "-fg", "-v" ]
