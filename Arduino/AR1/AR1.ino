
// Definisi pin untuk sensor dan aktuator
#define TURBIDITY_PIN A0  // Pin untuk sensor kekeruhan
#define PH_PIN A1         // Pin untuk sensor pH
#define TEMP_PIN A2       // Pin untuk sensor suhu
#define ULTRASONIC_TRIG_PIN 7  // Pin trig untuk sensor ultrasonik
#define ULTRASONIC_ECHO_PIN 6  // Pin echo untuk sensor ultrasonik
#define RAIN_SENSOR_PIN 5      // Pin untuk sensor hujan
#define MOTOR_IN1_PIN 4        // Pin IN1 pada motor driver
#define MOTOR_IN2_PIN 3        // Pin IN2 pada motor driver
#define MOTOR_EN1_PIN 2        // Pin EN1 pada motor driver

// Variabel untuk menyimpan data sensor
float turbidity, ph;
double temp;
int waterLevel;

void setup() {
  // Inisialisasi pin
  pinMode(TURBIDITY_PIN, INPUT);
  pinMode(PH_PIN, INPUT);
  pinMode(TEMP_PIN, INPUT);
  pinMode(RAIN_SENSOR_PIN, INPUT);
  pinMode(MOTOR_IN1_PIN, OUTPUT);
  pinMode(MOTOR_IN2_PIN, OUTPUT);
  pinMode(MOTOR_EN1_PIN, OUTPUT);

  // Inisialisasi pin untuk sensor ultrasonik
  pinMode(ULTRASONIC_TRIG_PIN, OUTPUT);
  pinMode(ULTRASONIC_ECHO_PIN, INPUT);

  // Inisialisasi komunikasi serial
  Serial.begin(9600);

}

void loop() {
  // Baca data dari sensor
  turbidity = analogRead(TURBIDITY_PIN) * (5.0 / 1023.0);
  ph = analogRead(PH_PIN) * (5.0 / 1023.0);
  temp = analogRead(TEMP_PIN) * (5.0 / 1023.0);

  // Mengukur jarak dengan sensor ultrasonik
  digitalWrite(ULTRASONIC_TRIG_PIN, LOW);
  delayMicroseconds(2);
  digitalWrite(ULTRASONIC_TRIG_PIN, HIGH);
  delayMicroseconds(10);
  digitalWrite(ULTRASONIC_TRIG_PIN, LOW);
  waterLevel = pulseIn(ULTRASONIC_ECHO_PIN, HIGH) * 0.034 / 2;

  // Kirim data ke Arduino kedua
  Serial.print(turbidity);
  Serial.print(",");
  Serial.print(ph);
  Serial.print(",");
  Serial.print(temp);
  Serial.print(",");
  Serial.println(waterLevel);

  // Baca data dari rain sensor
  bool isRaining = digitalRead(RAIN_SENSOR_PIN);

  // Logika untuk mengontrol motor
  if (isRaining == true && waterLevel < 14) {
    digitalWrite(MOTOR_IN1_PIN, HIGH);
    digitalWrite(MOTOR_IN2_PIN, LOW);
    analogWrite(MOTOR_EN1_PIN, 255);
  } else if (!isRaining == false || waterLevel >= 14) {
    digitalWrite(MOTOR_IN1_PIN, LOW);
    digitalWrite(MOTOR_IN2_PIN, HIGH);
    analogWrite(MOTOR_EN1_PIN, 255);
  }

  delay(1000);
}
