# docker build -t freeswitch:0.0.1 -f Dockerfile .
# docker build --progress=plain -t freeswitch:0.0.1 -f Dockerfile .
# docker build -o type=local,dest=. -t freeswitch:0.0.1 -f Dockerfile .
# docker run -d --rm --privileged --cap-add sys_ptrace -p127.0.0.1:2222:22 -p 5060:5060 --name freeswitch freeswitch:0.0.1
# docker run -d --name freeswitch freeswitch:0.1

FROM debian:latest as builder

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

ENV LOCAL=/usr/local
ENV SRC=${LOCAL}/SRC
ENV PATH="$PATH:/usr/local/freeswitch/bin"

RUN apt-get install -y tzdata \
    && apt-get update \
    && apt-get install -y \
        gcc \
        g++ \
        gdb \
        clang \
        cmake \
        rsync \
        tar \
        python3 \
        python3-distutils \
        vim \
        ca-certificates \
        wget \
        apt-utils \
        gpg \
        gpg-agent \
        dirmngr \
        locales \
        git \
        autoconf \
        autogen \
        automake \
        build-essential \
        libtool-bin \
        pkg-config \
        uuid-dev \
        libtiff-dev \
        libssl-dev \
        sqlite3 \
        libsqlite3-dev \
        libcurl4-openssl-dev \
        libpcre3 \
        libpcre3-dev \
        libspeexdsp1 \
        libspeex-dev \
        libspeexdsp-dev \
        libldns3 \
        libldns-dev \
        libedit-dev \
        libopus-dev \
        libopusfile-dev \
        nasm \
        yasm \
        libavformat-dev \
        libswscale-dev \
        lua5.2 \
        liblua5.2-dev \
        libpq-dev \
        libsndfile1 \
        libsndfile1-dev \
        libmosquitto1 \
        libmosquitto-dev\
	doxygen \
	graphviz \
	libboost-all-dev \
        default-jre \ 
        default-jdk \
	net-tools \
	tcpdump \
	ngrep \
        iputils-ping \
        llvm-dev libclang-dev clang \
    && rm -rf /var/lib/apt/lists/*

# compile locale definition file
RUN localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

COPY . /usr/local/src

RUN cd /usr/local/src/spandsp \
    && ./bootstrap.sh \
    && ./configure \
    && make \
    && make install \
    && ldconfig

RUN cd /usr/local/src/sofia-sip \
    && ./bootstrap.sh \
    && ./configure \
    && make \
    && make install \
    && ldconfig

RUN cd /usr/local/src/libks \
    && cmake . \
    && make install \
    && ldconfig

RUN cd /usr/local/src/signalwire-c \
    && cmake . \
    && make install \
    && ldconfig

RUN cd /usr/local/src/freeswitch \
    && ./bootstrap.sh \
    && autoreconf --force --install \
    && ./configure \
    && make \
    && make install \
    && make cd-moh-install \
    && make cd-sounds-install \
    && ldconfig

RUN cd /usr/local/src/freeswitch \
    && cp ../build/modules.conf modules.conf \
    && mkdir -p src/mod/outoftree \
    && cp -rp ../mod_mosquitto src/mod/outoftree \
    && cp ../deploy/autoload_configs/mosquitto.conf.xml /usr/local/freeswitch/conf/autoload_configs/mosquitto.conf.xml \
    && make \
    && make install \
    && ldconfig

RUN groupadd -r freeswitch --gid=999 \
    && useradd -r -g freeswitch --uid=999 freeswitch


COPY entrypoint.sh /
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
CMD ["freeswitch"]
