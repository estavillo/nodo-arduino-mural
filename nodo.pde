import processing.serial.*;

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import org.firmata.*;
import cc.arduino.*;

Minim minim;
AudioPlayer muralintro;
AudioPlayer ciudad;
AudioPlayer ninos;
AudioPlayer miedo;
AudioPlayer renacer;
AudioPlayer outro;
Arduino arduino;

 int[] apin = new int [54];
 int Tiempo;
 float volumen; 
 int c1=22;
 int c2=23;
 int c3=25;
 int kids=24;
 int cara=26;
 int jaguar=27;
 int perro=28;
 int mg=29;
 int mcont=30;
 int mcontcolor=43;
 int feto=31;
 int teles=32;
 int semaforo=33;
 int letras=34;
 
 int fetocolor=35; 
 int mcolor=36;

 int r=2;
 int g=3;
 int b=4;
 
 
void setup(){
 size(800, 400);
  background(0);
  frameRate(60);
  minim = new Minim(this);
   muralintro = minim.loadFile("muralBS_intro.wav");
   ciudad = minim.loadFile("ciudad.mp3");
   ninos = minim.loadFile("ninos.mp3");
   miedo = minim.loadFile("miedo.mp3");
   renacer = minim.loadFile("renacer.mp3");
   outro = minim.loadFile("outro.mp3");
  arduino = new Arduino(this, "/dev/cu.usbmodemfd131", 57600);
  //arduinopinsdigitales  
}


void draw(){
  background(0);
  float volumenR = muralintro.right.level()*1000;  
  float volumenL = muralintro.left.level()*1000;
  
  //dibujo
  float colorR = map(volumen,0,200,0,255);
  float colorG = map(volumenL,0,200,0,255);
  float colorB = map(volumenR,0,200,0,255);
  ellipseMode(CENTER);
  fill(colorR,colorG,colorB);
  ellipse(width/2,height/2,4*volumen,4*volumen); 
  //dibujo 

 Tiempo = 0 + int(millis()/1000); 
 if(Tiempo>0 && Tiempo<=108){
intro();
}

if(Tiempo>108 && Tiempo<=230)
{todosOFF();
ciudad();}

if(Tiempo>230 && Tiempo <=295)
{ninos();}

if(Tiempo>295 && Tiempo<=640)
{miedo();}

if(Tiempo>640 && Tiempo<=700)
{renacer();}

if(Tiempo>700 && Tiempo<=860)
{outro();}
if(Tiempo>860)
{todosON(1000);}

}
//metodos
void boton(int a,int b){ //enciende o apaga el pin "a" si b=1 o b=0
if(b == 1)
{arduino.digitalWrite(a,Arduino.HIGH);}

if(b == 0)
{arduino.digitalWrite(a,Arduino.LOW);}

}

void blink (int a, int b,int c){// funcion de parpadeo con al pin "a" con delay b y "c" las veces
for(int i=0;i<=c;i++)
{
arduino.digitalWrite(a,Arduino.HIGH);
delay(b);
arduino.digitalWrite(a,arduino.LOW);
delay(b);}
}


//metodos
void volumenGral(float a){

  for(int i=22;i<36;i++){
  if(a>=70 ){
  boton(i,1);
  }
  else
  {boton(i,0);}
            }
            todosOFF();
}
void volumenGral2(float a,int b){

  for(int i=22;i<36;i++){
  if(a>=b ){
  boton(i,1);
  }
  else
  {boton(i,0);}
            }
}

void multiples(int a, int b, int c)
{for(int i = a ;i<=b;i++){
  boton(apin[i],c);}
}

void todosON(int a){
for(int i=22;i<=35;i++)
{boton(i,1);}
delay(a);
}

void todosOFF(){
for(int i=22;i<=35;i++)
{boton(i,0);}
}

void randomVol(float thd){
  float seed= random(22,36);
  int pin = int(seed);
  if(thd>=70){
    boton(pin,1);
    delay(500);
    boton(pin,0);
  }
  else{boton(pin,0);} 
 todosOFF(); 
}
void ritmo(int pin,float thd,int control){
  if(thd>=control){
    boton(pin,1);
    delay(800);
    boton(pin,0);
  }
  else{boton(pin,0);}  
}

void pulso(int frecuencia){
   for(int i=22;i<=35;i++)
     { boton(i,1);
       delay(frecuencia);
       boton(i,0);}
}

void crgb(int pin,int i,int x,int y, int z){
  boton(pin,i);
  arduino.analogWrite(r,x);
  arduino.analogWrite(g,y);
  arduino.analogWrite(b,z);
}

