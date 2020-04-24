//victoria
//apr 18

import processing.net.*;

Server myserver;

String incoming;
String outgoing;
String valid= "1234567890qwertyuiopasdfghjklzxcvbnm,./;'()?><*&^%$#@!QWERTYUIOPASDFGHJKLZXCVBNM ";

void setup () {
size (600, 600);
textAlign (CENTER, CENTER);
 textSize (50);

incoming="";
outgoing= "";

myserver= new Server (this, 1234); //same port # as client

}

void draw () {
background (0);
fill (255);
text (incoming, width/2, height/2);
text (outgoing, width/2, 150);

Client myclient= myserver.available(); //which client is trying to interact
//if no message, then myclient is null

if (myclient!=null) {
incoming= myclient.readString();
}

}

void keyPressed() {
if (key== ENTER){ //how to send message
myserver.write (outgoing);
outgoing="";

}else if (key==BACKSPACE && outgoing.length()>0) {
  outgoing=outgoing.substring (0,outgoing.length()-1);
} else if (valid.contains (""+key)) {
  outgoing= outgoing+key;
  
} 

}
