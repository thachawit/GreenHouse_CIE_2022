import paho.mqtt.client as mqtt
import mysql.connector

# mydb = mysql.connector.connect(
#   host="localhost",
#   user="yourusername",
#   password="yourpassword",
#   database="mydatabase"
# )

# mycursor = mydb.cursor()
# 
# def insert_data(h,p):
#     sql = "INSERT INTO PLANT_POT (humidity, temperature) VALUES (%s, %s)"
#     values = (h, p)
#     mycursor.execute(sql, values)
#     mydb.commit()



MQTT_ADDRESS = '192.168.0.102'
MQTT_USER = 'smartfarm'
MQTT_PASSWORD = '12345'
MQTT_TOPIC = 'humidity/pH/light'


def on_connect(client, userdata, flags, rc):
    """ The callback for when the client receives a CONNACK response from the server."""
    print('Connected with result code ' + str(rc))
    client.subscribe(MQTT_TOPIC)
    


def on_message(client, userdata, msg):
    """The callback for when a PUBLISH message is received from the server."""
    packet = str(msg.payload).split("b")
    humidity = packet[1][1:]
    pH = packet[2][:-1]
    print(msg.topic + ' ' + humidity + ' ' + pH)
   
#     insert_data(float(humidity),float(pH))


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
