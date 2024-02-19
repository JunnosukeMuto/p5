/**********************
* IPrg10_ex2
* 課題2(応用) 3種類の図形をマウスクリックで描画する
* 2MI41 武藤淳之助
*/

void setup() {
  size(640, 480);
}

void draw() {
  //描画されたものを繰り返し表示するだけなので，空でOK
}
//以下に必要な行を追加して，プログラムを完成させよ

int n=0;

void mouseClicked() {
  if (n==0) {
    drawStickman(mouseX, mouseY, color(255,0,0));  //棒人間を描く
  } else if (n==1) {
    drawCross(mouseX, mouseY, random(10,100), color(random(256),random(256),random(256)));  //何かを描く(1)
  }
  if (n==2) {
    drawSun(mouseX, mouseY, color(random(256),random(256),random(256)));  //何かを描く(2)
  }
  n++;
  n=n%3;
}

//棒人間を描く関数
void drawStickman(float x, float y, color c) {
  // save style settings and transformations below while pop() restores them
  push();

  // style settings and transformations
  translate(x,y);
  noFill();
  stroke(c);

  // drawing
  circle(0, -20, 10);
  line(0, -15, 0, 5);
  line(0, -10, -10, -5);
  line(0, -10, 10, -5);
  line(0, 5, -10, 25);
  line(0, 5, 10, 25);

  // restore original settings
  pop();
}


void drawCross(float x, float y, float size, color rgb) {
  // save style settings and transformations below while pop() restores them
  push();

  // change stroke's color
  stroke(rgb);

  // draw horizonal line
  line(x-size/2, y, x+size/2, y);

  // draw vertical line
  line(x, y-size/2, x, y+size/2);

  // restore original settings
  pop();
}

void drawSun(float x, float y, color rgb) {
  // save style settings and transformations below while pop() restores them
  push();

  // style settings and transformations
  stroke(rgb);
  translate(x, y);

  // draw central circle
  circle(0, 0, 20);
  
  // draw radial lines
  for (int i = 0; i < 8; i++) {
    line(20, 0, 30, 0);
    rotate(radians(45));
  }

  // restore original settings
  pop();
}
