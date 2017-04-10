class Button {
  boolean selected = false; 
  boolean rollover = false;
  float x,y;
  PImage Bimage;

  Button(float Px, float Py,PImage theimage) {
    x = Px;
    y = Py;
    Bimage=theimage;
  }

  void display() {
      image(Bimage,x,y,70,80);
 }

  void rollover(int mx, int my) {
    if (mx > x-35 && mx < x + 35 && my > y-40 && my < y + 40) 
      rollover = true;
    else
      rollover = false;
  }

  void clic(int mx, int my) {
    if (rollover) selected = true;
  }
  
 
}

