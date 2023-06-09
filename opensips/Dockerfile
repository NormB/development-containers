# docker build -t opensips:0.0.1 -f Dockerfile .
# docker build --progress=plain -t opensips:0.0.1 -f Dockerfile .
# docker build -o type=local,dest=. -t opensips:0.1 -f Dockerfile .
# docker run -d --rm --privileged --cap-add sys_ptrace -p127.0.0.1:2222:22 -p 5060:5060 --name opensips opensips:0.1
# docker run -d --name opensips opensips:0.1

FROM debian:11.2 as builder

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

ENV LOCAL=/usr/local
ENV SRC=${LOCAL}/src
ENV PATH "$PATH:/usr/local/sbin"

USER root

# Set Environment Variables
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y tzdata \
    && apt-get install -y \
        apt-utils \
        autoconf \
        autogen \
        automake \
        bison \
        build-essential \
        ca-certificates \
        clang \
        cmake \
        dirmngr \
        doxygen \
        flex \
        g++ \
        gcc \
        gdb \
        git \
        gpg \
        gpg-agent \
        graphviz \
        iputils-ping \
        less \
        libavformat-dev \
        libboost-all-dev \
        libconfuse-dev \
        libcurl4 \
        libcurl4-openssl-dev \
        libedit-dev \
        libexpat1-dev \
        libhiredis-dev \
        libjson-c-dev \
        libjson-c5 \
        libjwt-dev \
        libldns-dev \
        libldns3 \
        liblua5.2-dev \
        libmicrohttpd-dev \
        libmicrohttpd12 \
        libmosquitto-dev\
        libmosquitto1 \
        libncurses5-dev \
        libopus-dev \
        libopusfile-dev \
        libpcre3 \
        libpcre3-dev \
        libpq-dev \
        libpq5 \
        libsndfile1 \
        libsndfile1-dev \
        libspeex-dev \
        libspeexdsp-dev \
        libspeexdsp1 \
        libsqlite3-dev \
        libssl-dev \
        libswscale-dev \
        libtiff-dev \
        libtool \
        libtool-bin \
        libxml2 \
        libxml2-dev \
        locales \
        lua5.2 \
        m4 \
        nasm \
        net-tools \
        netbase \
        ninja-build \
        pkg-config \
        procps \
        python \
        python3 \
        python3-distutils \
        rsync \
        rsyslog \
        sngrep \
        sqlite3 \
        tar \
        tcpdump \
        tzdata \
        uuid-dev \
        vim \
        wget \
        yasm \
        zlib1g-dev \
        llvm-dev libclang-dev clang \
    && apt clean

# compile locale definition file
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN echo UTC > /etc/timezone \
  && /usr/sbin/dpkg-reconfigure -f noninteractive tzdata

COPY opensips /usr/local/src/opensips

RUN cd /usr/local/src/opensips \
    && FASTER=1 make -j4 install \
    && make install

#RUN cd /usr/local/src \
#    && git clone https://github.com/opensips/opensips.git \
#    && cd /usr/local/src/opensips \
#    && git submodule update --init

ENV INCLUDE_MODULES \
    tls_mgm \
    tls_wolfssl \
    uuid \
    rest_client \
    regex \
    proto_tls \
    proto_wss \
    json \
    httpd \
    db_postgres \
    auth_jwt

COPY opensips.cfg /usr/local/etc/opensips/

RUN cd /usr/local/src/opensips \
    && make proper \
    && make TLS=1 include_modules="${INCLUDE_MODULES}" modules \
    && make TLS=1 include_modules="${INCLUDE_MODULES}" install

RUN groupadd -r opensips --gid=1001 \
    && useradd -r -g opensips --uid=1001 opensips \
    && chown -R opensips:opensips /usr/local/etc/opensips

# UI
EXPOSE 80
# HEP
EXPOSE 9060
# SIP
EXPOSE 5060

COPY entrypoint.sh /
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["opensips", "-F", "-E", "-u", "opensips", "-g", "opensips", "-P", "/usr/local/etc/opensips/opensips.pid"]

