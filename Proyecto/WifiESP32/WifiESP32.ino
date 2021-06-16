
#include <WiFi.h>
#include <HTTPClient.h>

const char* ssid = "VLADYMIX";
const char* password = "phr202020";

String serverPath = "http://apiservice.vladymix.es/phr/services/robotconfig.txt";

// Define uart comunication

#define tx_1 35
#define rx_1 34



void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
  delay(10);
  
 // Uart salida
 Serial2.begin(9600);
 
  Serial.print("Conectando a: \t");
  Serial.println(ssid);
  
  WiFi.begin(ssid, password);
 
  while(WiFi.status() != WL_CONNECTED){
    delay(300);
    Serial.print('.');
    }

   // Mostrar mensaje de exito y dirección IP asignada
  Serial.println();
  Serial.print("Conectado a:\t");
  Serial.println(WiFi.SSID()); 
  Serial.print("IP address:\t");
  Serial.println(WiFi.localIP());

}

void loop() {
  // put your main code here, to run repeatedly:
  delay(600);

   if(WiFi.status()== WL_CONNECTED){
     Serial.print("connecting to ");
     Serial.println(serverPath);
    
          HTTPClient http;
          http.begin(serverPath.c_str());
          int httpCode = http.GET();
      
           if (httpCode > 0) { //Check for the returning code
              String payload = http.getString();
              Serial.println("Estatus: ");
              Serial.print(payload);
              Serial2.print(payload);
            }
           else {
              Serial.println("Error on HTTP request:");
              Serial.println(httpCode);
           }
       
          http.end(); //Free the resources
      
          Serial.println();
          Serial.println("closing connection");
          
    }
    else{
        Serial.println("NO tienes conexion a internet");
   }
}