void rgbshow(int pin,int i) {
  // fade in from min to max in increments of 5 points:
  for (int fadeValue = 0 ; fadeValue <= 255; fadeValue += 5) {
    // sets the value (range from 0 to 255):
    arduino.analogWrite(r, fadeValue);
    // wait for 30 milliseconds to see the dimming effect
    delay(30);
  }
     for (int fadeValue = 255 ; fadeValue >= 0; fadeValue -= 5) {
    // sets the value (range from 0 to 255):
    arduino.analogWrite(b, fadeValue);
    // wait for 30 milliseconds to see the dimming effect
    delay(30);
  }
  
   for (int fadeValue = 0 ; fadeValue <= 255; fadeValue += 5) {
    // sets the value (range from 0 to 255):
    arduino.analogWrite(g, fadeValue);
    // wait for 30 milliseconds to see the dimming effect
    delay(30);
  }

  // fade out from max to min in increments of 5 points:
  for (int fadeValue = 255 ; fadeValue >= 0; fadeValue -= 5) {
    // sets the value (range from 0 to 255):
    arduino.analogWrite(r, fadeValue);
    // wait for 30 milliseconds to see the dimming effect
    delay(30);
  }
   for (int fadeValue = 0 ; fadeValue <= 255; fadeValue += 5) {
    // sets the value (range from 0 to 255):
    arduino.analogWrite(g, fadeValue);
    // wait for 30 milliseconds to see the dimming effect
    delay(30);
  }
   for (int fadeValue = 255 ; fadeValue >= 0; fadeValue -= 5) {
    // sets the value (range from 0 to 255):
    arduino.analogWrite(g, fadeValue);
    // wait for 30 milliseconds to see the dimming effect
    delay(30);
  }

}


void intro(){
   //intro 
  
 volumen = muralintro.mix.level()*1000;
    println(Tiempo);    
  muralintro.play();
  boton(feto,0);
  if(Tiempo<=25){ 
  volumenGral(volumen-60);}
  
  if(Tiempo>25 && Tiempo<=28)
  {todosON(1000);
     pulso(200);
     }
   
  if(Tiempo>28 && Tiempo <= 45)
       {randomVol(volumen-40);
       }  todosOFF();
   if(Tiempo>45 && Tiempo<=69)  
    {volumenGral(volumen-70);
     } todosOFF();
     if(Tiempo>69 && Tiempo <= 90)
       {todosOFF();
       randomVol(volumen-100);
        todosOFF();}
     if(Tiempo>90 && Tiempo<=105)
       {
       volumenGral(volumen-80);
            }
      if(Tiempo>105 && Tiempo<=108)
        {volumenGral(volumen-99);
          todosON(50);
      todosOFF();}
 }
 
void ciudad(){
 volumen = ciudad.mix.level()*1000;
   println(Tiempo); 
  ciudad.play();
  if(Tiempo>110 && Tiempo<=180)
  { 
    boton(c1,1);
    boton(c2,1);
    boton(c3,1);
    delay(400); 
    boton(c1,0);
    boton(c2,0);
    boton(c3,0);
    delay(400);
  }
   if(Tiempo>180 && Tiempo<=205)
  { 
    boton(c1,1);
    boton(c2,1);
    boton(c3,1);
    delay(200); 
    boton(c1,0);
    boton(c2,0);
    boton(c3,0);
    delay(200);
  }
   if(Tiempo>205 && Tiempo<=210)
  { 
    boton(c1,1);
    delay(100);
    boton(c2,1);
    delay(100);
    boton(c3,1);
  }
   if(Tiempo>210 && Tiempo<220)
  { 
    delay(50);
    boton(c1,0);
    boton(c2,0);
    boton(c3,0);
  }

}

