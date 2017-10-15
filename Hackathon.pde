float origin=0;
ArrayList planet1;
ArrayList planet2;
ArrayList line;
ArrayList blackhole;

int earthX = 550;
int earthY = 1450;
PImage earth;
PImage earthmini;


PImage bgpic;

PImage blackhole1;
PImage blackhole2;
PImage blackhole3;
PImage blackhole4;
PImage blackhole5;


int mode = 0;
int sence = 1;
int time=0;

float angle=0;

float planet1r = 135;
float planet1g = 206;
float planet1b = 250;

float planet2r = 250;
float planet2g = 128;
float planet2b = 0114;

boolean clickchoosepage = false;
PImage id0;
PImage id1;
PImage id2;
float clickplanet = 0;

import arb.soundcipher.*;
SoundCipher sc1 = new SoundCipher(this);
SoundCipher sc2 = new SoundCipher(this);
SoundCipher sc3 = new SoundCipher(this);
SoundCipher sc4 = new SoundCipher(this);
SoundCipher sc5 = new SoundCipher(this);

 
void setup() {
  size(1100, 800);
  planet1 = new ArrayList();
  planet2 = new ArrayList();
  line = new ArrayList();
  blackhole = new ArrayList();

  smooth();
  earth = loadImage("earth.png");
  earthmini=loadImage("3.png");  
  bgpic=loadImage("bgpic.jpg");
  
  
  
  blackhole1 = loadImage("blackhole1.png");
  blackhole2 = loadImage("blackhole2.png");
  blackhole3 = loadImage("blackhole3.png");
  blackhole4 = loadImage("blackhole4.png");
  blackhole5 = loadImage("blackhole5.png");
  sc1.instrument(0);
  sc2.instrument(11);
  sc3.instrument(8);
  sc4.instrument(13);
  sc5.instrument(115);
  textAlign(CENTER);
  
  id0 = loadImage("id0.png");
  id1 = loadImage("id1.png");
  id2 = loadImage("id2.png");
  
  // GUI setup
  fill(0);  
  //font = createFont("Arial", 18);
  scale_factor = height/table_size;
  
  // finally we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods in this class (see below)
  tuioClient  = new TuioProcessing(this);
}
 
 
void draw() {
  background(0);
  noStroke();  
  fill(0);
  rectMode(CENTER);
  rect(550,400,1100,800);
  
  rectMode(CORNER);
 
  
  
  image(bgpic,-750,0,1920,1000);
  fill(255,30);
  rect(0,0,1100,800);
  
  fill(10,10,100);
  ellipse(earthX,earthY,1650,1650);
    
  //toooooooo ugly
  image(earth,-260,600,1620,1620);
 
  menu();
  drawPlanet();
  drawHoiLine();
  check();
  eat();
  deleteBh();
  deleteAll();
  bounce();
  delete();
  textSize(15);
  fill(255,100);
  text("Press D to delete Blackholes  Press A to remove all the items",550,25);
  
  if(clickchoosepage == true){
    choosepage();
  }
  tuio();
  

}
 
void menu( ) {
  
    origin += 0.1;
  fill(50,165,200,120);
  noStroke();
  rect(430,30,590,110,10);
  
  fill(100,0,0);
  
  
  //planet1pic
  fill(planet1r, planet1g, planet1b,100);
 // ellipse(520,85,80,80);
  //g1
   pushMatrix();
  noStroke();
 // fill(50,150,200,100);
  translate(520, 85);
  scale(0.2);
  rotate(radians(origin));
  for (int q = 0; q < 360; q+=15) {
    rotate(radians(q));
    beginShape();
    for (int i = -90; i <= 90; i+=3) {
      float angle = cos(radians(90+i))*30;
      float x = sin(radians(i*3+origin*2))*(angle);
      float y = i*3;
      vertex(x, y);
    }
    endShape();
  }
  popMatrix();
  
  
  
  
  
 //planet2pic
  fill(planet2r, planet2g, planet2b,150);
  //ellipse(640,85,80,80);
  pushMatrix();
  translate(640,85); 
  scale(0.3);
  rotate(radians(frameCount/220));
  for (int i = 0; i < 360; i+=15) {
    
    
    float x = cos(radians(i))*100;
    float y = sin(radians(i))*100;
    
  
    pushMatrix();
    
    translate(x, y);
    

    rotate(origin/10);
    rect(0, 0, x, y,10);
    
   
    popMatrix();
  }
  
  popMatrix();
  
  
  
  
  
  
  
  image(blackhole4,710,40,85,85);
  noFill();
  stroke(255);
  strokeWeight(4);
  line(830,45,830,122);
  stroke(255);
  line(880,85,970,85);
  

  if (mouseX > 480 && mouseX < 560 && mouseY > 45 && mouseY < 126){ 
    //p1
    rect(470,35,100,100,10);
  } else if (mouseX > 600 && mouseX < 680 && mouseY > 45 && mouseY < 126){
    //p2
  rect(590,35,100,100,10);
  } else if (mouseX > 710 && mouseX < 795 && mouseY > 45 && mouseY < 126){
    //bh
  rect(705,35,100,100,10);
  }  else if (mouseX > 867 && mouseX < 983 && mouseY > 63 && mouseY < 108){
    //line
  rect(860,35,130,100,10);
  }

  if (mode == 1){
  rect(470,35,100,100,10);
  } else if (mode == 2){
 rect(590,35,100,100,10);

  } else if (mode == 6){
  rect(705,35,100,100,10);
  } else if (mode == 8){
  rect(860,35,130,100,10);
  }


  }
 
