//import library
import controlP5.*;
ControlP5 p5;
Knob myKnobA;

//set variables objects
Light[] L1 = new Light[255+1];
Star[] stars = new Star[10000];
Star[] movingstars = new Star[100];

//earthimage+loadscreen
PImage earthimg,arrows,spacebar;


//presets
PImage resetI,pulsarI,spiraleI,circleI,fullI,waveI,configI;
Button resetB,pulsarB,spiraleB,circleB,fullB,waveB,configB;

//parameters variables
int lightnumbermax,lightprecision,spiralenumber,earthsize;
float lightsize,lightspeed,pulsarspeed,generalredshiftvalue,spiralespeed,spaceshipsize,displayspaceshipspeed;
boolean locklightgenerator,lockpulsarbutton,generalredshift,spirale,movementstart;



//preset
boolean[] preset=new boolean[10];



// functions for buttons
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
float oldv1x,oldv1y;
boolean[] keytopress = new boolean[9];
boolean speedlimit = true;
color o;
int addtoi = 1;
int lightmove;
int firsti = lightnumbermax+1;
int[] lightnumberlist= new int[256]; 
int actuallightnumbermax = 0;
int numberlist =0;
color b1, b2, c1, c2;
float colorhuereceived=42.5;
float coloractu = 42.5;
float addtoangleactu,movingstarspeed;
float previouslightnumber=0;
float imagecount=0;
float anglereceived =0;
float angleactu =0;
float anglemax,anglemin;
float spaceshipspeed = 0;
String approachortakeaway="";
float movespeed=0.5;
float pointangle=0;
boolean pulsar=false;
float starsnumber=5000;
float movingstarsnumber=50;
int interfaceearth = 150;
boolean display=true;
boolean preload=true;
float addtov1x=2;
float movementangle=0;



void setup(){
  //init parameters
   size(1500,1000); 
   frameRate(24);
   colorMode(HSB,100);
   p5 = new ControlP5(this);
   
  
   
   //set gradient color
  c1 = color(0, 60, 60);
  c2 = color(80, 60, 60);
  
  
   
   //images
   earthimg = loadImage("earth02.png");
   arrows = loadImage("arrow.png");
   spacebar=loadImage("spacebar.png");

 resetI = loadImage("reset.png");
   pulsarI = loadImage("pulsar.png");
   spiraleI = loadImage("spirale.png");
   circleI = loadImage("circle.png");
   fullI = loadImage("full.png");
   waveI = loadImage("wave.png");
   configI = loadImage("config.png");
   
   // interface : preset
    float interfacepresetX=40;
    float interfacepresetY= height-interfaceearth-135;
   resetB = new Button(interfacepresetX,interfacepresetY,resetI);
   interfacepresetX+=75;
   pulsarB = new Button(interfacepresetX,interfacepresetY,pulsarI);
   interfacepresetX+=75;
   circleB = new Button(interfacepresetX,interfacepresetY,circleI);
 
   interfacepresetX=40;
   interfacepresetY+=85;
   spiraleB = new Button(interfacepresetX,interfacepresetY,spiraleI);
   interfacepresetX+=75;
   fullB = new Button(interfacepresetX,interfacepresetY,fullI);
   interfacepresetX+=75;
   waveB = new Button(interfacepresetX,interfacepresetY,waveI);
   
   interfacepresetX=40;
   interfacepresetY-=170;
   configB = new Button(interfacepresetX,interfacepresetY,configI);
   
    //space ship vector
   v1 = new PVector(0,0);

   //set keys to false
   for (int i = 0; i < keytopress.length; i++) {
     keytopress[i] = false;
   }
 
 
   // create a list of the waves by creation order for a perfect display
   for(int i=0;i<=255;i++){
     lightnumberlist[i]=255-i;
   }
  
   // create the stars
    for(int i=0;i<starsnumber;i++){
      stars[i] = new Star(0,0,width,height);
   }

  //create the moving stars for the planet view
    for(int i=0;i<movingstarsnumber;i++){
      movingstars[i] = new Star(0,height-interfaceearth,interfaceearth,height);
     }
 
 

               

   //interface
   float interfaceplace = 10;
    // light
p5.addSlider("lightnumbermax")
     .setPosition(10,10)
     .setRange(0,255)
     ;
interfaceplace = interfaceplace+20;

p5.addSlider("lightsize")
     .setPosition(10,interfaceplace)
     .setRange(0,50)
     ;
     interfaceplace = interfaceplace+20;

  
  p5.addSlider("lightspeed")
     .setPosition(10,interfaceplace)
     .setRange(1,20)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addSlider("lightprecision")
     .setPosition(10,interfaceplace)
     .setRange(1,1000)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addButton("locklightbutton")
     .setPosition(10,interfaceplace)
     .setSize(200,19)
     ;
     interfaceplace = interfaceplace+40;
     
     
     //pulsar
      p5.addSlider("pulsarspeed")
     .setPosition(10,interfaceplace)
     .setRange(0.001,1)
     ;
     interfaceplace = interfaceplace+20;
     
       p5.addButton("lockpulsarbutton")

     .setPosition(10,interfaceplace)
     .setSize(200,19)
     ;
     interfaceplace = interfaceplace+40;
     
      p5.addSlider("generalredshiftvalue")
     .setPosition(10,interfaceplace)
     .setRange(0,1)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addButton("generalredshift")

     .setPosition(10,interfaceplace)
     .setSize(200,19)
     ;
     interfaceplace = interfaceplace+40;
     
     p5.addSlider("spiralespeed")
     .setPosition(10,interfaceplace)
     .setRange(0,20)
     ;
     interfaceplace = interfaceplace+20;
     
     p5.addSlider("spiralenumber")
     .setPosition(10,interfaceplace)
     .setRange(0,5)
     ;
     interfaceplace = interfaceplace+20;
     
     
      p5.addButton("spirale")
     .setPosition(10,interfaceplace)
     .setSize(200,19)
     ;
     interfaceplace = interfaceplace+40;
     
  
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
     
     myKnobA = p5.addKnob("displayspaceshipspeed")
               .setRange(0,1)
               .setPosition(width-210,height-220)
               .setRadius(100)
               .setDragDirection(Knob.HORIZONTAL)
               ;
 reset();
 updateP5();
 HideCP5();
}

