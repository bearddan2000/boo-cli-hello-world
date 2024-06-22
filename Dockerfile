FROM ubuntu:18.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y git mono-devel && \
    mkdir -p /opt && \
    cd /opt && \
    git clone https://github.com/boo-lang/boo && \
    cd boo && \
    cp -pf bin/* /usr/local/bin/ && \
    cd /usr/local/bin && \
    for f in booc booi booish; \
    do \
        printf '#!/bin/sh\nenv mono /usr/local/bin/%s.exe "$@"\n' $f >$f && \
        chmod +x $f; \
    done

WORKDIR /code

COPY bin .

CMD "./run.sh"