/****************
* IPrg10_ex1
* 課題1(基本) プラス印を描く
* 2MI41 武藤淳之助
*/

void setup() {
  size(640, 480);
  frameRate(5);
}

void draw() {
  float x=random(width);
  float y=random(height);
  float w=random(10,100);
  color c=color(random(256),random(256),random(256));
  drawCross(x, y, w, c);
}

void drawCross(float x, float y, float size, color rgb) {
  stroke(rgb);

  // draw horizonal line
  line(x-size/2, y, x+size/2, y);

  // draw vertical line
  line(x, y-size/2, x, y+size/2);
}