// function used for reset paremeters on presets
void reset(){
 lightnumbermax=30;
lightsize = 10;
 lightspeed=5;
lightprecision=360;
locklightgenerator=false;
pulsarspeed=0.1;
lockpulsarbutton=false;
 generalredshiftvalue = 0.1;
 generalredshift=false;
 spiralespeed=10;
spiralenumber=1;
spirale=false;
spaceshipsize = 10;
earthsize=50;
displayspaceshipspeed = 0; 
movementstart =false;




}
// update display values
void updateP5(){
  p5.getController("lightnumbermax").setValue(lightnumbermax);
  p5.getController("lightsize").setValue(lightsize);
  p5.getController("lightspeed").setValue(lightspeed);
  p5.getController("lightprecision").setValue(lightprecision);
  p5.getController("pulsarspeed").setValue(pulsarspeed);
  p5.getController("generalredshiftvalue").setValue(generalredshiftvalue);
  p5.getController("spiralespeed").setValue(spiralespeed);
  p5.getController("spiralenumber").setValue(spiralenumber);
  p5.getController("spaceshipsize").setValue(spaceshipsize);
  p5.getController("earthsize").setValue(earthsize);
  
}



void draw(){
 background(0);
 
 //Create a wave of light
if(keytopress[0] || locklightgenerator || pulsar){
  
  //change the lightnumbermax progressively
  if(actuallightnumbermax<lightnumbermax){
     actuallightnumbermax=actuallightnumbermax+1; 
  }else{
    actuallightnumbermax=lightnumbermax;
  }
  
  //Set the new wave to the first position and move others of one position
   for(int i=255;i>0;i--){
     lightnumberlist[i]=lightnumberlist[i-1];
   }
   lightnumberlist[0]=lightnumberlist[255];
  
   //create the wave of light in first position
   L1[lightnumberlist[0]]= new Light(lightnumberlist[0]);
   L1[lightnumberlist[0]].lightwave(posX,posY,v1.x,v1.y);

}

 
 //display the stars
  for(int i=0;i<starsnumber;i++){
      stars[i].display();
 }
 
 

   
    //move the waves of lights, use lightnumberlist to display last created first
   for(int i=0;i<=actuallightnumbermax;i++){
      int y = lightnumberlist[i];
      if(L1[y] != null){
      L1[y].display();
      }else{
      //println("L1["+y+"] is null");
      }

    }
  
  //display the spaceship
  fill(42.5,50,50);
  stroke(0,0,50);
  strokeWeight(1);
  ellipse(posX,posY,spaceshipsize,spaceshipsize);
 
 //display the direction of the spaceship's power
  fill(0,50,0);
  noStroke();
  ellipse(posX+(Math.signum(moveX))*spaceshipsize/5,posY+(Math.signum(moveY))*spaceshipsize/5,spaceshipsize/2,spaceshipsize/2);

  

 
 //move the spaceship and set screen limits
  posX=posX+v1.x;
  posY=posY+v1.y;
  if(posX<0){posX=0;v1.x=0;}
  if(posY<0){posY=0;v1.y=0;}
  if(posX>width){posX=width;v1.x=0;}
  if(posY>height){posY=height;v1.y=0;}
  
  




  
  //display earth
  imageMode(CENTER);
  image(earthimg, width/2, height/2,earthsize,earthsize);
   
   
   
   

   
   //interface hearth view
   stroke(100);
   fill(0);
   rect(0,height-interfaceearth,interfaceearth,interfaceearth);
   rect(interfaceearth,height-interfaceearth,402,interfaceearth);
   noStroke();
   
   
  
    // Move the stars deppending on light received
   
   float phi = Math.abs(anglereceived - angleactu);      
   movingstarspeed = phi > PI ? TWO_PI - phi : phi;
   
   int sign = (anglereceived - angleactu >= 0 && anglereceived - angleactu <= PI) || (anglereceived - angleactu <= -PI && anglereceived- angleactu>= -TWO_PI) ? 1 : -1;  movingstarspeed *= sign;
   movingstarspeed = movingstarspeed/10;
  
   angleactu=angleactu+movingstarspeed;
   if(angleactu<0){angleactu=angleactu+TWO_PI;}
   if(angleactu>=TWO_PI){angleactu=angleactu-TWO_PI;}
    
    for(int i=0;i<movingstarsnumber;i++){
    movingstars[i].moveandreplace(-movingstarspeed*100);
     }

   
   //dipslay the spaceship depending on light received
   fill(colorhuereceived,50,50);
   ellipse(interfaceearth/2,height-(interfaceearth/2),50,50);
   
  
  // Color detection
  int interfacecolor=100;
  int startinterfacecolor=interfaceearth+1;
  float selectcolorsize=interfacecolor/3;
  setGradient(startinterfacecolor, height-interfacecolor, interfacecolor*4, interfacecolor, c2, c1);
 float basicpos=map(42.5,85,0,startinterfacecolor,startinterfacecolor+interfacecolor*4-selectcolorsize);
 

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
  stroke(42.5,50,50);
  rect(basicpos,height-interfacecolor-10,selectcolorsize,interfacecolor+10);
  line(basicpos+selectcolorsize/2,height-interfacecolor-10,basicpos+selectcolorsize/2,height-interfacecolor-20);
  stroke(1,50,50);
  rect(colorhuedisplay,height-interfacecolor-10,selectcolorsize,interfacecolor+10);
  line(colorhuedisplay+selectcolorsize/2,height-interfacecolor-10,colorhuedisplay+selectcolorsize/2,height-interfacecolor-20);

  stroke(50);
  line(colorhuedisplay+selectcolorsize/2,height-interfacecolor-20,basicpos+selectcolorsize/2,height-interfacecolor-20);
  fill(50);
  textSize(25);
  textAlign(CENTER);
  float movereceived=0;
  
  if(coloractu>42.5){movereceived=coloractu-42.5;approachortakeaway="approche à ";}
  if(coloractu<42.5){movereceived=42.5-coloractu;approachortakeaway="s'éloigne à ";}
  movereceived=map(movereceived,0,42.5,0,100);
  movereceived=round(movereceived);
  String displaymovereceived = str(movereceived);
  if(movereceived<10){
  displaymovereceived = displaymovereceived.substring(0,1);
  }else if(movereceived==100){
  displaymovereceived = displaymovereceived.substring(0,3);
  }else{
  displaymovereceived = displaymovereceived.substring(0,2);
  }
  
  text(approachortakeaway+displaymovereceived+"% vitesse lumière",basicpos+selectcolorsize-10, height-interfacecolor-25);
  
  
  
//pulsar
if(lockpulsarbutton){
  pulsar=false;
  imagecount=imagecount+1;
  if(imagecount>=1/pulsarspeed){
    pulsar=true;
    imagecount=0;
  }
}


 
  //reset spaceship movement before check if key pressed
  moveX=0;
  moveY=0;
  //set the power of the spaceship
  movespeed = lightspeed/20;

// get the keys pressed
//Up
if(keytopress[1]){moveY=-movespeed;}
//Left
if(keytopress[2]){moveX=-movespeed;}
//Down
if(keytopress[3]){moveY=movespeed;}
//Right
if(keytopress[4]){moveX=movespeed;}
  

  //update the spaceship's movement
  v1.x=v1.x+moveX;
  v1.y=v1.y+moveY;
  //check if the value of object's movement is bigger than lightspeed and limit it
  if(speedlimit){
    spaceshipspeed = dist(v1.x,v1.y,0,0);
    displayspaceshipspeed = spaceshipspeed/lightspeed;
    myKnobA.setValue(displayspaceshipspeed);
    v1.limit(lightspeed);
  }
  
 
  //interface preset
   resetB.display();
   pulsarB.display();
   spiraleB.display();
   circleB.display();
   fullB.display();
   waveB.display();
   configB.display();
   
    if(configB.selected){
      configB.selected=false;

 HideCP5();
}
   
   if(resetB.selected){
      resetB.selected=false;
 reset();

}
 
  if(pulsarB.selected){
    pulsarB.selected=false;
 
  reset();
lockpulsarbutton=true;
}

  if(spiraleB.selected){
    spiraleB.selected=false;
  
 reset();
 spirale=true;
 locklightgenerator=true;
 lightnumbermax=255;
 spiralenumber=4;
 updateP5();
}

  if(circleB.selected){
    circleB.selected=false;

  reset();
  locklightgenerator=true;
}
  
  
  if(fullB.selected){
    fullB.selected=false;
  
  reset();
  locklightgenerator=true;
  lightnumbermax=85;
  lightsize=50;
  lightspeed=20;
  lightprecision=180;
  
  updateP5();
  
}

  if(waveB.selected){
    
    reset();
     spirale=true;
   locklightgenerator=true;
   spiralenumber=2;
   spiralespeed=0;
   lightnumbermax=255;
   posX=50;
   posY=height/2-30;
     movementstart=true;
   
  
  lightspeed=4;


   updateP5();
  waveB.selected=false;
    
}

if(movementstart){
  pointangle=0;
  
  if(posX>=width || posX<=0){addtov1x=-addtov1x;}
    v1.x=addtov1x;
    v1.y=(sin(movementangle/2))*2;
    movementangle+=0.1;
    
   }
   
   
   if(preload){
     background(0);
     textAlign(CENTER);
     text("Vous etes la·le fier·e pilote d'un vaisseau spatial.",width/2,height/3-50);
     text("Votre vaisseau est d'une puissance jamais égalée puisqu'il réussi à s'approcher de la vitesse de la lumière !",width/2,height/3-25);
     text("Pour ne rien gâcher, il est capable d'émettre de la lumière dans toutes les directions.",width/2,height/3);
     text("Ces formidables capacités vous permettront d'observer l'influence",width/2,height/3+25);
     text("de la vitesse du vaisseau sur la couleur de la lumière qu'il émet.",width/2,height/3+50);
     
     image(arrows, 2*width/3, height/2,200,100);
     text("Les flèches permettent",2*width/3,height/2+100);
     text("de déplacer le vaisseau",2*width/3,height/2+125);
     image(spacebar, width/3, height/2,350,80);
     text("La barre espace permet",width/3,height/2+100);
     text("d'émettre de la lumière",width/3,height/2+125);
     
     text("Appuyez sur Espace pour continuer",width/2,2.5*height/3);
   }
   
   
}



