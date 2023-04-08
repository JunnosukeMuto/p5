public class Meteor {
  private static float v = 1.0;
  private float x;
  private float y;
  private color col;
  private char name;

  Meteor(x, y, col, name) {
    this.x = x;
    this.y    = y;
    this.col  = col;
    this.name = name;
  }
  
  public void update() {
    this.y += this.v;
  }
}

void setup() {
  size(640, 480);
  Meteor m1 = new Meteor(300, 0, #ffff00, a);
}

void draw() {
  background(24, 24, 24);
  m1.update();
}