void drawPlanet(){
  for (int i=planet1.size()-1; i>=0; i--) {
      Planet1 p1 = (Planet1) planet1.get(i);
      p1.run();
      p1.display();
      p1.bounce();
      p1.distance(p1.x, p1.y, earthX, earthY);
    }
  
    for (int i=planet2.size()-1; i>=0; i--) {
    Planet2 p2 = (Planet2) planet2.get(i);
    p2.run();
    p2.display();
    p2.bounce();
    p2.distance(p2.x, p2.y, earthX, earthY);
  }

    
    for (int i=blackhole.size()-1; i>=0; i--) {
      Blackhole bh = (Blackhole) blackhole.get(i);
      bh.here();
    }
}


void drawHoiLine(){

for (int i=line.size()-1; i>=0; i--) {
      Line l = (Line) line.get(i);
      l.make();
    }   
}


void check(){
  
  for (int i=line.size()-1; i>=0; i--) {
    Line l = (Line) line.get(i);
  for(int j=planet1.size()-1; j>=0; j--){
    Planet1 p1 = (Planet1) planet1.get(j);
  if ( p1.y - 35 <= l.lineY && p1.ydir==-1 && p1.x < l.lineX+50 && p1.x > l.lineX-50){
    p1.ydir *= -1;
    }
  }
 }
 //oooooo
   for (int i=line.size()-1; i>=0; i--) {
    Line l = (Line) line.get(i);
  for(int j=planet2.size()-1; j>=0; j--){
    Planet2 p2 = (Planet2) planet2.get(j);
  if ( p2.y - 55 <= l.lineY && p2.ydir==-1 && p2.x < l.lineX+50 && p2.x > l.lineX-50){
    p2.ydir *= -1;
    }
  }
 }


}




void eat(){
 
for (int i=blackhole.size()-1; i>=0; i--) {
    Blackhole bh = (Blackhole) blackhole.get(i);
  for(int j=planet1.size()-1; j>=0; j--){
    Planet1 p1 = (Planet1) planet1.get(j);
  if (dist(p1.x, p1.y, bh.holeX, bh.holeY) <= 90 ){
    planet1.remove(j);
    }
  }
 }
 
 
for (int i=blackhole.size()-1; i>=0; i--) {
    Blackhole bh = (Blackhole) blackhole.get(i);
  for(int j=planet2.size()-1; j>=0; j--){
    Planet2 p2 = (Planet2) planet2.get(j);
  if (dist(p2.x, p2.y, bh.holeX, bh.holeY) <= 90 ){
    planet2.remove(j);
    }
  }
 }
 
 
  for (int i=blackhole.size()-1; i>=0; i--) {
    Blackhole bh = (Blackhole) blackhole.get(i);
  for(int j=line.size()-1; j>=0; j--){
    Line l = (Line) line.get(j);
  if (dist(l.lineX, l.lineY, bh.holeX, bh.holeY) <= 90 ){
    line.remove(j);
    }
  }
 }
 
}

void delete(){

  for(int i=planet1.size()-1; i>=0; i--){
    Planet1 p1 = (Planet1) planet1.get(i);
  if ( p1.y + 35 <0 || p1.x + 35 <0 || p1.y - 35 > height || p1.x - 35 > width){
    planet1.remove(i);
    }
  }
  
  for(int i=planet2.size()-1; i>=0; i--){
    Planet2 p2 = (Planet2) planet2.get(i);
  if ( p2.y + 35 <0 || p2.x + 35 <0 || p2.y - 35 > height || p2.x - 35 > width){
    planet2.remove(i);
    }
  }
  
  
  
}

