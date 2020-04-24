//victoria
//apr18

import processing.net.*;

Client myclient;

String incoming; //varible that store text
String outgoing;
String valid= "1234567890qwertyuiopasdfghjklzxcvbnm,./;'()?><*&^%$#@!QWERTYUIOPASDFGHJKLZXCVBNM ";

void setup (){
 size (600, 600);
 textAlign (CENTER, CENTER);
 textSize (50);

incoming="";
outgoing= "";

myclient= new Client (this, "127.0.0.1", 1234); //sketch, ip adress-this is own computer, port#


}

void draw () {
background (255);
fill (0);
text (incoming, width/2, height/2);
text (outgoing, width/2, 150);

if (myclient.available()>0) {  //check if there is message
incoming=myclient.readString(); //if so, then this is how to read in message

}
  
 
}

void keyPressed() {
if (key== ENTER){ //how to send message
myclient.write (outgoing);
outgoing="";

}else if (key==BACKSPACE && outgoing.length()>0) {
  outgoing=outgoing.substring (0,outgoing.length()-1);
} else if (valid.contains (""+key)) {
  outgoing= outgoing+key;
  
} 

}
