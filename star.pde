class Star {
float starX,starY,starSize;
 Star(){ 
 starX=random(0,width);
 starY=random(0,height);
 starSize=random(1,5);
}



void display(){
  fill(255);
  ellipse(starX,starY,starSize,starSize);
}

}
