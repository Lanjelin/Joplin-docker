FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

LABEL maintainer="lanjelin"

ENV TITLE=Joplin-Docker
ENV VERSION=3.3.13

# add local files
COPY /root /

RUN \
    sed -i 's|</applications>|  <application title="Joplin-Docker" type="normal">\n    <maximized>no</maximized>\n  </application>\n</applications>|' /etc/xdg/openbox/rc.xml && \
  echo "**** update packages ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
      wget \
      libgtk-3-0 \
      libatspi2.0-0 \
      libsecret-1-0 && \
  echo "**** install Joplin ****" && \
    wget https://github.com/laurent22/joplin/releases/download/v${VERSION}/Joplin-${VERSION}.deb -O /tmp/joplin.deb && \
    apt install -y /tmp/joplin.deb && \
  echo "**** setting permissions ****" && \
    chmod 755 /defaults/autostart && \
  echo "**** cleanup ****" && \
    rm -rf \
      /tmp/* \
      /var/lib/apt/lists/* \
      /var/tmp/*

# ports and volumes
EXPOSE 3000 3001

WORKDIR /config
VOLUME /config
