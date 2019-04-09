import flask
from flask import request, jsonify
from flask_cors import CORS
import paho.mqtt.client as mqtt

nextviewiot = {
'Asset_Name__c':'Nextview Pump',
'Photo_No_Visual_Issue__c':'https://sanwil.net/nextviewiot/no-visual-issue.jpg',
'Photo_Visual_Oil_Issue__c':'https://sanwil.net/nextviewiot/visual-oil-issue.jpg',
'Temperature__c': '',
'Water_Distance__c': ''
}

# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))

    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    #client.subscribe("hue/get/temperature")
    client.subscribe([("test_topic_1", 0), ("test_topic_2", 0)])

# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, msg):
    topic = msg.topic
    message = str(msg.payload, "utf-8")
    if topic == 'test_topic_1':
      nextviewiot.update({'Temperature__c': message})
    elif topic == 'test_topic_2':
      nextviewiot.update({'Water_Distance__c': message})

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message
client.username_pw_set(username="mqtt",password="yQLAKbG0pQ2h62DOCzYb")
client.connect("192.168.100.10", 1883, 60)

# Blocking call that processes network traffic, dispatches callbacks and
# handles reconnecting.
# Other loop*() functions are available that give a threaded interface and a
# manual interface.
client.loop_start()


app = flask.Flask(__name__)
CORS(app)
app.config["DEBUG"] = True

# Create some test data for our catalog in the form of a list of dictionaries.


@app.route('/', methods=['GET'])
def home():
    return '''<h1>nextviewiot</h1>
<p>A nextviewiot API by Sander de Wildt.</p>'''


# A route to return all of the available entries in our catalog.
@app.route('/api/v1/resources/nextviewiot', methods=['GET'])
def api_all():
    return jsonify(nextviewiot)

app.run()