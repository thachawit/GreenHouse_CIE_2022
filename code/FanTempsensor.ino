
#include <DHT.h>

#define DHTPIN 7
#define fan 8

#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  //pinMode(fpin, OUTPUT);
  pinMode(fan, OUTPUT);
}


int thresholdValue = 0;
int celsius = 0;
int fahrenheit = 0;


void fanOn(){
  digitalWrite(fan, HIGH);
}
void fanOff(){
  digitalWrite(fan, LOW);
}


void loop(){
  
  float t = dht.readTemperature();
  
  if( t= '10'){
    fanOn();
  }
  else{
    fanOff();
  }
  Serial.println(t);
  delay(1000);
}
