int switch_pin = 7;

int metaSaidabeb1 = 10; // Meta de saída da bebida
int metaSaidabeb2 = 20;

int bebidaPre = [0,1,1,1,1,1,1,0];
int bebidaPos = [1,1,1,1,1,1,1,1,1,1,0];

int maq1TotalPre = bebidadePre; // total de 1 que saiu 
int maq1TotalPos = bebidaPos;

int maq1Geral =  maq1TotalPre + maq1TotalPos;

int metaGeral = metaSaidabeb1 + metaSaidabeb2;

int unidade = (maq1Geral/100) * metaGeral;

void setup() {
  Serial.begin(9600);
  pinMode(switch_pin, INPUT);
}

void loop() {

  if (digitalRead(switch_pin) == LOW) {
    Serial.println(1);
    bebidaPre = (1);
  } else {
    Serial.println(0);
  }
delay(1000);
}
