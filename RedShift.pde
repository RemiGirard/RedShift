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
boolean lockpulsarbutton=true;
boolean pulsar=false;
float pulsarperiod=10;
float imagecount=0;
float spaceshipspeed = 0;
int earthsize=50;
color colorreceived;
float starsnumber=500;




public void lockpulsarbutton(){
if(!lockpulsarbutton){lockpulsarbutton=true;}
  else{lockpulsarbutton=false;}
}

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
int[] lightnumberlist= new int[255]; 
float actuallightnumbermax = lightnumbermax;


void setup(){
   size(1500,1000); 
   frameRate(25);
   colorMode(HSB,100);
   
   earthimg = loadImage("earth02.png");
   earthimg.resize(earthsize*10,earthsize*10);
   p5 = new ControlP5(this);

   v1 = new PVector(0,0);
   oldv1 = new PVector(0,0);
 
   for (int i = 0; i < keytopress.length; i++) {
     keytopress[i] = false;
  }
 
 for(int i=0;i<starsnumber;i++){
      stars[i] = new Star();
 }

  
  
  for(int i=0;i<=lightnumbermax;i++){
      lightnumberlist[i] = i;
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
     .setRange(0,200)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addSlider("pulsarperiod")
     .setPosition(10,interfaceplace)
     .setRange(1,60)
     ;
     interfaceplace = interfaceplace+20;
     
     interfaceplace = interfaceplace+20;
     
     p5.addButton("locklightbutton")
     .setValue(0)
     .setPosition(10,interfaceplace)
     .setSize(200,19)
     ;
     interfaceplace = interfaceplace+20;
     
      p5.addButton("lockpulsarbutton")
     .setValue(0)
     .setPosition(10,interfaceplace)
     .setSize(200,19)
     ;
     interfaceplace = interfaceplace+20;
     
     
     myKnobA = p5.addKnob("spaceshipspeed")
               .setRange(0,lightspeed)
               .setValue(50)
               .setPosition(width-210,height-220)
               .setRadius(100)
               .setDragDirection(Knob.HORIZONTAL)
               ;
}

void draw(){
 background(0);
 
 //Space to create light
if(keytopress[0] || locklightgenerator || pulsar){
 
  if(lightnumber>lightnumbermax){
    lightnumber=0;lightmove=1;
    for(int i=0;i<lightnumbermax;i++){lightnumberlist[i] = i;}
     actuallightnumbermax=lightnumbermax;
    }
      for(int i=0;i<=actuallightnumbermax;i++){
         
        lightnumberlist[i] =lightnumberlist[i]+1;
        if(lightnumberlist[i]>actuallightnumbermax){lightnumberlist[i]=0;}
          
    
    }
  
   L1[lightnumber]= new Light(lightnumber);
   L1[lightnumber].lightwave(posX,posY,v1.x,v1.y);
   
   
     
    
   started=true;
   lightnumber=lightnumber+1;
  }
 
 
 //display the star
  for(int i=0;i<starsnumber;i++){
      stars[i].display();
 }
 
    //move the waves of lights
 if(started){
  // boolean first=true;
  int[] wavelist = new int[lightnumbermax];
  for(int i=0;i<=lightnumbermax;i++){
    
  }
  
   for(int i=0;i<=actuallightnumbermax;i++){
    // if(first){firsti=i+1;first=false;}
    int y =lightnumberlist[i];
     if(L1[y] != null){
      L1[y].display();
     }else{
    // println("L1["+i+"] is null");
   }
//     if(i==lightnumbermax){i=0;}
    }
  }
 
 //move the object and set limits
  posX=posX+v1.x;
  posY=posY+v1.y;
  if(posX<0){posX=0;v1.x=0;}
  if(posY<0){posY=0;v1.y=0;}
  if(posX>width){posX=width;v1.x=0;}
  if(posY>height){posY=height;v1.y=0;}
  
  
  


    //create the object
  c = color(50,50,50);
  fill(c);
  ellipse(posX,posY,spaceshipsize,spaceshipsize);
  hearthcolor=color(100,50,50);
  
  //create earth
  imageMode(CENTER);
  image(earthimg, width/2, height/2,earthsize,earthsize);
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
  
//pulsar
if(lockpulsarbutton){
  pulsar=false;
  imagecount=imagecount+1;
  if(imagecount>=pulsarperiod){
    pulsar=true;
    imagecount=0;
  }
}
// get the keys pressed

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
    spaceshipspeed = dist(v1.x,v1.y,0,0);
    myKnobA.setValue(spaceshipspeed);
    if(spaceshipspeed>=lightspeed){v1.x=oldv1.x;v1.y=oldv1.y;}
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

