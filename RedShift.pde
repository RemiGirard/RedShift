import controlP5.*;
ControlP5 p5;
Light[] L1 = new Light[1000];
Star[] stars = new Star[10000];
Star[] movingstars = new Star[100];
Knob myKnobA;
PImage earthimg;


//parameters
float lightspeed=5;
float movespeed=0.1;
int lightnumbermax=30;
float lightsize = 10;
float spaceshipsize = 10;
boolean locklightgenerator=true;
boolean lockpulsarbutton=true;
boolean pulsar=false;
float pulsarspeed=0.1;
float imagecount=0;
float spaceshipspeed = 0;
int earthsize=50;
color colorreceived;
float starsnumber=5000;
float movingstarsnumber=50;
int interfaceearth = 150;
float anglereceived =0;
float angleactu =0;
float anglemax,anglemin;
boolean generalredshift=true;
float generalredshiftvalue = 0.1;
int lightprecision=360;
float spiralespeed=10;
boolean spirale=true;
int spiralenumber=4;

float test=0;




public void lockpulsarbutton(){
if(!lockpulsarbutton){lockpulsarbutton=true;}
  else{lockpulsarbutton=false;}
}

public void locklightbutton(){
if(!locklightgenerator){locklightgenerator=true;}
  else{locklightgenerator=false;}
}

public void generalredshift(){
if(!generalredshift){generalredshift=true;}
  else{generalredshift=false;}
}

public void spirale(){
if(!spirale){spirale=true;}
  else{spirale=false;}
}



// init var
float p = 0;
float posX=100;
float posY=100;
PVector v1,oldv1,v3,oldv3;
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
int[] lightnumberlist= new int[256]; 
int actuallightnumbermax = 0;
int numberlist =0;
int Y_AXIS = 1;
int X_AXIS = 2;
color b1, b2, c1, c2;
float colorhuereceived=50;
float coloractu = 50;
float addtoangleactu,movingstarspeed;


 float pointangle=0;
float spiralepointamgle=0;