void deleteBh(){
if (keyPressed) {
    if (key == 'd') {
      for (int i=blackhole.size()-1; i>=0; i--) {
      Blackhole bh = (Blackhole) blackhole.get(i);
      blackhole.remove(i);
    }
    }
}
}


void deleteAll(){
if (keyPressed) {
    if (key == 'a') {
      for (int i=planet1.size()-1; i>=0; i--) {
      Planet1 p1 = (Planet1) planet1.get(i);
      planet1.remove(i);
    }
    
      for (int i=planet2.size()-1; i>=0; i--) {
      Planet2 p2 = (Planet2) planet2.get(i);
      planet2.remove(i);
    }
    
     
     for (int i=blackhole.size()-1; i>=0; i--) {
      Blackhole bh = (Blackhole) blackhole.get(i);
      blackhole.remove(i);
    }
    
    for (int i=line.size()-1; i>=0; i--) {
      Line l = (Line) line.get(i);
      line.remove(i);
    }
    
    }
}
}


void bounce(){
  
for (int i=planet1.size()-1; i>=0; i--) {
    Planet1 p1 = (Planet1) planet1.get(i);
  for(int j=planet2.size()-1; j>=0; j--){
    Planet2 p2 = (Planet2) planet2.get(j);
  if (dist(p1.x, p1.y, p2.x, p2.y) <= 70 && dist(p1.x, p1.y, p2.x, p2.y) <= dist(p1.x-p1.xdir, p1.y-p1.ydir*p1.yspeed, p2.x-p2.xdir, p2.y-p2.ydir*p2.yspeed) ){
    if(p1.xdir==p2.xdir && p1.ydir==p2.ydir){
    p1.xdir *= -1;
    p1.ydir *= -1;
    float note1;
    note1 = map(p1.x, 0, width, 72,90);
    sc1.playNote(round(note1), 70, 4.0);
    float note2;
    note2 = map(p1.x, 0, width, 72,90);
    sc2.playNote(round(note2), 70, 2.0);
    }else if(p1.xdir==p2.xdir){
    p1.xdir *= -1;
    p1.ydir *= -1;
    p2.ydir *= -1;
    float note1;
    note1 = map(p1.x, 0, width, 72,90);
    sc1.playNote(round(note1), 70, 4.0);
    float note2;
    note2 = map(p1.x, 0, width, 72,90);
    sc2.playNote(round(note2), 70, 2.0);
    }else if(p1.ydir==p2.ydir){
    p1.xdir *= -1;
    p1.ydir *= -1;
    p2.xdir *= -1;
    float note1;
    note1 = map(p1.x, 0, width, 72,90);
    sc1.playNote(round(note1), 70, 4.0);
    float note2;
    note2 = map(p1.x, 0, width, 72,90);
    sc2.playNote(round(note2), 70, 2.0);
    }else{  
    p1.xdir *= -1;
    p2.xdir *= -1;
    p1.ydir *= -1;
    p2.ydir *= -1;
    float note1;
    note1 = map(p1.x, 0, width, 72,90);
    sc1.playNote(round(note1), 70, 4.0);
    float note2;
    note2 = map(p1.x, 0, width, 72,90);
    sc2.playNote(round(note2), 70, 2.0);
    }
   }
  }
 }

}

