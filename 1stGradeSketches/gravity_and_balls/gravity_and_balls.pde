float g = 2.1;
float e = 1.0;

int col = 0;

boolean isVertical = true;
boolean isZerogravity = false;
boolean isBallline = false;
boolean isColored = true;

float[][] parameters = {
  {50,200,300,10,-10},
  {40,300,300,5,1},
  {30,100,100,4,-2},
};

int num_of_balls = parameters.length;
Ball[] balls = new Ball[num_of_balls];



class Ball {
  float radius;
  float x;
  float y;
  float vx;
  float vy;
  
  Ball(float[] args) {
    this.radius = args[0];
    this.x = args[1];
    this.y = args[2];
    this.vx = args[3];
    this.vy = args[4];
  }
  
  void display() {
    if(radius == 0) {
      strokeWeight(8);
      point(x,y);
      strokeWeight(1);
    }else{
      if(isColored) {
        fill(rainbow());
        stroke(rainbow());
        // なんてことだ！これではBalllineでないときグローバル変数colが2倍速で増えてしまう！
        // これだからグローバル変数はバグの温床なんだ
      }
      ellipse(x,y,radius*2,radius*2);
    }
  }
  
  void move() {
    x = x+vx;
    y = y+vy;
    
    if(!isZerogravity) {
      if(isVertical) {
        vy = vy+g;
      }
      else {
        vx = vx+g;
      }
    }
  }
  
  void edges() {
    //left edge
    if(vx<0&&x-radius<0) {
      vx = -vx*e+g;
    }
    
    //right edge
    if(vx>0&&x+radius>width) {
      vx = -vx*e+g;
    }
    
    //top edge
    if(vy<0&&y-radius<0) {
      vy = -vy*e+g;
    }
    
    //under edge
    if(vy>0&&y+radius>height) {
      vy = -vy*e+g;
    }
  }
}

void ballFactory() {
  for(int i=0; i<num_of_balls; i++) {
    balls[i] = new Ball(parameters[i]);
  }
}

void allProcesses() {
  for(int i=0; i<num_of_balls; i++) {
    if(!isBallline) {balls[i].display();}
    balls[i].move();
    balls[i].edges();
  }
}

color rainbow() {
  float r, g, b;
  col=col+1;
  int val=col%256;
  col=col%(256*6);
  if(col < 256*1) {
    r=val; g=0; b=255; 
  } else if(col < 256 * 2) {
    r=255; g=0; b=255-val;
  } else if(col < 256 * 3) {
    r=255; g=val; b=0;
  } else if(col < 256 * 4) {
    r=255-val; g=255; b=0;
  } else if(col < 256 * 5) {
    r=0; g=255; b=val;
  } else {
    r=0; g=255-val; b=255;
  }
  return color(r, g, b);
}

void ballline() {
  if(isColored) {
    stroke(rainbow());
  }
  
  for(int i=0; i<num_of_balls-1; i++) {
    line(balls[i].x,balls[i].y,balls[i+1].x,balls[i+1].y);
  }
  line(balls[num_of_balls-1].x,balls[num_of_balls-1].y,balls[0].x,balls[0].y);
}

void keyPressed() {
  if(key=='w') {
    isVertical = true;
    g = -abs(g);
  }
  if(key=='a') {
    isVertical = false;
    g = -abs(g);
  }
  if(key=='s') {
    isVertical = true;
    g = abs(g);
  }
  if(key=='d') {
    isVertical = false;
    g = abs(g);
  }
  if(key=='z') {
    isZerogravity = !isZerogravity;
  }
  if(key=='r') {
    background(0);
    col = 0;
    
    ballFactory();
    if(isBallline) {
      for(int i=0; i<num_of_balls; i++) {
        balls[i].radius = 0;
      }
    }
  }
  if(key=='c') {
    stroke(255);

    isColored = !isColored;
    fill(255);
  }
  if(key=='p') {
    save("a.png");
  }
  if(key=='l') {
    if(!isBallline) {
      isZerogravity = true;
      for(int i=0; i<num_of_balls; i++) {
        balls[i].radius = 0;
      }
    }else{
      isZerogravity = false;
      for(int i=0; i<num_of_balls; i++) {
        balls[i].radius = parameters[i][0];
      }
    }
        
    isBallline = !isBallline;
    background(0);
  }
}



void setup() {
  size(640,480);
  frameRate(30); 
  background(0);
  stroke(255);
  
  ballFactory();
  if(isBallline) {
    //isZerogravity = !isZerogravity;
    for(int i=0; i<num_of_balls; i++) {
      balls[i].radius = 0;
    }
  }
}

void draw() {
  if(isBallline) {ballline();}
  
  if(!isBallline) {background(0);}
  allProcesses();
}