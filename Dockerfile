FROM ubuntu:latest

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
    build-essential flex bison && \
  rm -rf /var/lib/apk/lists/*

COPY ./ /app/

WORKDIR /app/

RUN make compiler

