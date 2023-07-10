// 下記のプログラムの(1)-(4)を埋めてプログラムを完成させましょう，
class MyRect {
  PVector p1; // 始点の座標
  float w, h; // 横，縦
  // コンストラクタ
  MyRect() {
    p1=new PVector(random(width-200), random(height-200));
    w=random(200); // 幅
    h=random(200); // 高さ
  }

 // 始点・終点間に長方形を描画する
  void display() {
    stroke(0);
    rect(p1.x, p1.y, w, h);
  }
  // マウスと図形中心との最短距離を求める
  float distance(PVector m) {
    PVector p=p1.copy();  // p1の複製をpに作成
    
    p.add(new PVector(w/2,h/2));
    
    stroke(255, 0, 0);             // 求めた最短距離の線を描画
    line(m.x, m.y, p.x, p.y);
    return p.dist(m);
  }
}

ArrayList<MyRect> rects;  //MyRectを入れる配列リストを用意

void setup() {
  size(640, 480);
  rects=new ArrayList<MyRect>();  // リスト生成
  for (int i=0; i<5; i++) {
    rects.add(new MyRect());// ランダム直線を生成し追加
  }
}

void draw() {
  background(255);
  noFill();

  PVector m=new PVector(mouseX, mouseY);

  strokeWeight(1);
  MyRect nearest=rects.get(0); // 最も近い線分を0番目としておく
  float min=10000;
  for (MyRect l : rects){   // lに1つずつ取り出しながら
    l.display();            // 表示
    float d=l.distance(m);  // 距離を求める
    if (d<min) {            // より短いなら
      nearest=l;            // 記録更新
      min=d;
    }
  }

  // 一番近い線を緑で上書き
  strokeWeight(3);
  stroke(0, 255, 0);
  rect(nearest.p1.x, nearest.p1.y ,nearest.w, nearest.h);  
}

void keyPressed() {
  if (key == 's') {
    save("3MI37-12-1.PNG");
  }
}