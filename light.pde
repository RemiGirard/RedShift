class Light {
  int lightpointsmax = 1000*(255+1);
  LightPoint[] myLightpoints = new LightPoint[lightpointsmax];
  int number;
 Light(int lightnumber){ 
  number=lightnumber;
  
 
}

void lightwave(float coX, float coY,float v1x, float v1y){


 
 if(spirale){
   for(int i=0;i<=spiralenumber;i++){
   int y = number*1000+1;
   println(i);
 myLightpoints[y]= new LightPoint(coX,coY,spiralepointamgle,v1x,v1y);
 spiralepointamgle=spiralepointamgle+TWO_PI/spiralenumber;
   }
   spiralepointamgle=spiralepointamgle+(TWO_PI/360)*spiralespeed;
 }else{
    for(int i=0;i<=lightprecision;i++){
    int y = number*1000+i;
      myLightpoints[y]= new LightPoint(coX,coY,pointangle,v1x,v1y);
      pointangle=pointangle+TWO_PI/lightprecision;
    }
 }
}


void display(){
  for(int i=1;i<=lightprecision;i++){
     int y = number*1000+i;
    if(myLightpoints[y] != null){
    myLightpoints[y].display();
    }else{
    //println("myLightpoints["+y+"] is null");
  }
  }
}

}
