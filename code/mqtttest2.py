import paho.mqtt.client as mqtt
import mysql.connector

mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="raspberrypi!",
  database="smart_greenhouse"
)

mycursor = mydb.cursor()

def insert_data(sensor_data,topic):
    data_list = sensor_data;
    if(topic == 'humidity/temperature'):
        sql = "INSERT INTO ambient (humidity_level, temperature) VALUES (%s, %s)"
        values = (float(data_list[0]), float(data_list[1]))
        mycursor.execute(sql, values)
        mydb.commit()
        
    if(topic == 'soil/moisture'):
        sql = "INSERT INTO soil_info (moisture_level) VALUES (%s)"
        values = float(datalist[0]) 
        mycursor.execute(sql, values)
        mydb.commit()
        
def to_esp(client):
    sql = "SELECT status FROM SUNSHADE WHERE ID = (SELECT MAX(ID) FROM SUNSHADE)"
    result = mycursor.execute(sql)
    if(result=="0"): 
        client.publish("esp8266/sunshade",result)
        close_roof = "INSERT INTO SUNSHADE (status) VALUES (False)"
        mycursor.execute(close_roof)
        mydb.commit()



MQTT_ADDRESS = '192.168.0.115'
MQTT_USER = 'smartfarm'
MQTT_PASSWORD = '12345'
MQTT_TOPIC = [('humidity/temperature',1),('soil/moisture',1) ]


def on_connect(client, userdata, flags, rc):
    """ The callback for when the client receives a CONNACK response from the server."""
    print('Connected with result code ' + str(rc))
    client.subscribe(MQTT_TOPIC)
    


def on_message(client, userdata, msg):
    """The callback for when a PUBLISH message is received from the server."""
    packet = str(msg.payload).split("b")
    topic = msg.topic
    if(topic =='humidity/temperature'):
        humidity = packet[1][1:]
        temp = packet[2][:-1]
        print(topic + ' ' + humidity + ' ' + temp)
        data_list = [humidity, temp]
        insert_data(data_list,topic)
        client.publish("esp8266/sunshade","1")
        

    if(topic =='soil/moisture'):
        moisture = packet[1][1:]
        #temp = packet[2][:-1]
        data_list = [moisture]
        print(topic + ' ' + moisture)
        insert_data(data_list,topic)
    


def main():
    mqtt_client = mqtt.Client()
    mqtt_client.username_pw_set(MQTT_USER, MQTT_PASSWORD)
    mqtt_client.on_connect = on_connect
    mqtt_client.on_message = on_message
    mqtt_client.to_esp = to_esp
    mqtt_client.connect(MQTT_ADDRESS, 1883)
    mqtt_client.loop_forever()


if __name__ == '__main__':
    print('MQTT to InfluxDB bridge')
    main()

