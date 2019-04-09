FROM python:3.6.8-stretch
MAINTAINER Sander de Wildt <sanderdw@gmail.com>

WORKDIR /usr/src/app

RUN pip install virtualenv
RUN mkvirtualenv myenv --python=python3.6
RUN workon myenv

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["jupyterhub"]