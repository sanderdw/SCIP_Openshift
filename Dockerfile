FROM python:3.6.8-stretch
MAINTAINER Sander de Wildt <sanderdw@gmail.com>

WORKDIR /usr/src/app

RUN pip install virtualenv
RUN mkdir -p /home/python/.virtualenvs
RUN virtualenv /home/python/.virtualenvs/myproj --python=python3.6
RUN source /home/python/.virtualenvs/myproj/bin/activate

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["jupyterhub"]