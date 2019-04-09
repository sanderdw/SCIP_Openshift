FROM continuumio/anaconda3
MAINTAINER Sander de Wildt <sanderdw@gmail.com>


CMD ["jupyter notebook --notebook-dir=/opt/notebooks --ip='0.0.0.0' --port=8888 --no-browser"]