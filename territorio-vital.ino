// Reference: http://www.fredrikolofsson.com/f0blog/?q=node/605

byte inputPins[] = { A0, A1, A2, A3, A4, A5, A17, A18, A19, A20, A21, A22 };
byte pulse[] =  {A21,A22,A0,A1};
byte resp[] =  {A19,A20,A2,A3};

byte ledPins[] = {11, 8, 5, 2 };
int Threshold = 550; 

void setup() {
  Serial.begin(115200);
  for (byte i = 0; i < 4; i++) { // input pins
    pinMode(pulse[i], INPUT); // vital signs
    pinMode(ledPins[i], OUTPUT); // visual feedback
  }
}
void loop() {

  Serial.write(244);
  Serial.print(analogRead(pulse[0]));
  Serial.write(245);
  Serial.print(analogRead(pulse[1]));
  Serial.write(246);
  Serial.print(analogRead(pulse[2]));
  Serial.write(247);
  Serial.print(analogRead(pulse[3]));
  Serial.write(248);
  Serial.print(analogRead(resp[2]));
    Serial.write(249);/*
  Serial.print(analogRead(resp[1]));
    Serial.write(250);
    Serial.print(analogRead(resp[2]));
    Serial.write(251);
    Serial.print(analogRead(resp[3]));
    Serial.write(252);
    Serial.print(analogRead(inputPins[8]));
    Serial.write(253);
    Serial.print(analogRead(inputPins[9]));
    Serial.write(254);
    Serial.print(analogRead(inputPins[10]));
    Serial.write(255);
    Serial.print(analogRead(inputPins[11]));
*/
  for (int i = 0; i < 4; ++i) {
    if (analogRead(pulse[i]) > Threshold) {
      digitalWrite(ledPins[i], HIGH);
    } else {
      digitalWrite(ledPins[i], LOW);
      }
  }
  
  delay(2);
}
