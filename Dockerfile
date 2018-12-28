FROM arm32v6/alpine:latest
LABEL maintainer="Dan Milon <i@danmilon.me>"
COPY qemu-arm-static /usr/bin

RUN \
  mkdir /build && \
  wget https://github.com/flightaware/dump1090/archive/v3.6.3.tar.gz -O - \
    | tar -xzC /build && \
  apk add \
    --no-cache \
    --repository 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' \
    librtlsdr-dev && \
  apk add \
    --no-cache \
    make \
    gcc \
    musl-dev \
    ncurses-dev \
    ncurses-libs && \
  cd /build/dump1090-3.6.3/ && \
  make BLADERF=no dump1090 view1090 faup1090 && \
  cp dump1090 /usr/bin/dump1090-fa && \
  cp view1090 /usr/bin/view1090-fa && \
  cp faup1090 /usr/bin/ && \
  rm -rf /build && \
  apk del \
    --no-cache \
    --rdepends \
    gcc \
    make \
    libc-dev \
    ncurses-dev

CMD ["/usr/bin/dump1090-fa"]
