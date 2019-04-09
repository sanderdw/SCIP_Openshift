FROM python:3.6.8-stretch
MAINTAINER Sander de Wildt <sanderdw@gmail.com>

RUN pip3 install jupyter

CMD ["jupyter notebook"]