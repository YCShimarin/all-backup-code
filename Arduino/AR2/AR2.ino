#include <Servo.h>
#include <LiquidCrystal_I2C.h>

// Definisi pin untuk sensor dan aktuator
#define BUTTON1_PIN 9
#define BUTTON2_PIN 8
#define BUZZER_PIN 10
#define MOTOR_IN1_PIN 7
#define MOTOR_IN2_PIN 6
#define MOTOR_EN1_PIN 5
#define SERVO_PIN 4

// Inisialisasi objek Servo
Servo servo;

// Inisialisasi objek LiquidCrystal_I2C dengan alamat 0x27 dan ukuran 16x2
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Variabel untuk menyimpan data sensor
float turbidity, ph;
double temp;
int waterLevel;

// Variabel untuk penjadwalan tampilan LCD
unsigned long previousMillis = 0;
const long interval = 5000; // Interval 5 detik
int displayState = 0;

void setup() {
  // Inisialisasi pin
  pinMode(BUTTON1_PIN, INPUT);
  pinMode(BUTTON2_PIN, INPUT);
  pinMode(BUZZER_PIN, OUTPUT);
  pinMode(MOTOR_IN1_PIN, OUTPUT);
  pinMode(MOTOR_IN2_PIN, OUTPUT);
  pinMode(MOTOR_EN1_PIN, OUTPUT);

  // Inisialisasi komunikasi serial
  Serial.begin(9200);

  // Inisialisasi LCD
  lcd.init();
  lcd.backlight();

  // Inisialisasi motor servo
  servo.attach(SERVO_PIN);
  servo.write(0);
}

void loop() {
  // Baca data dari Arduino pertama
  if (Serial.available()) {
    String data = Serial.readStringUntil('\n');
    sscanf(data.c_str(), "%f,%f,%f,%d", &turbidity, &ph, &temp, &waterLevel);
  }

  // Logika untuk menampilkan data di LCD secara bergantian
  unsigned long currentMillis = millis();
  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;
    displayState = (displayState + 1) % 4;
    lcd.clear();
    switch (displayState) {
      case 0:
        lcd.setCursor(0, 0);
        lcd.print("Suhu=");
        lcd.setCursor(6, 0);
        lcd.print(temp);
        lcd.print(" C");
        break;
      case 1:
        lcd.setCursor(0, 0);
        lcd.print("pH=");
        lcd.setCursor(3, 0);
        lcd.print(ph);
        break;
      case 2:
        lcd.setCursor(0, 0);
        lcd.print("NTU=");
        lcd.setCursor(4, 0);
        lcd.print(turbidity);
        break;
      case 3:
        lcd.setCursor(0, 0);
        lcd.print("WaterLvl=");
        lcd.setCursor(10, 0);
        lcd.print(waterLevel);
        lcd.print(" cm");
        break;
    }
  }

  // Logika untuk memonitoring air
  bool isBuzzerOn = (ph < 6.5 || ph > 8.5) || (turbidity < 2 || turbidity > 2.5);
  if (isBuzzerOn) {
    digitalWrite(BUZZER_PIN, HIGH);
  } else {
    digitalWrite(BUZZER_PIN, LOW);
  }

  // Logika untuk mengontrol pompa air
  if (isBuzzerOn || digitalRead(BUTTON1_PIN) == HIGH) {
    digitalWrite(MOTOR_IN1_PIN, HIGH);
    digitalWrite(MOTOR_IN2_PIN, LOW);
    analogWrite(MOTOR_EN1_PIN, 255);
  } else if (digitalRead(BUTTON2_PIN) == HIGH) {
    digitalWrite(MOTOR_IN1_PIN, LOW);
    digitalWrite(MOTOR_IN2_PIN, HIGH);
    analogWrite(MOTOR_EN1_PIN, 255);
  } else {
    analogWrite(MOTOR_EN1_PIN, 0);
  }

  // Logika untuk mengontrol katup pemisah menggunakan motor servo
  if (digitalRead(BUTTON2_PIN) == HIGH) {
    servo.write(90);
  } else {
    servo.write(0);
  }
}
