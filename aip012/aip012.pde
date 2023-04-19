void setup() {
  size(600, 400);
  noStroke();
}

void draw() {
  background(255, 255, 255);
  fill(188, 0, 45);
  ellipse(300, 200, 240, 240);
}

void keyPressed() {
  if (key == 's') {
    save("3MI37-01-2.PNG");
  }
}