void setup(){
   size(1500,1000); 
   frameRate(24);
   colorMode(HSB,100);
   
   c1 = color(0, 60, 60);
  c2 = color(80, 60, 60);
   
   earthimg = loadImage("earth02.png");
   earthimg.resize(earthsize*10,earthsize*10);
   p5 = new ControlP5(this);

   v1 = new PVector(0,0);
   oldv1 = new PVector(0,0);
 
   for (int i = 0; i < keytopress.length; i++) {
     keytopress[i] = false;
  }
 
 

 for(int i=0;i<=255;i++){
   lightnumberlist[i]=255-i;
   }
  
    for(int i=0;i<starsnumber;i++){
    stars[i] = new Star(0,0,width,height);
 }

for(int i=0;i<movingstarsnumber;i++){
    movingstars[i] = new Star(0,height-interfaceearth,interfaceearth,height);
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
     
     p5.addSlider("pulsarspeed")
     .setPosition(10,interfaceplace)
     .setRange(0.001,1)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addSlider("movespeed")
     .setPosition(10,interfaceplace)
     .setRange(0,lightspeed)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addSlider("generalredshiftvalue")
     .setPosition(10,interfaceplace)
     .setRange(0,1)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addSlider("lightprecision")
     .setPosition(10,interfaceplace)
     .setRange(1,1000)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addSlider("spiralespeed")
     .setPosition(10,interfaceplace)
     .setRange(0,10)
     ;
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
     
     p5.addButton("generalredshift")
     .setValue(0)
     .setPosition(10,interfaceplace)
     .setSize(200,19)
     ;
     interfaceplace = interfaceplace+20;
     
      p5.addButton("spirale")
     .setValue(0)
     .setPosition(10,interfaceplace)
     .setSize(200,19)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addSlider("test")
     .setPosition(10,interfaceplace)
     .setRange(0,360)
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

  if(actuallightnumbermax<lightnumbermax){
     actuallightnumbermax=actuallightnumbermax+1; 
  }else{
    actuallightnumbermax=lightnumbermax;
  }

   for(int i=255;i>0;i--){
     lightnumberlist[i]=lightnumberlist[i-1];
   }
   lightnumberlist[0]=lightnumberlist[255];

   L1[lightnumberlist[0]]= new Light(lightnumberlist[0]);
   L1[lightnumberlist[0]].lightwave(posX,posY,v1.x,v1.y);

   started=true;
   lightnumber=lightnumber+1;
}

 
 //display the star
  for(int i=0;i<starsnumber;i++){
      
      stars[i].display();
 }
 
 

   
    //move the waves of lights
   for(int i=0;i<=actuallightnumbermax;i++){
    // if(first){firsti=i+1;first=false;}
    
    int y = lightnumberlist[i];
    
     if(L1[y] != null){
      L1[y].display();
     }

    }
  
  //display the spaceship
  c = color(50,50,50);
  fill(c);
  stroke(0,0,50);
  strokeWeight(1);
  ellipse(posX,posY,spaceshipsize,spaceshipsize);
  hearthcolor=color(100,50,50);
 
 //display the direction of the spaceship
  fill(0,50,0);
  noStroke();
  ellipse(posX+moveX*spaceshipsize*2,posY+moveY*spaceshipsize*2,spaceshipsize/2,spaceshipsize/2);

 
 //move the object and set limits
  posX=posX+v1.x;
  posY=posY+v1.y;
  if(posX<0){posX=0;v1.x=0;}
  if(posY<0){posY=0;v1.y=0;}
  if(posX>width){posX=width;v1.x=0;}
  if(posY>height){posY=height;v1.y=0;}
  
  




  
  //create earth
  imageMode(CENTER);
  image(earthimg, width/2, height/2,earthsize,earthsize);
  // fill(hearthcolor);
  // ellipse(width/2,height/2,earthsize,earthsize);
   
   
   //interface hearth view
   c=color(0,0,70);
   stroke(100);
   fill(0);
   
   rect(0,height-interfaceearth,interfaceearth,interfaceearth);
   noStroke();
   
   
  
   
   float phi = Math.abs(anglereceived - angleactu);       // This is either the distance or 360 - distance
   movingstarspeed = phi > 180 ? 360 - phi : phi;
   int sign = (anglereceived - angleactu >= 0 && anglereceived - angleactu <= 180) || (anglereceived - angleactu <= -180 && anglereceived- angleactu>= -360) ? 1 : -1;  movingstarspeed *= sign;
   movingstarspeed = movingstarspeed/10;
   angleactu=angleactu+movingstarspeed;
   if(angleactu<0){angleactu=angleactu+360;}
   if(angleactu>=360){angleactu=angleactu-360;}

   
   
  
  for(int i=0;i<movingstarsnumber;i++){
    movingstars[i].moveandreplace(movingstarspeed);
     }

   
   
   fill(colorreceived);
   ellipse(interfaceearth/2,height-(interfaceearth/2),50,50);
   
   
  
  
  // Color detection
  int interfacecolor=100;
  int startinterfacecolor=interfaceearth+1;
  float selectcolorsize=interfacecolor/3;
  setGradient(startinterfacecolor, height-interfacecolor, interfacecolor*4, interfacecolor, c2, c1);
 float basicpos=map(50,85,0,startinterfacecolor,startinterfacecolor+interfacecolor*4-selectcolorsize);
 
 
   //smooth the movement
  float addtocoloractu;
  if(colorhuereceived!=coloractu){
    addtocoloractu=(colorhuereceived-coloractu)/10;
    coloractu=coloractu+addtocoloractu;
    if(addtocoloractu<=1 && addtocoloractu>=1){coloractu=colorhuereceived;}
  }
 
  float colorhuedisplay = map(coloractu,85,0,startinterfacecolor,startinterfacecolor+interfacecolor*4-selectcolorsize);
  
  
  
  


  //display basic and color and updated color
  noFill();
  strokeWeight(5);
  stroke(50,50,50);
 
  rect(basicpos,height-interfacecolor-10,selectcolorsize,interfacecolor+10);
  stroke(1,50,50);
  rect(colorhuedisplay,height-interfacecolor-10,selectcolorsize,interfacecolor+10);

  
  
  
  
//pulsar
if(lockpulsarbutton){
  pulsar=false;
  imagecount=imagecount+1;
  if(imagecount>=1/pulsarspeed){
    pulsar=true;
    imagecount=0;
  }
}


 
  //reset
  moveX=0;
  moveY=0;

// get the keys pressed

//Up
if(keytopress[1]){moveY=-movespeed;}
//Left
if(keytopress[2]){moveX=-movespeed;}
//Down
if(keytopress[3]){moveY=movespeed;}
//Right
if(keytopress[4]){moveX=movespeed;}
  

  //update the object's movement
  v1.x=v1.x+moveX;
  v1.y=v1.y+moveY;
  //check if the value of object's movement is bigger than lightspeed
  if(speedlimit){
    spaceshipspeed = dist(v1.x,v1.y,0,0);
    myKnobA.setValue(spaceshipspeed);
    v1.limit(lightspeed);
  }
  
 
  

 
  
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

void setGradient(int x, int y, float w, float h, color c1, color c2) {
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
}