void ninos(){
 volumen = ninos.mix.level()*1000;
   println(Tiempo); 
  ninos.play();
  if(Tiempo>230 && Tiempo<=260)
  { boton(kids,1);
    boton(teles,1);
    delay(30); 
    boton(kids,0);
    boton(teles,0);
    delay(30);}
   if(Tiempo>260 && Tiempo<=285)
  {boton(kids,0);
    boton(teles,1);
    delay(50); 
    boton(kids,0);
    boton(teles,0);
    delay(50);}
   if(Tiempo>285 && Tiempo<290)
  {boton(kids,1);
   boton(teles,1);
     delay(7000);
   boton(kids,0);
   boton(teles,0);}
}
void miedo(){
 volumen = miedo.mix.level()*1000;
   println(Tiempo); 
  miedo.play();
  
  if(Tiempo>295 && Tiempo<=308)
  {boton(cara,0);   }
  if(Tiempo>308 && Tiempo<=334)
  {boton(cara,1);   }
   if(Tiempo>334 && Tiempo<=345)
  {boton(cara,1);
   boton(teles,1);}
   if(Tiempo>345 && Tiempo<=360)
  {boton(teles,0);
   delay(5000);
   boton(mcont,1);}
  if(Tiempo>360 && Tiempo<=380)
  {boton(cara,1);
   boton(teles,0);
   boton(mcont,1);
    delay(1500); 
    boton(mcont,0);
    delay(1500);}
   if(Tiempo>380 && Tiempo<=390)
   {boton(cara,1);
  boton(mcont,1);
    delay(50); 
    boton(mcont,0);
    delay(50);} 
   
   if(Tiempo>390 && Tiempo<=393)
    {boton(cara,0);
     boton(mcont,0);
     boton(teles,0); }
    
   if(Tiempo>393 && Tiempo<=412)
     {
      boton(mcont,1);
      delay(100); 
      boton(mcont,0);
      delay(100);  
       }
     if(Tiempo>412 && Tiempo<=440)
     {
      boton(mcont,1);
      boton(mg,1);
      delay(200); 
      boton(mcont,0);
      boton(mg,0);
      delay(200);  
       }
    if(Tiempo>440 && Tiempo<=490)
     {
      boton(mcont,1);
      boton(mg,1);      
      boton(letras,1);
      delay(200); 
      boton(mcont,0);
      boton(mg,0);
      boton(letras,0);
      delay(200);  
       }     
   if(Tiempo>490 && Tiempo<520)
     {ritmo(mg,volumen,20);
      ritmo(jaguar,volumen,25);
      ritmo(perro,volumen,15);}
    if(Tiempo>520 && Tiempo<525)
     {boton(jaguar,1);
      boton(teles,1);
      delay(2000);
      boton(jaguar,0);
      blink(jaguar,100,10);
      boton(teles,0);
       }
       if(Tiempo>525 && Tiempo<550)
     {boton(jaguar,1);
      boton(teles,1);
      delay(2000);
      boton(jaguar,0);
      blink(jaguar,100,10);
      boton(teles,0);
       }
   if(Tiempo>550 && Tiempo<570)
     {ritmo(mg,volumen,10);
      ritmo(jaguar,volumen,10);
      ritmo(perro,volumen,10);
     }
    if(Tiempo>570 && Tiempo<620)
      {ritmo(jaguar,volumen,10);
      ritmo(mg,volumen,15);
      ritmo(teles,volumen,15);
      ritmo(mcont,volumen,15);
      ritmo(perro,volumen,15);
          }  
     if(Tiempo>610 && Tiempo<620)
      {ritmo(jaguar,volumen,10);
      ritmo(mg,volumen,15);
      ritmo(teles,volumen,20);
      ritmo(mcont,volumen,15);
      ritmo(perro,volumen,10);
      ritmo(letras,volumen,40);
          } 
       if(Tiempo>620 && Tiempo<640)
      {boton(perro,1);
      boton(jaguar,1);
      boton(mg,1);
      boton(mcont,1);
      delay(7000);
      boton(perro,0);
      boton(jaguar,0);
      boton(mg,0);
      boton(mcont,0);
          }     
}
void renacer(){
 volumen = renacer.mix.level()*1000;
   println(Tiempo); 
  renacer.play();
  crgb(fetocolor,1,0,0,0);
  if(Tiempo>640 && Tiempo<=655)
      {         
        rgbshow(fetocolor,1);
            }
    if(Tiempo>655 && Tiempo<=685)
      {        
       for(int i=255;i>=0;i--){ 
        crgb(fetocolor,1,0,0,i);
        delay(50);
            }} 
    if(Tiempo>685 && Tiempo<=700)
        {
         
         (fetocolor,0,0,0,0);
          boton(feto,1);
          delay(2000);
          boton(feto,0);
       rgbshow(fetocolor,1); }
}
void outro(){
 volumen = outro.mix.level()*1000;
   println(Tiempo); 
  outro.play();
  if(Tiempo>700 && Tiempo<=726)
  {volumenGral2(volumen,90);}
  if(Tiempo>700 && Tiempo<=750)
  {volumenGral2(volumen,120);}
  if(Tiempo>750 && Tiempo<=830)
  {volumenGral2(volumen,180);}

 }
