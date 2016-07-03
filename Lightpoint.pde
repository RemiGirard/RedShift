class LightPoint{
  float poslpX,poslpY;
  float moveangle;
  PVector v2 = new PVector();
  float colorX,colorY;
  color c;
  boolean inscreen = true;
  float colorhue;
  float detectsize;
  

 LightPoint(float vX,float vY,float angle,float v1x,float v1y){ 
  poslpX=vX;
  poslpY=vY;
  moveangle=angle;
  //set the movement of the point of light
  v2.x=cos(angle)*lightspeed;
  v2.y=sin(angle)*lightspeed;
  //calulate the color depending on lightspeed and the speed of the object
  colorX=(v2.x-v1x)/2;
  colorY=(v2.y-v1y)/2;
  colorhue = dist(colorX,colorY,0,0);
  //inverse the redshift and set in a 100 scale
 // colorhue=map(colorhue,0,70,0,lightspeed);
 colorhue = (1-colorhue/lightspeed)*85;
  c = color(colorhue,50,50);
}


void display(){
  //if the point is out of the screen: no calculation
  if(inscreen){
    fill(255,0,0);
    //move the point
    poslpX=poslpX+v2.x;
    poslpY=poslpY+v2.y;
    //create the point
    
    if(generalredshift=true){colorhue = colorhue -generalredshiftvalue;}
    if(colorhue>85){colorhue=85;}
    if(colorhue<0){colorhue=0;}
    c = color(colorhue,50,50);
    fill(c);
    noStroke();
    ellipse(poslpX,poslpY,lightsize,lightsize);
    //test if the point is out of the screen
    if(poslpX<0 || poslpX>width || poslpY<0 || poslpY>height){inscreen=false;}
  }
  //if the point is on the hearth, get the color
  detectsize=max(earthsize,1);
  if(poslpX<(width/2+detectsize) && poslpX>(width/2-detectsize) && poslpY<(height/2+detectsize) && poslpY>(height/2-detectsize)){ colorreceived=c;colorhuereceived=colorhue;anglereceived=moveangle;}
  
}
}


