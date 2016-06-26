import controlP5.*;
ControlP5 p5;
Light[] L1 = new Light[1000];


//parameters
float lightspeed=5;
float movespeed=0.1;
int lightnumbermax=50;
float lightsize = 10;
float spaceshipsize = 10;
boolean locklightgenerator=false;

// init var
float posX=100;
float posY=100;
PVector v1,oldv1;
float moveX,moveY;
boolean started =false;
int lightnumber=0;
float oldv1x,oldv1y;
boolean[] keytopress = new boolean[9];
boolean speedlimit = true;
color c;
int addtoi = 1;
int lightmove;
int firsti = lightnumbermax+1;

void setup(){
   size(1000,1000); 
   frameRate(25);
   colorMode(HSB,100);
   
   p5 = new ControlP5(this);
   v1 = new PVector(0,0);
   oldv1 = new PVector(0,0);
 
   for (int i = 0; i < keytopress.length; i++) {
     keytopress[i] = false;
  }
 
 float interfaceplace = 10;
  //interface
p5.addSlider("lightnumbermax")
     .setPosition(10,10)
     .setRange(0,255)
     ;
interfaceplace = interfaceplace+20;


  
  p5.addSlider("lightspeed")
     .setPosition(10,interfaceplace)
     .setRange(0,20)
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
     
     p5.addSlider("movespeed")
     .setPosition(10,interfaceplace)
     .setRange(0,lightspeed)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addButton("locklightgenerator")
     .setValue(0)
     .setPosition(10,interfaceplace)
     .setSize(200,19)
     ;
     interfaceplace = interfaceplace+20;
}

void draw(){
 background(0);
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
    println(i);
     if(L1[i] != null){
      L1[i].display();
     }else{println("L1["+i+"] is null");}
//     if(i==lightnumbermax){i=0;}

    }
    
    
    //create the object
  c = color(50,50,50);
  fill(c);
  ellipse(posX,posY,spaceshipsize,spaceshipsize);
    
  }
  
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
    if(dist(v1.x,v1.y,0,0)>lightspeed){v1.x=oldv1.x;v1.y=oldv1.y;}
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

