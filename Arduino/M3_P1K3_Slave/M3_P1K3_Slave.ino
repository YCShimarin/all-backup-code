int led[] = {2,3,4,5,6,7,10,11}; // Pin untuk LED
int i;

void setup() {
  Serial.begin(9600);
  for(i=0; i<6; i++){
    pinMode(led[i], OUTPUT);
  }
}

void loop() {
  if (Serial.available()){
    char message = Serial.read();
    if (message == 'A'){ // Jika semua switch aktif
      for(i=0; i<3; i++){
        digitalWrite(led[i], HIGH); // Mengaktifkan semua LED dari 0-2
      }
    }
    else if (message == 'B'){ // Jika ada 5 switch aktif
      for(i=0; i<8; i++){
        digitalWrite(led[i], HIGH); // Mengaktifkan running LED dari 2-6
        delay(100);
        digitalWrite(led[i], LOW);
      }
    }
    else if (message == 'a'){ // Jika tidak ada switch aktif
      for(i=0; i<6; i++){
        digitalWrite(led[i], LOW);
      }
    }
  }
}
