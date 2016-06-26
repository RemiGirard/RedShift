class Star {
float starX,starY,starSize,starColor,starSat,starLum;

 Star(){ 
 starX=random(0,width);
 starY=random(0,height);
 starSize=random(1,3);
 starColor=random(1,100);
 starSat=random(0,30);
 starLum=random(20,100);
   
}



void display(){
  fill(starColor,starSat,starLum);
  ellipse(starX,starY,starSize,starSize);
}

}
