//victoria
//apr18

import processing.net.*;

Client myclient;

String incoming; //varible that store text

void setup (){
 size (600, 600);
 textAlign (CENTER, CENTER);
 textSize (50);

incoming="";

myclient= new Client (this, "127.0.0.1", 1234); //sketch, ip adress-this is own computer, port#


}

void draw () {
background (255);
fill (0);
text (incoming, width/2, height/2);

if (myclient.available()>0) {  //check if there is message
incoming=myclient.readString(); //if so, then this is how to read in message

}
  
 
}

void mousePressed() {
myclient.write("HELLO"); //how to send message
}
