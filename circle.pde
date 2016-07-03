void drawBresenCircle(int rad, int cx, int cy, color lineCol) {
  int a = 0, x = 0, y = rad, s = 1 - rad;
  while(x < y) {
    setSymmetry(x, cx, y, cy, lineCol);
    setSymmetry(y, cx, x, cy, lineCol);
    if(s < 0) {
 s += 2 * x + 3;
    } else {
 s = s + 2 * (x - y) + 5;
 y--;
    }
    x++;
  }
  setSymmetry(x, cx, y, cy, lineCol);
}
 
void setSymmetry(int x, int cx, int y, int cy, color lineCol) {
    set(cx+x, cy+y, lineCol);
    set(cx+x, cy-y, lineCol);
    set(cx-x, cy+y, lineCol);
    set(cx-x, cy-y, lineCol);
} 
