class Light {
  int lightpointsmax = 1000*(lightnumbermax+1);
  LightPoint[] myLightpoints = new LightPoint[lightpointsmax];
  int number;
 Light(int lightnumber){ 
  number=lightnumber;
  
}

void lightwave(float coX, float coY,float v1x, float v1y){

  for(int i=0;i<360;i++){
  int y = number*1000+i;

    myLightpoints[y]= new LightPoint(coX,coY,i,v1x,v1y);

  }
}


void display(){
  for(int i=1;i<360;i++){
     int y = number*1000+i;
    if(myLightpoints[y] != null){
    myLightpoints[y].display();
    }else{println("myLightpoints["+y+"] is null");}
  }
}

}
