FROM python:3.6.8-stretch
MAINTAINER Sander de Wildt <sanderdw@gmail.com>

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential cmake zlib1g-dev libgmp3-dev libreadline-dev lib32ncurses5-dev bison flex zimpl bliss && apt-get clean
COPY scipoptsuite-6.0.1.tgz /
RUN tar xvf scipoptsuite-6.0.1.tgz
RUN rm scipoptsuite-6.0.1.tgz
RUN cd scipoptsuite-6.0.1 && cmake /scipoptsuite-6.0.1 -DCMAKE_INSTALL_PREFIX=/opt/SCIP && make install TPI=tny USRLDFLAGS=-lpthread && export SCIPOPTDIR=/opt/SCIP
RUN pip install --upgrade pip && pip install pyscipopt && pip install pyhdb && pip install pandas

COPY markshare2.mps /
COPY markshare2.ipynb /
COPY diet.ipynb /
COPY diet.py /

CMD [ "python", "/diet.py" ]