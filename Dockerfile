FROM python:3.6.8-stretch
MAINTAINER Sander de Wildt <sanderdw@gmail.com>

WORKDIR /usr/src/app

RUN python3 -m venv /usr/virtual/environment

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["jupyterhub"]