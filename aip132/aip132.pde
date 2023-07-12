class MyShape {
  // MyShapeはスーパークラスとして使用するので図形の実態はない
  PVector p1;       // 座標
  color lineCol;    // 線の色
  float lineWidth;  // 線幅
  MyShape() {
    p1=new PVector();
    lineCol=color(random(256), random(256), random(256));  // 枠の色
    lineWidth=random(3, 10);      // 太さ
  }
  void display() {  // MyShape s; s.display(); とするために必要
    stroke(lineCol);
    strokeWeight(lineWidth);
    fill(255);
  }
  void showFrame() {
    strokeWeight(1);   // 全てに共通の処理のみ記述
    stroke(255, 0, 0);
    fill(255);
  }
  float distance(PVector m) { // マウス座標との距離を求める
    return p1.dist(m);
  }
  void move(int x, int y) {
    p1.x+=x; 
    p1.y+=y;
  }
  void start(int x, int y) {
    p1.x=x; 
    p1.y=y;
  }
  void end(int x, int y) {
  }
}

class MyLine extends MyShape {  // MyShapeを受け継いだMyLineを作成
  PVector p2; // 終点
  MyLine() {
    super();
    p2=new PVector();
  }
  void display() {
    super.display();
    line(p1.x, p1.y, p2.x, p2.y);
  }
  void showFrame() {
    super.showFrame();
    rectMode(CENTER);
    rect(p1.x, p1.y, 5, 5);
    rect(p2.x, p2.y, 5, 5);
    line(p1.x, p1.y, p2.x, p2.y);
  }
  float distance(PVector m) {
    PVector p=PVector.sub(m, p1);  // マウスと線の始点のベクトル
    PVector v=PVector.sub(p2, p1); // 線分ベクトル
    float len=v.mag();             // 線分a,bの長さを取得
    v.normalize();                 // vの大きさを1にして
    v.mult(constrain(p.dot(v), 0, len)); // pとの内積をとると垂線の根元がわかる
    v.add(p1);                     // スクリーン座標に変換
    return v.dist(m);              // マウスとの最短距離を返す
  }

  void end(int x, int y) {
    p2.x=x; 
    p2.y=y;
  }
  void move(int x, int y) {
    super.move(x, y);
    p2.x+=x;
    p2.y+=y;
  }
}

class MyCircle extends MyShape {  // MyShapeを受け継いだMyCircleを作成
  float radius;  // 半径
  MyCircle() {
    super();
  }
  void display() {
    super.display();
    rectMode(CORNER);
    circle(p1.x, p1.y, radius*2);
  }
  void showFrame() {
    super.showFrame();
    rectMode(CENTER);
    rect(p1.x-radius, p1.y, 5, 5);
    rect(p1.x+radius, p1.y, 5, 5);
    rect(p1.x, p1.y-radius, 5, 5);
    rect(p1.x, p1.y+radius, 5, 5);
    noFill();
    rect(p1.x, p1.y, 2*radius, 2*radius);
  }
  void end(int x, int y) {
    radius=sqrt(sq(p1.x-x)+sq(p1.y-y));
  }
}


class MyRect extends MyShape {  // 長方形（MyShapeを継承）
  float w, h;  // 四角形の幅と高さ

  // 新たに四角形を作成（コンストラクタ）
  MyRect() {
    super();   // MyShapeと同じ処理
  }

  // 図形を表示する
  void display() {
    super.display();    // MyShapeと同じ処理
    rectMode(CORNER);   // 四角形を描画する
    rect(p1.x, p1.y, w, h);
  }

  // 図形の枠を表示する
  void showFrame() {
    super.showFrame();
    rectMode(CENTER);
    rect(p1.x, p1.y, 5, 5);    // 四隅に小さい□を表示
    rect(p1.x, p1.y+h, 5, 5);
    rect(p1.x+w, p1.y, 5, 5);
    rect(p1.x+w, p1.y+h, 5, 5);
    noFill();
    rectMode(CORNER);
    rect(p1.x, p1.y, w, h);    // 枠を重ねて表示
  }

  // 長方形の中央とマウスとの間の距離を求める
  float distance(PVector m) { 
    PVector p = p1.copy().add(new PVector(w/2, h/2));
    
    return p.dist(m);
  }

