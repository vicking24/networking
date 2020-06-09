//victoria
//may 15


import processing.net.*;

Server myserver;

PImage wrook, whorse, wbishop, wqueen, wking, wpawn;
PImage brook, bhorse, bbishop, bqueen, bking, bpawn;
boolean firstclick;
int row1, col1, row2, col2;//first/second click
int gs=75; //gridsize
boolean turn=true;
int timer=60;
int countdown=60;

char grid[][]={
  {'R', 'H', 'B', 'Q', 'K', 'B', 'H', 'R'}, 
  {'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'}, 
  {'r', 'h', 'b', 'q', 'k', 'b', 'h', 'r'}

};

void setup () {
  size (600, 700);
  textAlign (CENTER, CENTER);

  myserver= new Server (this, 1234);

  firstclick=true;

  brook = loadImage("blackRook.png");
  bbishop = loadImage("blackBishop.png");
  bhorse = loadImage("blackKnight.png");
  bqueen = loadImage("blackQueen.png");
  bking = loadImage("blackKing.png");
  bpawn = loadImage("blackPawn.png");

  wrook = loadImage("whiteRook.png");
  wbishop = loadImage("whiteBishop.png");
  whorse = loadImage("whiteKnight.png");
  wqueen = loadImage("whiteQueen.png");
  wking = loadImage("whiteKing.png");
  wpawn = loadImage("whitePawn.png");
}

void draw() {
  background (255);
  drawboard();

  drawpieces();

  receive();
  
  if (turn){
  fill (0, 255, 0);
  countdown--;
  }else {
  fill (255, 0, 0);
  }
  
  rect (20, 620, 150, 50);
  fill (0);
  textSize (25);
  text ("Your Turn", 95, 643);
  
  textSize(30);
  text (timer, 200, 643);
  
  if (countdown<0) {
    timer--;
  countdown=60;
  }
  
  if (timer==0) {
  turn=false;
  timer=60;
  myserver.write ("t");
  }
}


void drawboard() {
  for (int r=0; r<8; r++) {
    for (int c=0; c<8; c++) {
      if ((r%2)==(c%2)) { //% divides the number and calculate the remainder
        fill (#865507); //dark brown
      } else {
        fill (#E8B25B); //light brown
      }
      rect (r*gs, c*gs, gs, gs);
    }
  }

  //int x=0;
  //int y=0;

  //while (y<8) {
  //  if ((x%2)==(y%2)) { //% divides the number and calculate the remainder
  //    fill (#865507); //dark brown
  //  } else {
  //    fill (#E8B25B); //light brown
  //  }

  //  rect (x*gs, y*gs, gs, gs);
  //  x++;

  //  if (x==8) {
  //    x=0;
  //    y++;
  //  }
  //}
}

void drawpieces() {
  for (int r=0; r<8; r++) {
    for (int c=0; c<8; c++) {
      if (grid[r][c]=='r') image (wrook, c*gs, r*gs, gs, gs);
      if (grid[r][c]=='h') image (whorse, c*gs, r*gs, gs, gs);
      if (grid[r][c]=='b') image (wbishop, c*gs, r*gs, gs, gs);
      if (grid[r][c]=='q') image (wqueen, c*gs, r*gs, gs, gs);
      if (grid[r][c]=='k') image (wking, c*gs, r*gs, gs, gs);
      if (grid[r][c]=='p') image (wpawn, c*gs, r*gs, gs, gs);
      if (grid[r][c]=='R') image (brook, c*gs, r*gs, gs, gs);
      if (grid[r][c]=='H') image (bhorse, c*gs, r*gs, gs, gs);
      if (grid[r][c]=='B') image (bbishop, c*gs, r*gs, gs, gs);
      if (grid[r][c]=='Q') image (bqueen, c*gs, r*gs, gs, gs);
      if (grid[r][c]=='K') image (bking, c*gs, r*gs, gs, gs);
      if (grid[r][c]=='P') image (bpawn, c*gs, r*gs, gs, gs);
    }
  }
}



void receive() {

  Client myclient= myserver.available();
  if (myclient!=null) {
    String incoming= myclient.readString();
    
    if (incoming.equals("t")) {
    turn=true;
    }else {
    int r1= int(incoming.substring (0, 1));
    int c1= int (incoming.substring (2, 3));
    int r2= int(incoming.substring (4, 5));
    int c2= int (incoming.substring (6, 7));
    grid[r2][c2]=grid [r1][c1];
    grid[r1][c1]=' ';
    turn=true;
    
    }
  }
}


void mousePressed() {
  if (firstclick&&turn) {
    row1=mouseY/gs;
    col1= mouseX/gs;
    firstclick=false;
  } else if (!firstclick && turn) {
    row2= mouseY/gs;
    col2=mouseX/gs;
    if (!(row2==row1 && col2==col1)) {
      grid[row2][col2]= grid[row1][col1];
      grid[row1][col1]=' ';
      myserver.write (row1+","+ col1+","+ row2+ ","+ col2);
      firstclick=true;
      turn=false;
      countdown=60;
      timer=60;
    }
  }
}
