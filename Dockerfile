FROM python:3.6.8-stretch
MAINTAINER Sander de Wildt <sanderdw@gmail.com>

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential cmake zlib1g-dev libgmp3-dev libreadline-dev lib32ncurses5-dev bison flex zimpl bliss && apt-get clean
COPY scipoptsuite-6.0.1.tgz /
RUN tar xvf scipoptsuite-6.0.1.tgz
RUN cd scipoptsuite-6.0.1 && cmake /scipoptsuite-6.0.1 -DCMAKE_INSTALL_PREFIX=/home/SCIP && make install TPI=tny USRLDFLAGS=-lpthread
RUN export SCIPOPTDIR=/home/SCIP && pip install --upgrade pip && pip install jupyter && pip install pyscipopt && pip install pyhdb && pip install pandas

WORKDIR /usr/scip
COPY markshare2.mps /usr/scip
COPY markshare2.ipynb /usr/scip
COPY diet.ipynb /usr/scip
COPY diet.py /usr/scip

CMD [ "python", "diet.py" ]