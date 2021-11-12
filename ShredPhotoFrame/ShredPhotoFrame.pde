// Andy Modla Photography 
// Create shredded art photo frames for video/montage simulation from a square photo
// Inspired by the work of artist Banksy
// This code generates frame sequences from a photo.

String name;
String folder;
PImage img;
int x=0;
int y=0;
int shredPercent = 60;
int FRAME_WIDTH = 960;
int FRAME_HEIGHT = 1080;
int WINDOW_WIDTH = 960;
int WINDOW_HEIGHT = 2160-(FRAME_HEIGHT * (100-shredPercent))/100; //2160
int NUM = 40 ;  // number of shred lines across
boolean done = false;
int lineWeight = 32;
int shredWeight = 8;
float theta=0.0;
int counter = 0;
int COUNTER = 360; // circle partitions
int frame = 1;
boolean shred = false;
int state = 0;
//color bgcolor = color(204, 102, 0);
color bgcolor = color(100);

void settings() {
  size(WINDOW_WIDTH, WINDOW_HEIGHT);
}

void setup() {
  frame = 1;
  frameRate(10);
  name = "r2160h_yellowLily_r.jpg";
  //name = "r2160h_yellowLilyanaglyph.jpg";
  println(name);
  img = loadImage(name);
  folder = "videoa";
  smooth();
  strokeWeight(lineWeight);
  background(bgcolor);  //

  if (img.width%2 != 0) {
    println("Images size must be multiple of 2 "+name);
    exit();
  }

  println("Composite width "+ width + " height "+ height);
  state = 1;
}

////////////////////////////////////////////////////////////////////////

void draw() {
  if (done) {
    return;
  }

  switch (state) {
  case 0: // idle
    break;

  case 1: 
    background(bgcolor);  //
    image(img, x, y, FRAME_WIDTH, FRAME_HEIGHT);
    drawFrame();
    saveFrame(folder+"/frame###.jpg");
    state = 2;
    break;

  case 2:
    background(bgcolor);
    y+=8;
    image(img, x, y, FRAME_WIDTH, FRAME_HEIGHT);
    drawFrame();

    // show shred lines
    int spacing = x;
    for (int i = 0; i<img.width/NUM; i++) {
      fill(bgcolor);
      strokeWeight(shredWeight);
      line(spacing, FRAME_HEIGHT, spacing, y+FRAME_HEIGHT-4);
      spacing += img.width/NUM;
    }
    saveFrame(folder+"/frame###.jpg");

    // check end of shredding
    if (y >= ((FRAME_HEIGHT * shredPercent)/100 )) {
    //if (y >= (WINDOW_HEIGHT )) {
      state = 3;
      println("DONE");
    }
    break;
  default:
    break;
  }
}

////////////////////////////////////////////////////////

void keyPressed() {
  //println("key="+key + " keyCode="+keyCode);
  if (keyCode == 'X') { // clear screen
    background(255);
    state = 0;
    x= 0;
    y=0;
  } else if (keyCode == 'S' || keyCode == 's') {  // save screen image
    saveFrame("paint"+frame+".jpg");
    frame++;
  } else if (keyCode == ' ' ) {  // 
    state++;
    shred=true;
  }
}

void drawFrame() {
  strokeWeight(lineWeight);
  noFill();
  rect(0, 0, FRAME_WIDTH, FRAME_HEIGHT);
}
