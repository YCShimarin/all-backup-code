int sw[] = {2,3,4,5,6,7}; // Pin untuk switch
int i, sw_on;

void setup() {
  Serial.begin(9600);
  for(i=0; i<6; i++){
    pinMode(sw[i], INPUT_PULLUP); // Mengatur semua switch sebagai input pull-up
  }
}

void penjumlahan(){
  sw_on = 0;
  for(i=0; i<6; i++){
    sw_on += digitalRead(sw[i]);
  }
}

void loop() {
  penjumlahan();
  if (sw_on == 6){ // Jika semua switch aktif
    Serial.write('A');
  }
  else if (sw_on == 5){ // Jika ada 5 switch aktif
    Serial.write('B');
  }
  else{
    Serial.write('a');
  }
}
