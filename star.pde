class Star {
float starX,starY,starSize,starColor,starSat,starLum;

 Star(){ 
 starX=random(0,width);
 starY=random(0,height);
 starSize=random(1,3);
 starColor=random(30,60);
 starSat=random(0,10);
 starLum=random(20,100);
   
}



void display(){
  noStroke();
  fill(starColor,starSat,starLum);
  ellipse(starX,starY,starSize,starSize);
}

}