  // 描画中の図形の座標指定
  void end(int x, int y) {   //図形の終点を設定
    // ★（３）   以下の2行を記述しなさい
    w=x-p1.x;
    h=y-p1.y;
  }
}

import controlP5.*;
ControlP5 cp5;
ButtonBar menu;

int mode=4; // 0:TOP, 1:BOTTOM, 2:MOVE, 3:DELETE, 4:LINE, 5:CIRCLE, 6:RECT, 7:ELLIPSE

ArrayList <MyShape> shapes;  // MyShape型とすると様々な図形を入れることが出来る

void setup() {
  size(1024, 768);

  cp5=new ControlP5(this);
  menu=cp5.addButtonBar("menu")
    .setPosition(0, 0)
    .setSize(400, 40)
    .addItems(split("TOP BOTTOM MOVE DELETE LINE CIRCLE RECT ELLIPSE", " "));
  shapes=new ArrayList <MyShape>();
}

void menu(int m) {
  mode=m;
  println("menu clicked:", m);
}

int min_i;

void draw() {
  background(128);
  //shapes から MyShape型の変数sに1つずつ取り出しながら図形を表示
  for (MyShape s : shapes) {
    s.display();
  }
  // TOP, BOTTOM, MOVE, DELETEの処理中なら
  PVector m=new PVector(mouseX, mouseY);
  float min_dist=10000;
  min_i=0;
  // shapes から MyShape型の変数sに1つずつ取り出しながらハイライト表示
  for (int i=0; i<shapes.size(); i++) {
    MyShape s=shapes.get(i);
    float d=s.distance(m);
    if (d<min_dist) {
      min_dist=d;
      min_i=i;
    }
  }
  if (!shapes.isEmpty()) {
    shapes.get(min_i).showFrame();
  }
}

void mousePressed() {
  MyShape s=null;
  switch(mode) {
  case 0:  // TOP
  case 1:  // BOTTOM
  case 2:  // MOVE
  case 3:  // DELETE
    if (!shapes.isEmpty()) {
      s=shapes.get(min_i);
      shapes.remove(min_i);
      if (mode==0 || mode==2) shapes.add(s); // 最前面に
      else if (mode==1) shapes.add(0, s);    // 最背面に
    }
    break;
  case 4:  // LINE
  case 5:  // CIRCLE
  case 6:  // RECT
  case 7:  // ELLIPSE
    if (mode==4) s=new MyLine();
    else if (mode==5) s=new MyCircle();
    else if (mode==6) s=new MyRect();
    else if (mode==7) s=new MyEllipse();
    shapes.add(s);
    s.start(mouseX, mouseY);
    s.end(mouseX, mouseY);
    break;
  }
}

void mouseDragged() {
  if (!shapes.isEmpty()) {
    MyShape top=shapes.get(shapes.size()-1); // 最前面を取得
    if (mode>=4) { // LINE, CIRCLE, RECT なら
      top.end(mouseX, mouseY);
    } else if (mode==2) {// MOVEなら
      top.move(mouseX-pmouseX, mouseY-pmouseY);
    }
  }
}

class MyEllipse extends MyShape {  // 長方形（MyShapeを継承）
  float w, h;  // 楕円の幅と高さ

  // 新たに楕円を作成（コンストラクタ）
  MyEllipse() {
    super();
  }

  // 図形を表示する
  void display() {
    super.display();
    rectMode(CORNER);
    ellipse(p1.x, p1.y, w, h);
  }

  // 図形の枠を表示する
  void showFrame() {
    // ここはサービスで教えてあげましょう
    super.showFrame();
    rectMode(CENTER);
    rect(p1.x-w/2, p1.y-h/2, 5, 5);    // 四隅に小さい□を表示
    rect(p1.x-w/2, p1.y+h/2, 5, 5);
    rect(p1.x+w/2, p1.y-h/2, 5, 5);
    rect(p1.x+w/2, p1.y+h/2, 5, 5);
    noFill();
    rectMode(CENTER);
    rect(p1.x, p1.y, w, h);    // 枠を重ねて表示
  }

  // 描画中の図形の座標指定
  void end(int x, int y) {   //図形の終点を設定
    w=(x-p1.x)*2;
    h=(y-p1.y)*2;
  }
}