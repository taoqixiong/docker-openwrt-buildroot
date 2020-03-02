FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

RUN apt-get update \
    &&apt-get -y install wget ca-certificates \
    &&wget -qO- git.io/superupdate.sh | bash

RUN apt-get update \
    && apt-get -y install screen \
    && apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3.5 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib linux-libc-dev:i386 \
    && apt-get clean

RUN useradd -m lede \
    && echo 'lede ALL=NOPASSWD: ALL' > /etc/sudoers.d/lede

USER lede
WORKDIR /home/lede

RUN git clone https://github.com/coolsnowwolf/lede \
    && lede/scripts/feeds update -a \
    && lede/scripts/feeds install -a
