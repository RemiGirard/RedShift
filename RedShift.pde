import controlP5.*;
ControlP5 p5;
Light[] L1 = new Light[1000];
Star[] stars = new Star[1000];
Knob myKnobA;
PImage earthimg;


//parameters
float lightspeed=5;
float movespeed=0.1;
int lightnumbermax=50;
float lightsize = 10;
float spaceshipsize = 10;
boolean locklightgenerator=true;
float objectspeed = 0;
int earthsize=50;
color colorreceived;
float starsnumber=500;



public void locklightbutton(){
if(!locklightgenerator){locklightgenerator=true;}
  else{locklightgenerator=false;}
}

public void movespeed(){
  p5.addSlider("movespeed")
     .setPosition(10,100)
     .setRange(0,lightspeed)
     ;
}


public void earthimg(){
earthimg.resize(earthsize,earthsize);
println(12);
}

// init var
float p = 0;
float posX=100;
float posY=100;
PVector v1,oldv1;
float moveX,moveY;
boolean started =false;
int lightnumber=0;
float oldv1x,oldv1y;
boolean[] keytopress = new boolean[9];
boolean speedlimit = true;
color c,o,hearthcolor;
int addtoi = 1;
int lightmove;
int firsti = lightnumbermax+1;

void setup(){
   size(1500,1000); 
   frameRate(25);
   colorMode(HSB,100);
   
   earthimg = loadImage("earth.jpg");
   earthimg.resize(earthsize,earthsize);
   p5 = new ControlP5(this);

   v1 = new PVector(0,0);
   oldv1 = new PVector(0,0);
 
   for (int i = 0; i < keytopress.length; i++) {
     keytopress[i] = false;
  }
 
 for(int i=0;i<starsnumber;i++){
      stars[i] = new Star();
 }

 
 
 
  //interface
   float interfaceplace = 10;
p5.addSlider("lightnumbermax")
     .setPosition(10,10)
     .setRange(0,255)
     ;
interfaceplace = interfaceplace+20;


  
  p5.addSlider("lightspeed")
     .setPosition(10,interfaceplace)
     .setRange(1,20)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addSlider("lightsize")
     .setPosition(10,interfaceplace)
     .setRange(0,50)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addSlider("spaceshipsize")
     .setPosition(10,interfaceplace)
     .setRange(0,100)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addSlider("earthsize")
     .setPosition(10,interfaceplace)
     .setRange(0,100)
     ;
     interfaceplace = interfaceplace+20;
     
     
     interfaceplace = interfaceplace+20;
     
     p5.addButton("locklightbutton")
     .setValue(0)
     .setPosition(10,interfaceplace)
     .setSize(200,19)
     ;
     interfaceplace = interfaceplace+20;
     
     
     
     
     myKnobA = p5.addKnob("objectspeed")
               .setRange(0,lightspeed)
               .setValue(50)
               .setPosition(width-110,height-120)
               .setRadius(50)
               .setDragDirection(Knob.HORIZONTAL)
               ;
}

void draw(){
 background(0);
 
 //display the star
  for(int i=0;i<starsnumber;i++){
      stars[i].display();
 }
 
 //move the object and set limits
  posX=posX+v1.x;
  posY=posY+v1.y;
  if(posX<0){posX=0;v1.x=0;}
  if(posY<0){posY=0;v1.y=0;}
  if(posX>width){posX=width;v1.x=0;}
  if(posY>height){posY=height;v1.y=0;}
  
  
  
   //move the waves of lights
 if(started){
   boolean first=true;
   for(int i=0;i<=lightnumbermax;i++){
     if(first){firsti=i+1;first=false;}
     if(L1[i] != null){
      L1[i].display();
     }else{println("L1["+i+"] is null");}
//     if(i==lightnumbermax){i=0;}
    }
  }

    //create the object
  c = color(50,50,50);
  fill(c);
  ellipse(posX,posY,spaceshipsize,spaceshipsize);
  hearthcolor=color(100,50,50);
  
  //create earth
  
  image(earthimg, width/2, height/2);
  // fill(hearthcolor);
  // ellipse(width/2,height/2,earthsize,earthsize);
   
   
   //interface hearth view
   c=color(0,0,70);
   stroke(100);
   fill(0);
   float interfacehearth = 150;
   rect(0,height-interfacehearth,interfacehearth,interfacehearth);
   noStroke();
   fill(colorreceived);
   ellipse(interfacehearth/2,height-(interfacehearth/2),50,50);
  
// get the keys pressed
//Space to create light
if(keytopress[0] || locklightgenerator){
  if(lightnumber>lightnumbermax){lightnumber=0;lightmove=1;}
  
   L1[lightnumber]= new Light(lightnumber);
   L1[lightnumber].lightwave(posX,posY,v1.x,v1.y);
   
   lightnumber=lightnumber+1;
   started=true;
  }
//Up
if(keytopress[1]){moveY=-movespeed;}
//Left
if(keytopress[2]){moveX=-movespeed;}
//Down
if(keytopress[3]){moveY=movespeed;}
//Right
if(keytopress[4]){moveX=movespeed;}
  
  //get the value of object's movement in case it is bigger than the lightspeed
  oldv1.x=v1.x;
  oldv1.y=v1.y;
  //update the object's movement
  v1.x=v1.x+moveX;
  v1.y=v1.y+moveY;
  //test if the value of object's movement is bigger than lightspeed
  if(speedlimit){
    objectspeed = dist(v1.x,v1.y,0,0);
    myKnobA.setValue(objectspeed);
    if(objectspeed>lightspeed){v1.x=oldv1.x;v1.y=oldv1.y;}
  }
  //reset
  moveX=0;
  moveY=0;
  
  
 
  
}

void keyPressed(){
  if(key=='w' || key=='W'){keytopress[1]=true;}
  if(key=='a' || key=='A'){keytopress[2]=true;}
  if(key=='s' || key=='S'){keytopress[3]=true;}
  if(key=='d' || key=='D'){keytopress[4]=true;}
  if(key=='m' || key=='M'){keytopress[0]=true;}
}

void keyReleased(){
  if(key=='w' || key=='W'){keytopress[1]=false;}
  if(key=='a' || key=='A'){keytopress[2]=false;}
  if(key=='s' || key=='S'){keytopress[3]=false;}
  if(key=='d' || key=='D'){keytopress[4]=false;}
  if(key=='m' || key=='M'){keytopress[0]=false;}
}

