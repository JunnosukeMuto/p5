void setup(){
  size(640, 480);
}

void draw(){
  background(255);
  stroke(0);
  
  translate(width/2,height/2);
  PVector m=new PVector(mouseX-width/2, mouseY-height/2);  //マウス
  PVector c=new PVector(0, 0); //画面中央

  PVector left=m.copy().mult(0.8).rotate(radians(10));  // 矢の先端（左部分）
  PVector right=m.copy().mult(0.8).rotate(radians(-10));  // 矢の先端（右部分）

  line(c.x, c.y, m.x, m.y);
  line(m.x, m.y, left.x, left.y);
  line(m.x, m.y, right.x, right.y);

}

void keyPressed() {
  if (key == 's') {
    save("a.PNG");
  }
}