FROM python:3.6.8-stretch
MAINTAINER Sander de Wildt <sanderdw@gmail.com>

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python", "./helloworld.py" ]