void setup() {
  size(640, 480);
}

void draw() {
  background(0);
  for (int x=0; x<=550; x++) {
    if (x%50==0) text(str(x), x, 15);
    float val=map(x, 0, 550, -0.1, 1.1);
    stroke(Temp2Color5(val));
    line(x, 20, x, 30);
    stroke(Temp2Color7(val));
    line(x, 40, x, 50);
  }
  if(frameCount==1) save("3MI37-05-2.PNG");
}


color Temp2Color5(float t){
  color c;
  t=t+1e-5;
  int val = int((t % (1.0/6.0)) / (1.0/6.0) * 256.0);
  if (t < 0.0) {
    c=color(255, 0, 255);      //　紫
  } else if (t < 1.0/6.0) {
    c=color(255-val, 0, 255);  //　紫→青
  } else if (t < 2.0/6.0) {
    c=color(0, val, 255);      //　青→水色
  } else if (t < 3.0/6.0) {
    c=color(0, 255, 255-val);  //　水色→緑
  } else if (t < 4.0/6.0) {
    c=color(val, 255, 0);      //　緑→黄色
  } else if (t < 5.0/6.0) {
    c=color(255, 255-val, 0);  //　黄色→赤
  } else if (t < 6.0/6.0) {
    c=color(255, val, val);    //　赤→白
  } else {
    c=color(255, 255, 255);    //　白
  }
  return c;
}

color Temp2Color7(float t){
  color c;
  t=t+1e-5;
  int val = int((0.5-0.5*cos(t*6.0*PI)) * 256.0);
  if (t < 0.0) {
    c=color(255, 0, 255);           //　紫
  } else if (t < 1.0/6.0) {
    c=color(255-val, 0, 255);       //　紫→青
  } else if (t < 2.0/6.0) {
    c=color(0, 255-val, 255);       //　青→水色
  } else if (t < 3.0/6.0) {
    c=color(0, 255, 255-val);       //　水色→緑
  } else if (t < 4.0/6.0) {
    c=color(255-val, 255, 0);       //　緑→黄色
  } else if (t < 5.0/6.0) {
    c=color(255, 255-val, 0);       //　黄色→赤
  } else if (t < 6.0/6.0) {
    c=color(255, 255-val, 255-val); //　赤→白
  } else {
    c=color(255, 255, 255);         //　白
  }
  return c;
}
