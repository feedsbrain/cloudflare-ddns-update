FROM ubuntu:jammy

# disable prompt
ENV DEBIAN_FRONTEND=noninteractive

# install required packages
RUN apt update && apt install -y locales bash curl

# install open ssl 1.1.1 for backward compatibility (ubuntu:jammy)
RUN curl -o /tmp/libssl1.1_1.1.0l-1~deb9u6_amd64.deb http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.1_1.1.0l-1~deb9u6_amd64.deb
RUN apt install -y /tmp/libssl1.1_1.1.0l-1~deb9u6_amd64.deb

# set locale
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

# clean up image
RUN rm -rf /var/lib/apt/lists/*  /tmp/libssl*.deb

# set environment variables
ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# injecting the script
WORKDIR /cron

COPY ./update-ddns.sh .
RUN chmod +x update-ddns.sh

CMD ["/cron/update-ddns.sh"]
