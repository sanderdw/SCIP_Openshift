FROM python:3.6.8-stretch
MAINTAINER Sander de Wildt <sanderdw@gmail.com>

ARG user=solver
ARG group=solver
ARG uid=1000
ARG gid=1000

RUN addgroup -g ${gid} ${group} && adduser -h /home/solver -u ${uid} -G ${group} -s /bin/bash -D ${user}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential cmake zlib1g-dev libgmp3-dev libreadline-dev lib32ncurses5-dev bison flex zimpl bliss && apt-get clean

COPY scripts/docker-entrypoint.sh /opt/solver/bin
COPY scipoptsuite-6.0.1.tgz /home/solver/
COPY markshare2.mps /home/solver/
COPY markshare2.ipynb /home/solver/
COPY diet.ipynb /home/solver/

WORKDIR /home/solver/

RUN tar xvf scipoptsuite-6.0.1.tgz
RUN cd scipoptsuite-6.0.1 && cmake /scipoptsuite-6.0.1 -DCMAKE_INSTALL_PREFIX=/opt/solver && make install TPI=tny USRLDFLAGS=-lpthread
RUN export SCIPOPTDIR=/opt/solver && pip install --upgrade pip && pip install pyscipopt && pip install pyhdb && pip install jupyterhub


RUN chown -R solver /opt/solver && \
    chmod 755 /opt/solver/bin/docker-entrypoint.sh

EXPOSE 8888
USER solver

ENTRYPOINT ["docker-entrypoint.sh"]