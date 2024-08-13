// Definisikan pin yang digunakan untuk menghubungkan sensor HC-SR04
const int trigPin = 9;  // Pin trigger
const int echoPin = 10; // Pin echo

// Variabel untuk menyimpan waktu tiba dan waktu berangkat sinyal ultrasonik
long duration;
int distance;

void setup() {
  // Atur pin trigPin sebagai OUTPUT dan echoPin sebagai INPUT
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);
  
  // Inisialisasi komunikasi serial
  Serial.begin(9600);
}

void loop() {
  // Kirimkan sinyal ultrasonik
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  
  // Baca waktu berangkat dan waktu tiba sinyal ultrasonik
  duration = pulseIn(echoPin, HIGH);
  
  // Hitung jarak berdasarkan waktu tiba dan waktu berangkat
  // Rumus: Jarak (cm) = (Waktu (microdetik) * Kecepatan Suara (cm/microdetik)) / 2
  distance = duration * 0.034 / 2;
  
  // Tampilkan hasil ke layar Serial Monitor
  Serial.print("Jarak: ");
  Serial.print(distance);
  Serial.println(" cm");
  
  // Tunggu sejenak sebelum membaca lagi
  delay(1000);
}
