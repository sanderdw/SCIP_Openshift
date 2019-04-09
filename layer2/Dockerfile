FROM myproject/scipopenshift:latest

RUN pip install flask && pip install flask_cors && pip install paho-mqtt
COPY api.py /usr/scip

EXPOSE 80
CMD [ "python", "api.py" ]