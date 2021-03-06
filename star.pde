class Star {
float starX,starY,starSize,starColor,starSat,starLum,starSizeLessbig,starXmin,starYmin,starXmax,starYmax;

 Star(float Xmin,float Ymin,float Xmax,float Ymax){
  starXmin=Xmin;
  starYmin=Ymin;
  starXmax=Xmax;
  starYmax=Ymax;
  
   //create random positions and other values for stars
 starX=random(Xmin,Xmax);
 starY=random(Ymin,Ymax);
 starSize=random(1,3);
 starSizeLessbig=starSize-random(0,2);
 starColor=random(0,100);
 starSat=random(0,20);
 starLum=random(20,100);
   
}


// display stars
void display(){
  noStroke();
  fill(starColor,starSat,starLum);
  ellipse(starX,starY,starSize,starSizeLessbig);
}

// specific for the earth view
void moveandreplace(float dirX){
  //move the point
  starX=starX+dirX;
  //test if the point is out of the screen after move and replace it on the other side the screen
  if(starX<starXmin){
  starX=starXmax+starX-starXmin;
  starY=random(starYmin,starYmax);
  }
  if(starX>starXmax){
  starX=starXmin+starX-starXmax;
  starY=random(starYmin,starYmax);
  }

// finally display the new star
  fill(starColor,starSat,starLum);
  ellipse(starX,starY,starSize,starSizeLessbig);
  
}

}
