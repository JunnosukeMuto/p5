void setup() {
  size(640, 480);
}

void draw() {
  background(0);
  for (int x=0; x<=550; x++) {
    color c=Temp2Color6(map(x, 0, 550, -0.1, 1.1));
    stroke(c);
    line(x, 20, x, 30);
    if (x%50==0) text(str(x), x, 15);
  }
  if(frameCount==1) save("3MI37-05-1.PNG");
}

color Temp2Color6(float t){
  color c;
  int val = int((t % 0.25) / 0.25 * 256.0);
  if (t < 0.0) {
    c=color(255, 0, 255);
  } else if (t < 1.0/4.0) {
    c=color(255-val, 0, 255);
  } else if (t < 2.0/4.0) {
    c=color(val, val, 255-val);
  } else if (t < 3.0/4.0) {
    c=color(255, 255-val, 0);
  } else if (t < 4.0/4.0) {
    c=color(255, val, val);
  } else {
    c=color(255, 255, 255);
  }
  return c;
}