void keyPressed(){
  preload=false;
  if(keyCode == LEFT){keytopress[2]=true;}
  if(key=='w' || key=='W' || keyCode == UP){keytopress[1]=true;}
  if(key=='a' || key=='A' || keyCode == LEFT){keytopress[2]=true;}
  if(key=='s' || key=='S' || keyCode == DOWN){keytopress[3]=true;}
  if(key=='d' || key=='D' || keyCode == RIGHT){keytopress[4]=true;}
  if(key=='l' || key=='L' || key==' '){keytopress[0]=true;}
}

void keyReleased(){
  if(key=='w' || key=='W' || keyCode == UP){keytopress[1]=false;}
  if(key=='a' || key=='A' || keyCode == LEFT){keytopress[2]=false;}
  if(key=='s' || key=='S' || keyCode == DOWN){keytopress[3]=false;}
  if(key=='d' || key=='D' || keyCode == RIGHT){keytopress[4]=false;}
  if(key=='l' || key=='L' || key==' '){keytopress[0]=false;}
}

void mouseMoved() {
  //interface preset
   resetB.rollover(mouseX,mouseY);
   pulsarB.rollover(mouseX,mouseY);
   spiraleB.rollover(mouseX,mouseY);
   circleB.rollover(mouseX,mouseY);
   fullB.rollover(mouseX,mouseY);
   waveB.rollover(mouseX,mouseY);
  configB.rollover(mouseX,mouseY);
}

void mousePressed() {
  resetB.clic(mouseX,mouseY);
   pulsarB.clic(mouseX,mouseY);
   spiraleB.clic(mouseX,mouseY);
   circleB.clic(mouseX,mouseY);
   fullB.clic(mouseX,mouseY);
   waveB.clic(mouseX,mouseY);
   configB.clic(mouseX,mouseY);
   
}

void HideCP5(){
  if (display == true) {
    p5.hide();
    display=false;
  }
  else {
    p5.show();
    display=true;
  }
} 


void setGradient(int x, int y, float w, float h, color c1, color c2) {
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
}
