#include "HX711.h"

// Define the pins for HX711 (DT and SCK)
#define DOUT_PIN 2
#define SCK_PIN 3
#define CALIBRATION_VALUE 3605930

// Create an instance of the HX711 library
HX711 scale;

void setup() {
  Serial.begin(9600);
  Serial.println("HX711 Demo");

  // Initialize the scale
  scale.begin(DOUT_PIN, SCK_PIN);
}

void loop() {
  // Read the raw value from the load cell
  long rawValue = scale.read();

  // Print the raw value to the serial monitor
  Serial.print("Raw Value: ");
  Serial.println(rawValue);

  // Convert the raw value to weight in kilograms using get_units()
  float weight = (scale.get_units(10)/CALIBRATION_VALUE)*100; // You can adjust the argument as needed
  
  // Print the weight to the serial monitor
  Serial.print("Weight: ");
  Serial.print(weight);
  Serial.println(" Kg");

  delay(1000); // Wait for 1 second before the next reading
}
