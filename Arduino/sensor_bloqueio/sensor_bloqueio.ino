int switch_pin = 7;

void setup() {
  Serial.begin(9600);
  pinMode(switch_pin, INPUT);
}

void loop() {

  if (digitalRead(switch_pin) == LOW) {
    Serial.println(1);
  } 


delay(1000);
}