void choosepage(){
  rectMode(CORNER);
  noStroke();
  fill(255, 200);
  rect(100, 100, width - 200, height - 200, 10);
  
  fill(0);
  textSize(40);
  text("Shape", 300, 170);
  image(id0, 240, 180, 120, 120);
  textSize(40);
  text("Colour", 550, 170);
  image(id1, 490, 180, 120, 120);
  textSize(40);
  text("Sound", 800, 170);
  image(id2, 740, 180, 120, 120);
  
  textSize(20);
  text("Planet 1", 180, 460);
  fill(planet1r, planet1g, planet1b,100);
  //ellipse(180, 400, 80, 80); 
  //g1
   pushMatrix();
  noStroke();
 // fill(50,150,200,100);
  translate(180, 400);
  scale(0.2);
  rotate(radians(origin));
  for (int q = 0; q < 360; q+=15) {
    rotate(radians(q));
    beginShape();
    for (int i = -90; i <= 90; i+=3) {
      float angle = cos(radians(90+i))*30;
      float x = sin(radians(i*3+origin*2))*(angle);
      float y = i*3;
      vertex(x, y);
    }
    endShape();
  }
  popMatrix();
  
  
  
  if(clickplanet == 1){
    noFill();
    stroke(255);
    rectMode(CENTER);
    rect(180, 410, 100, 140, 10);
  }
  
  textSize(20);
  fill(0);
  text("Planet 2", 180, 640);
  fill(0);
  noStroke();
  fill(planet2r, planet2g, planet2b,150);
  
  //ellipse(180, 580, 80, 80);
  
  pushMatrix();
  translate(180,570); 
  scale(0.3);
  rotate(radians(frameCount/220));
  for (int i = 0; i < 360; i+=15) {
    
    
    float x = cos(radians(i))*100;
    float y = sin(radians(i))*100;
    
  
    pushMatrix();
    
    translate(x, y);
    

    rotate(origin/10);
    rect(0, 0, x, y,10);
    
   
    popMatrix();
  }
  
  popMatrix();
  
  if(clickplanet == 2){
    noFill();
    stroke(255);
    rectMode(CENTER);
    rect(180, 590, 100, 140, 10);
  }
  
  noFill();
  stroke(255);
  rectMode(CORNER);
  rect(260, 320, 590, 340, 10);
  textSize(20);
  if(clickplanet == 1){
    fill(0);
    text("Planet 1", 310, 350);
  } else if (clickplanet == 2){
    fill(0);
    text("Planet 2", 310, 350);
  }
  
  if (clickplanet == 1){
    fill(planet1r, planet1g, planet1b,100);
    pushMatrix();
  noStroke();
 // fill(50,150,200,100);
  translate(550, 500);
  scale(0.6);
  rotate(radians(origin));
  for (int q = 0; q < 360; q+=15) {
    rotate(radians(q));
    beginShape();
    for (int i = -90; i <= 90; i+=3) {
      float angle = cos(radians(90+i))*30;
      float x = sin(radians(i*3+origin*2))*(angle);
      float y = i*3;
      vertex(x, y);
    }
    endShape();
  }
  popMatrix();
  } else if(clickplanet == 2){
    noStroke();
    fill(planet2r, planet2g, planet2b,100);
    pushMatrix();
    translate(550,500); 
    scale(0.3);
    rotate(radians(frameCount/220));
    for (int i = 0; i < 360; i+=15) {
    float x = cos(radians(i))*100;
    float y = sin(radians(i))*100;
    pushMatrix();
    translate(x, y);
    rotate(origin/10);
    rect(0, 0, x, y,10);
    popMatrix();
  }
  popMatrix(); 
  }
  //ellipse(550, 500, 200, 200);
  //g1
   
  
  textSize(25);
  fill(0);
  text("Confirm", 930, 650);
  if(mouseX > 870 && mouseX < 989 && mouseY > 620 && mouseY < 660){
    fill(255, 100);
  } else {
    fill(255, 0);
  }
  rect(870, 620, 120, 40, 10);
  
  
  
  
}



void mousePressed() {
 

  if (mouseX > 480 && mouseX < 560 && mouseY > 45 && mouseY < 126){
  mode = 1;
  clickchoosepage = true;
  clickplanet = 1;
  } 
  if (mouseX > 600 && mouseX < 680 && mouseY > 45 && mouseY < 126){
  mode = 2;
  clickchoosepage = true;
  clickplanet = 2;
  }
  if (mouseX > 710 && mouseX < 795 && mouseY > 45 && mouseY < 126){
  mode = 6;
  }

  if (mouseX > 867 && mouseX < 983 && mouseY > 63 && mouseY < 108){
  mode = 8;
  }
  
  if (mouseY > 180) {
  if (mode == 1 && clickchoosepage == false){ 
  planet1.add(new Planet1());
  }
  
  if (mode == 2 && clickchoosepage == false) {
  planet2.add(new Planet2());
  }
  

  
  if (mode == 6 && clickchoosepage == false) {
  blackhole.add(new Blackhole());
  }
  
  if (mode == 8 && clickchoosepage == false) {
  line.add(new Line());
  }
  
  }
    
  if(clickchoosepage == true && mouseX > 870 && mouseX < 989 && mouseY > 620 && mouseY < 660){
    clickchoosepage = false;
  }
}
 
 
public class Planet1 {
  float x;
  float y;
  float yspeed;
  float ydir;
  float xdir;
  float d;
  float dx;
  float dy;
 
  Planet1() {
    x = mouseX;
    y = mouseY;
    yspeed = random(3,5);
    ydir = 1;
    xdir = random(-1,1);
  }
 
  void run() {
    x = x + xdir;
    y = y + ydir * yspeed;
  }
 
