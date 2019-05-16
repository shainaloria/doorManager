#include <Servo.h>
Servo myservo;  // create servo object to control a servo
int val, val1;    // variable to read the value from the analog pin

void setup() {
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object
  Serial.begin(9600); // Start serial communication at 9600 bps
  pinMode(19, INPUT_PULLUP);     
}

void loop() {
  if (Serial.available()) { // If data is available to read,
    val = Serial.read(); // read it and store it in val
  }
  myservo.write(val);                  // sets the servo position according to the scaled value
  delay(5);                           // waits for the servo to get there

  if (digitalRead(19) == LOW) {  // If switch is ON,
    Serial.write(1);               // send 1 to Processing
    
  } else {                               // If the switch is not ON,
    Serial.write(9);               // send 0 to Processing
  }
  delay(10);
}
