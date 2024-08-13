const int LDR_PIN = A0;  // Koneksikan sensor LDR ke pin analog A0

void setup() {
  Serial.begin(9600);
  Serial.println("Menginisialisasi sensor LDR...");
}

void loop() {
  // Baca nilai analog dari sensor LDR
  int ldrValue = analogRead(LDR_PIN);

  // Konversi nilai analog menjadi lux (opsional, tergantung pada sensor LDR yang digunakan)
  // Anda perlu kalibrasi nilai ini sesuai dengan karakteristik sensor LDR yang Anda miliki.
  // Jika tidak ingin mengkonversi ke lux, Anda dapat langsung menggunakan nilai analog (ldrValue).
  float lux = map(ldrValue, 0, 1023, 0, 1000);  // Misalnya, mengkonversi dari rentang 0-1023 ke rentang 0-1000 lux

  // Tampilkan nilai LDR dan (opsional) lux pada Serial Monitor
  Serial.print("Nilai LDR: ");
  Serial.print(ldrValue);
  Serial.print(", Nilai Lux: ");
  Serial.print(lux);
  Serial.println(" lux");

  // Tambahkan penundaan sesuai kebutuhan Anda
  delay(1000); // Delay 1 detik (opsional)
}