  void display() {
    noStroke();
    fill(planet1r, planet1g, planet1b,100);
    //image(planet1pic,x-50,y-50,100,100);
   // ellipse(x-50,y-50,80,80);
    
    //g1
   pushMatrix();
  noStroke();
 // fill(50,150,200,100);
  translate(x,y);
  scale(0.2);
  rotate(radians(origin));
  for (int q = 0; q < 360; q+=15) {
    rotate(radians(q));
    beginShape();
    for (int i = -90; i <= 90; i+=3) {
      float angle = cos(radians(90+i))*30;
      float x = sin(radians(i*3+origin*2))*(angle);
      float y = i*3;
      vertex(x, y);
    }
    endShape();
  }
  popMatrix();
    
  }
  
  float distance(float x1,float y1,float x2,float y2){
  dx = x1 - x2;  
  dy = y1 - y2;  
  d = sqrt(dx*dx + dy*dy);  
  return d;
  }
  
  void bounce(){
  if (distance(x,y,earthX,earthY) <= 870 && distance(x,y,earthX,earthY) <= distance(x-xdir,y-ydir*yspeed,earthX,earthY)) {
      ydir *= -1;
      float note;
      note = map(x, 0, width, 75, 85);
      sc1.playNote(round(note), 70, 4.0);
    }
    
  if ( y < 200 && ydir<=1){
    ydir *= -1;
  }
  
  } 
}


public class Planet2 {
  float x;
  float y;
  float yspeed;
  float ydir;
  float xdir;
  float d;
  float dx;
  float dy;
 
  Planet2() {
    x = mouseX;
    y = mouseY;
    yspeed = random(3, 5);
    ydir = 1;
    xdir = random(-1,1);
  }
 
  void run() {
    x = x + xdir;
    y = y + ydir * yspeed;
  }
 
 
  void display() {
    noStroke();
    fill(planet2r, planet2g, planet2b,150);
    // ellipse(x-50,y-50,100,100);
      //g2
 
 
   pushMatrix();
  translate(x,y); 
  scale(0.3);
  rotate(radians(frameCount/220));
  for (int i = 0; i < 360; i+=15) {
    
    
    float x = cos(radians(i))*100;
    float y = sin(radians(i))*100;
    
  
    pushMatrix();
    
    translate(x, y);
    

    rotate(origin/10);
    rect(0, 0, x, y,10);
    
   
    popMatrix();
  }
  
  popMatrix();
  
  
     
    //image(planet2pic,x-50,y-50,100,100);
  }
  
  float distance(float x1,float y1,float x2,float y2){
  dx = x1 - x2;  
  dy = y1 - y2;  
  d = sqrt(dx*dx + dy*dy);  
  return d;
  }
  
  void bounce(){
  if (distance(x,y,earthX,earthY) <= 870 && distance(x,y,earthX,earthY) <= distance(x-xdir,y-ydir*yspeed,earthX,earthY)) {
      ydir *= -1;
      float note;
      note = map(x, 0, width, 72,90);
      sc2.playNote(round(note), 70, 2.0);
    }
    
  if ( y < 200 && ydir<=1){
    ydir *= -1;
  }
  }  
}



  



public class Line {
float lineX;
float lineY;
 
 Line(){
 lineX = mouseX;
 lineY = mouseY;
 }

void make(){
  stroke(255);
  line(lineX-50,lineY,lineX+50,lineY);
}
}

public class Blackhole {
float holeX;
float holeY;
float dx;
float dy;
float d;
 
 Blackhole(){
 holeX = mouseX;
 holeY = mouseY;
 }

void here(){
  pushMatrix();
  translate(holeX,holeY);
  rotate(angle);
  angle+=0.02;
  imageMode(CENTER);
  if(frameCount%20==0||frameCount%20==1||frameCount%20==2||frameCount%20==3){
  image(blackhole1,0,0,100,100);
  }
  if(frameCount%20==4||frameCount%20==5||frameCount%20==6||frameCount%20==7){
  image(blackhole2,0,0,100,100);
  }
  if(frameCount%20==8||frameCount%20==9||frameCount%20==10||frameCount%20==11){
  image(blackhole3,0,0,100,100);
  }
  if(frameCount%20==12||frameCount%20==13||frameCount%20==14||frameCount%20==15){
  image(blackhole4,0,0,100,100);
  }
  if(frameCount%20==16||frameCount%20==17||frameCount%20==18||frameCount%20==19){
  image(blackhole5,0,0,100,100);
  }
  imageMode(CORNER);
  popMatrix();
}

}