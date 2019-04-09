FROM jupyter/scipy-notebook
MAINTAINER Sander de Wildt <sanderdw@gmail.com>

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential cmake zlib1g-dev libgmp3-dev libreadline-dev lib32ncurses5-dev bison flex zimpl bliss && apt-get clean
COPY scipoptsuite-6.0.1.tgz /
RUN tar xvf scipoptsuite-6.0.1.tgz
RUN cd scipoptsuite-6.0.1 && cmake /scipoptsuite-6.0.1 -DCMAKE_INSTALL_PREFIX=/home/solver && make install TPI=tny USRLDFLAGS=-lpthread
RUN export SCIPOPTDIR=/home/solver

USER jovyan
RUN pip install --upgrade pip && pip install pyscipopt && pip install pyhdb

WORKDIR /home/jovyan
COPY markshare2.mps /home/jovyan
COPY markshare2.ipynb /home/jovyan
COPY diet.ipynb /home/jovyan