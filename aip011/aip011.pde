// 3MI37 JunnosukeMuto 2023/4/12

void setup() {
  size(600, 480);
  println("Hello Processing!");
}

void draw() {
  stroke(255, 0, 0);
  rect(100, 100, 200, 200);
  stroke(0, 255, 0);
  ellipse(300, 300, 100, 50);
  stroke(0, 0, 255);
  triangle(400, 400, 400, 100, 300, 300);
  stroke(255, 255, 0);
  ellipse(500, 300, 100, 100);
}

void keyPressed() {
  if (key == 's') {
    save("3MI37-01-1.PNG");
  }
}