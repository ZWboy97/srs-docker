FROM centos:6

RUN yum install -y gcc gcc-c++ make patch sudo
RUN yum install -y unzip perl zlib
RUN yum install -y automake libtool zlib-devel

# For FFMPEG4.1
ADD nasm-2.14.tar.bz2 /tmp
RUN cd /tmp/nasm-2.14 && ./configure && make && make install

ADD yasm-1.2.0.tar.bz2 /tmp
RUN cd /tmp/yasm-1.2.0 && ./configure && make && make install

ADD fdk-aac-0.1.3.tar.bz2 /tmp
RUN cd /tmp/fdk-aac-0.1.3 && bash autogen.sh && ./configure --enable-static && make && make install

ADD lame-3.99.5.tar.bz2 /tmp
RUN cd /tmp/lame-3.99.5 && ./configure --enable-static && make && make install

ADD speex-1.2rc1.tar.bz2 /tmp
RUN cd /tmp/speex-1.2rc1 && ./configure --enable-static && make && make install

ADD x264-snapshot-20181116-2245.tar.bz2 /tmp
RUN cd /tmp/x264-snapshot-20181116-2245 && ./configure --disable-cli --enable-static && make && make install

RUN yum install -y bzip2 bzip2-devel

ENV PKG_CONFIG_PATH $PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
#RUN rm -f /usr/local/lib/*.so*
ADD ffmpeg-4.1.tar.bz2 /tmp
RUN cd /tmp/ffmpeg-4.1 && ./configure --enable-gpl --enable-nonfree \
	--enable-static --disable-shared --enable-postproc --enable-bzlib --enable-zlib \
	--enable-parsers --enable-libx264 --enable-libmp3lame --enable-libfdk-aac \
	--enable-libspeex --enable-pthreads --extra-libs=-lpthread --enable-encoders \
	--enable-decoders --enable-avfilter --enable-muxers --enable-demuxers && make && make install

RUN ln -sf /usr/local/lib/libfdk-aac.so.0 /lib64/ && \
	ln -sf /usr/local/lib/libmp3lame.so.0 /lib64/ && \
	ln -sf /usr/local/lib/libspeex.so.1 /lib64/

# For GIT
RUN yum install -y git
RUN git config --global alias.co checkout && \
	git config --global alias.br branch && \
	git config --global alias.ci commit && \
	git config --global alias.st status && \
	git config --global alias.sm submodule

# Openssl
ADD openssl-1.1.0e.tar.bz2 /tmp
RUN cd /tmp/openssl-1.1.0e && ./config -no-shared no-threads && make && make install_sw

# For ifconfig
RUN yum install -y net-tools

# For GDB
RUN yum install -y gdb

# For Go
ADD go1.13.1.linux-amd64.tar.gz /usr/local
ENV PATH $PATH:/usr/local/go/bin

# For debug
RUN yum install -y lsof tree dstat

# For lsb_release
RUN yum install -y redhat-lsb

