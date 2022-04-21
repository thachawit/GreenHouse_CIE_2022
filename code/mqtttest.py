import paho.mqtt.client as mqtt
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="yourusername",
  password="yourpassword",
  database="mydatabase"
)

mycursor = mydb.cursor()

def insert_data(message):
    packet = message.splitline
    humidity_val = packet[0]
    temp_val = packet[1]
    sql = "INSERT INTO PLANT_POT (humidity, temperature) VALUES (%s, %s)"
    values = (humidity_val, temp_val)
    mycursor.execute(sql, values)
    mydb.commit()

print(mycursor.rowcount, "record inserted.")

MQTT_ADDRESS = '192.168.0.110'
MQTT_USER = '12345'
MQTT_PASSWORD = '12345'
MQTT_TOPIC = 'home/potplant/humidity'


def on_connect(client, userdata, flags, rc):
    """ The callback for when the client receives a CONNACK response from the server."""
    print('Connected with result code ' + str(rc))
    client.subscribe(MQTT_TOPIC)


def on_message(client, userdata, msg):
    """The callback for when a PUBLISH message is received from the server."""
    print(msg.topic + ' ' + str(msg.payload))
    insert_data(msg.payload)


def main():
    mqtt_client = mqtt.Client()
    mqtt_client.username_pw_set(MQTT_USER, MQTT_PASSWORD)
    mqtt_client.on_connect = on_connect
    mqtt_client.on_message = on_message

    mqtt_client.connect(MQTT_ADDRESS, 1883)
    mqtt_client.loop_forever()


if __name__ == '__main__':
    print('MQTT to InfluxDB bridge')
    main()
