class LightPoint{
  float poslpX,poslpY;
  float moveangle;
  PVector v2 = new PVector();
  float colorX,colorY;
  color c;
  boolean inscreen = true;
  float colorhue;
  float detectsize;
  float lnumber;
  

 LightPoint(float vX,float vY,float angle,float v1x,float v1y,float lightnumber){ 
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
  //inverse the redshift and set in a 85 scale
 colorhue = (1-colorhue/lightspeed)*85;
  c = color(colorhue,50,50);
  lnumber=lightnumber;
}


void display(){
  //if the point is out of the screen: no calculation and no display
  if(inscreen){
    fill(255,0,0);
    //move the point
    poslpX=poslpX+v2.x;
    poslpY=poslpY+v2.y;
    
    //change the color of the point because of the general relativity redshift
    if(generalredshift){colorhue = colorhue -generalredshiftvalue;}
    if(colorhue>85){colorhue=85;}
    if(colorhue<0){colorhue=0;}

    
    //create the point of light
    fill(colorhue,50,50);
    noStroke();
    ellipse(poslpX,poslpY,lightsize,lightsize);
    //check if the point is out of the screen
    if(poslpX<0-lightsize || poslpX>width+lightsize || poslpY<0-lightsize || poslpY>height+lightsize){inscreen=false;}
  
  
    //if the point is on the hearth, set the received color and angle (only one value by color wave)
    detectsize=max(earthsize,1);
    if(poslpX<(width/2+detectsize) && poslpX>(width/2-detectsize) && poslpY<(height/2+detectsize) && poslpY>(height/2-detectsize) && lnumber!=previouslightnumber){
      colorhuereceived=colorhue;
      anglereceived=moveangle;
      previouslightnumber=lnumber;
    }
  }
}
}


