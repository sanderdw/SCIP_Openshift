FROM continuumio/anaconda3
MAINTAINER Sander de Wildt <sanderdw@gmail.com>

ENTRYPOINT ["/bin/ping"]
CMD ["localhost"]