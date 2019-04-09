FROM python:3.6.8-stretch
MAINTAINER Sander de Wildt <sanderdw@gmail.com>

RUN pip install --upgrade pip && pip install jupyter

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libblas3 libgmp10 libgsl2 liblapack3 && apt-get clean
COPY SCIPOptSuite-6.0.1-Linux.deb /
RUN dpkg -i SCIPOptSuite-6.0.1-Linux.deb

RUN pip install pyscipopt && pip install pyhdb

WORKDIR /usr/scip
COPY markshare2.mps /usr/scip
COPY markshare2.ipynb /usr/scip
COPY diet.ipynb /usr/scip
COPY diet.py /usr/scip

CMD [ "python", "jupyter notebook" ]