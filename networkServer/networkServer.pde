//victoria
//apr 18

import processing.net.*;

Server myserver;

String incoming;

void setup () {
size (600, 600);
textAlign (CENTER, CENTER);
 textSize (50);

incoming="";

myserver= new Server (this, 1234); //same port # as client

}

void draw () {
background (0);
fill (255);
text (incoming, width/2, height/2);

Client myclient= myserver.available(); //which client is trying to interact
//if no message, then myclient is null

if (myclient!=null) {
incoming= myclient.readString();
}

}

void mousePressed() {
myserver.write("BYE"); //send to all connected clients
}
