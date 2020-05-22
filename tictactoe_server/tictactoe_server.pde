//victoria
//apr 30

//* is need in all servers

import processing.net.*; //*

boolean turn=true;

Server myserver;//*

int [][] grid;

void setup () {
  size (600, 600);

  grid= new int [3][3]; //row and then column
  textAlign (CENTER, CENTER);

  strokeWeight (10);

  myserver= new Server (this, 1234);//*
}

void draw () {
  if (turn) {
    background (0, 255, 0);
  } else {
    background (255, 0, 0);
  }


  line (200, 0, 200, 600);
  line (400, 0, 400, 600);
  line (0, 200, 600, 200);
  line (0, 400, 600, 400);

  //int col=0;
  //int row=0;

  //while (row<3) {

  //  drawXO (row, col);
  //  col++;

  //  if (col==3) {
  //    row++;
  //    col=0;
  //  }
  //}

  for (int row=0; row<3; row++){  //for loops auto insert the row++ at the end
   for (int col=0; col<3; col++) {
     drawXO (row, col);
  }
  }

  Client myclient= myserver.available(); //* 
  if (myclient!=null) { //*
    String incoming= myclient.readString(); //*
    int r= int(incoming.substring (0, 1)); //*
    int c= int (incoming.substring (2, 3)); //*
    grid[r][c]=1; //*
    turn=true;
  } //*
}

void drawXO (int row, int col) {
  pushMatrix ();
  translate (row*200, col*200);

  if (grid [row][col]==1) {
    noFill();
    stroke (0);
    ellipse (100, 100, 160, 160); //draw O
  } else if (grid [row][col]==2) {
    line (20, 20, 180, 180); //draw X
    line (180, 20, 20, 180);
  }

  popMatrix();
}

void mouseReleased() {

  int row=mouseX/200;
  int col= mouseY/200;

  if (turn && grid[row][col]==0) {
    grid [row][col]=2;
    myserver.write (row+","+ col); //*
    turn=false;
  }
}
