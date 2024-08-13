#include "CTBot.h"
CTBot Lumine; 
String ssid   = "Asrama_Biru_LT_7";
String pass   = "kacak123";
String token  = "5730340526:AAFKd9VJcN3QswOv34Bqnw1lb9MdlG5PfBM";
uint8_t led   = BUILTIN_LED;

void setup() {
  Serial.begin(115200);
  Lumine.wifiConnect(ssid, pass);
  Lumine.setTelegramToken(token);
  pinMode(led, OUTPUT);
  digitalWrite(led, HIGH);
}

void loop() {
  TBMessage pesan;
  if (Lumine.getNewMessage(pesan)) {

   if (pesan.text.equalsIgnoreCase("LIGHT ON")) {              // if the received message is "LIGHT ON"...
   digitalWrite(led, LOW);                               // turn on the LED (inverted logic!)
   Lumine.sendMessage(pesan.sender.id, "Light is now ON");  // notify the sender
  }
    else if (pesan.text.equalsIgnoreCase("LIGHT OFF")) {        // if the received message is "LIGHT OFF"...
    digitalWrite(led, HIGH);                              // turn off the led (inverted logic!)
    Lumine.sendMessage(pesan.sender.id, "Light is now OFF"); // notify the sender
  }
  else {                                                    // otherwise...
   // generate the message for the sender
   String reply;
   reply = (String)"Welcome " + pesan.sender.username + (String)". Try LIGHT ON or LIGHT OFF.";
   Lumine.sendMessage(pesan.sender.id, reply);             // and send it
  }
 }
 // wait 500 milliseconds
 delay(500);
}
