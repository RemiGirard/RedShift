class Light {
  LightPoint[] myLightpoints = new LightPoint[1000+1];
  int number;
  
 Light(int lightnumber){ 
   number=lightnumber;
 }

void lightwave(float coX, float coY,float v1x, float v1y){
float pointangle=0;

 if(!spirale){
   // create light points in every directions
   for(int i=0;i<=lightprecision;i++){
      myLightpoints[i]= new LightPoint(coX,coY,pointangle,v1x,v1y,number);
      pointangle=pointangle+TWO_PI/lightprecision;
    }
 }else{
   // create light points for spirale
     for(int i=0;i<=spiralenumber;i++){
       myLightpoints[i]= new LightPoint(coX,coY,pointangle,v1x,v1y,number);
       pointangle=pointangle+TWO_PI/spiralenumber;
     }
     pointangle=pointangle+(TWO_PI/360)*spiralespeed;
 }
}

//move lightpoints
void display(){
  for(int i=1;i<=lightprecision;i++){
    if(myLightpoints[i] != null){
    myLightpoints[i].display();
    }else{
    println("myLightpoints["+i+"] is null");
  }
  }
}

}
