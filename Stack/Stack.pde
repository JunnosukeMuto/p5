//学科（2MI）番号（41）氏名（武藤淳之助）

int N=20;
color bgColor = color(0);
void setup() {
  size(640, 480);
  frameRate(10);
  noStroke();
  background(bgColor);
}

void draw() {
  if (frameCount==(N+1)) 
    save("ouyou.png");

  if (frameCount%(N+1) == 0) {
    background(bgColor);
  }
  translate(width/2, height/2);
  //青の円を描く
  pushMatrix();
  rotate(frameCount*2*PI/N);
  fill(0, 0, 255);
  translate(50,0);
  ellipse(0,0,15,15);
  popMatrix();
  //赤の円を描く
  pushMatrix();
  rotate(-frameCount*2*PI/N);
  translate(100,0);
  fill(255, 0, 0);
  ellipse(0,0,20,20);
  popMatrix();
  //緑の円を描く
  pushMatrix();
  rotate(frameCount*2*PI/N);
  translate(200,0);
  fill(0, 255, 0);
  ellipse(0,0,40,40);
  popMatrix();
}