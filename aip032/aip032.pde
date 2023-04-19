//////////////////////////////////////////////////////////
//
// 基本課題3-1
//
// 世界時計
//
//////////////////////////////////////////////////////////

void setup() {
  size(640, 480);
  // Orig, mag はdrawClock()で直接指定するのでここでは省略
}

void draw() {
  background(192);  // 背景をグレーにする

  int h, m, s;     // 時分秒を取得する
  h=hour();
  m=minute();
  s=second();

  drawDial(height*0.45, new PVector(width/2, height/2));  // 日本時間
  drawDial(height*0.15, new PVector(width/2-100, height/2-75));  // 世界協定時UTC (-9時間）
  drawDial(height*0.1, new PVector(width/2+100, height/2-75));  // ワシントン（-13時間）

  drawHand(height*0.45, new PVector(width/2, height/2), h, m, s);  // 日本時間
  drawHand(height*0.15, new PVector(width/2-100, height/2-75), h-9, m, s);  // 世界協定時UTC (-9時間）
  drawHand(height*0.1, new PVector(width/2+100, height/2-75), h-13, m, s);  // ワシントン（-13時間）

  textSize(30);
  text(nf(h,2)+":"+nf(m,2)+":"+nf(s,2), 0, height);
}

// 大きさmag, 中央位置Origの時計を描画
void drawDial(float mag, PVector Orig) {
  pushMatrix();    // translate()の効果をpopMatrix()までの範囲とする
  translate(Orig.x, Orig.y);     // ウィンドウの中央を原点とする
  circle(0, 0, mag*2);           // 時計枠の描画

  for (int deg=0; deg<360; deg=deg+6) {  // 文字盤の目盛りを描画
    drawLine(deg, mag*0.95, mag);        // mag*0.95からmagまで描画
  }

  popMatrix();     // translate()の効果を取り消す
}

void drawHand(float mag, PVector Orig, float h, float m, float s) {
  pushMatrix();    // translate()の効果をpopMatrix()までの範囲とする
  translate(Orig.x, Orig.y);     // ウィンドウの中央を原点とする

  drawLine(h*30.0, -0.1*mag, mag*0.6);   // 時針描画
  drawLine(m*6.0, -0.1*mag, mag*0.8);    // 分針描画
  drawLine(s*6.0, -0.1*mag, mag*0.9);    // 秒針描画
  popMatrix();     // translate()の効果を取り消す
}


// 時計方向にdeg度だけ回転させ，len1からlen2の位置に線分を描画
void drawLine(float deg, float len1, float len2) {
  PVector vec1, vec2;
  vec1=new PVector(0, -len1);  // 始点
  vec1.rotate(radians(deg));
  vec2=new PVector(0, -len2);  // 終点
  vec2.rotate(radians(deg));
  line(vec1.x, vec1.y, vec2.x, vec2.y);
}

void keyPressed() {
  if (key == 's') {
    save("3MI37-03-2.PNG");
  }
}