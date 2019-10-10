FROM ubuntu:14.04

RUN apt-get update \
    && apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint \
    && apt-get clean

RUN useradd -m lede \
    && echo 'lede ALL=NOPASSWD: ALL' > /etc/sudoers.d/lede

USER lede
WORKDIR /home/lede

RUN git clone https://github.com/coolsnowwolf/lede \
    && lede/scripts/feeds update -a \
    && lede/scripts/feeds install -a