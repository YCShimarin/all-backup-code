/*********
  Modified from the examples of the Arduino LoRa library
  More resources: https://github.com/cosmic-id/
*********/

#include <SPI.h>
#include <LoRa.h>
#include <WiFi.h>
#include <BlynkSimpleEsp32.h>

//define the pins used by the transceiver module
#define LORA_AURORA_V2_NSS 34
#define LORA_AURORA_V2_RST 45
#define LORA_AURORA_V2_DIO0 26
#define LORA_AURORA_V2_EN 38

#define LORA_TX_POWER 20
#define LORA_SPREADING_FACTOR 12
#define LORA_BANDWIDTH 125E3
#define LORA_CODING_RATE 5
#define LORA_GAIN 0

#define BLYNK_TEMPLATE_ID "YourTemplateID"
#define BLYNK_TEMPLATE_NAME "YourTemplateName"

// Auth Token dari proyek Blynk Anda
char auth[] = "YourAuthToken";
const char* ssid = "nama_wifi";
const char* password = "password_wifi";

byte msgCount = 0;            // count of outgoing messages
int interval = 2000;          // interval between sends
long lastSendTime = 0;        // time of last packet send

void setup() {
  // Initiate the LoRa Enable pin
  pinMode(LORA_AURORA_V2_EN, OUTPUT);
  // LoRa chip is Active High
  digitalWrite(LORA_AURORA_V2_EN, HIGH);

  //initialize Serial Monitor
  Serial.begin(9600);
  while (!Serial);
  Serial.println("LoRa Sender");

  //setup LoRa transceiver module
  LoRa.setPins(LORA_AURORA_V2_NSS, LORA_AURORA_V2_RST, LORA_AURORA_V2_DIO0);
  
  //replace the LoRa.begin(---E-) argument with your location's frequency 
  //433E6 for Asia
  //866E6 for Europe
  //915E6 for North America
  while (!LoRa.begin(915E6)) {
    Serial.println(".");
    delay(500);
  }

  //LoRa Parameter Setting
  LoRa.setTxPower(LORA_TX_POWER, PA_OUTPUT_PA_BOOST_PIN); //TX power in dB, defaults to 17
  LoRa.setSpreadingFactor(LORA_SPREADING_FACTOR); // spreading factor, defaults to 7, 
          //Supported values are between 6 and 12
  LoRa.setSignalBandwidth(LORA_BANDWIDTH); // signal bandwidth in Hz, defaults to 125E3.
          //Supported values are 7.8E3, 10.4E3, 15.6E3, 20.8E3, 31.25E3, 41.7E3, 62.5E3, 125E3, 250E3, and 500E3.
  LoRa.setCodingRate4(LORA_CODING_RATE); //denominator of the coding rate, defaults to 5
          //Supported values are between 5 and 8, these correspond to coding rates of 4/5 and 4/8
  LoRa.setGain(LORA_GAIN);//Low Noise Amplifier(LNA) gain
          //Supported values are between 0 and 6. If gain is 0, AGC will be enabled and LNA gain will not be used. 
          //Else if gain is from 1 to 6, AGC will be disabled and LNA gain will be used

  // Change sync word (0xF3) to match the receiver
  // The sync word assures you don't get LoRa messages from other LoRa transceivers
  // ranges from 0-0xFF
  LoRa.setSyncWord(0xF3);
  Serial.println("LoRa Initializing OK!");

  Blynk.begin(auth, ssid, password);

  // Mencoba untuk terhubung ke jaringan WiFi
  WiFi.begin(ssid, password);

  // Menunggu koneksi WiFi terbentuk
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi..");
  }

  // Jika koneksi berhasil terbentuk
  Serial.println("Connected to WiFi!");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());
}

void loop() {
  if (millis() - lastSendTime > interval) {
    String message = "HeLoRa World! ";   // send a message
    message += msgCount;
    sendMessage(message);
    Serial.println("Sending " + message);
    lastSendTime = millis();            // timestamp the message
    interval = random(2000) + 1000;    // 2-3 seconds
    msgCount++;
  }

  // parse for a packet, and call onReceive with the result:
  onReceive(LoRa.parsePacket());

  // Mengirim nilai RSSI ke Blynk
  int rssi = WiFi.RSSI();
  Blynk.virtualWrite(V0, rssi);
  // Tunggu sebentar sebelum mengambil nilai RSSI kembali
  delay(1000);
  Blynk.run();


}

void sendMessage(String outgoing) {
  LoRa.beginPacket();                   // start packet
  LoRa.print(outgoing);                 // add payload
  LoRa.endPacket();                     // finish packet and send it
  msgCount++;                           // increment message ID
}

void onReceive(int packetSize) {
  if (packetSize == 0) return;          // if there's no packet, return

  // read packet header bytes:
  int recipient = LoRa.read();          // recipient address
  byte sender = LoRa.read();            // sender address
  byte incomingMsgId = LoRa.read();     // incoming msg ID
  byte incomingLength = LoRa.read();    // incoming msg length

  String incoming = "";

  while (LoRa.available()) {
    incoming += (char)LoRa.read();
  
    /*
    // read packet
    while (LoRa.available()) {
      String LoRaData = LoRa.readString();
      Serial.print(LoRaData); 
    }
    */

  }

  if (incomingLength != incoming.length()) {   // check length for error
    Serial.println("error: message length does not match length");
    return;                             // skip rest of function
  }

  // if message is for this device, or broadcast, print details:
  Serial.println("Received from: 0x" + String(sender, HEX));
  Serial.println("Sent to: 0x" + String(recipient, HEX));
  Serial.println("Message ID: " + String(incomingMsgId));
  Serial.println("Message length: " + String(incomingLength));
  Serial.println("Message: " + incoming);
  Serial.println("RSSI: " + String(LoRa.packetRssi()));
  Serial.println("Snr: " + String(LoRa.packetSnr()));
  Serial.println();
}

void LoRa_rxMode(){
  LoRa.disableInvertIQ();               // normal mode
  LoRa.receive();                       // set receive mode
}

void LoRa_txMode(){
  LoRa.idle();                          // set standby mode
  LoRa.enableInvertIQ();                // active invert I and Q signals
}

void onTxDone() {
  Serial.println("TxDone");
  LoRa_rxMode();
}