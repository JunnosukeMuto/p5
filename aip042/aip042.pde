//////////////////////////////////////////////////////////
//
// 基本課題3-1
//
// 世界時計
//
//////////////////////////////////////////////////////////

int oldsec;     //1フレーム前の秒を覚えておく
int sepFrame;   // 区切りとなるフレーム
int subFrame;   // 1sごとに0からスタートするフレーム
Themes currentTheme = Themes.LIGHT;

public enum Themes {
  LIGHT(#e2e8f0, #f1f5f9, #0f172a),
  DARK(#0f172a, #1e293b, #f1f5f9);

  public final color bg1;
  public final color bg2;
  public final color fg;

  private Themes(color bg1, color bg2, color fg) {
    this.bg1 = bg1;
    this.bg2 = bg2;
    this.fg = fg;
  }
}

void setup() {
  size(640, 480);
  // Orig, mag はdrawClock()で直接指定するのでここでは省略
}

void draw() {
  background(currentTheme.bg1);  // 背景をグレーにする

  int h, m, s;     // 時分秒を取得する
  h=hour();
  m=minute();
  s=second();

  // 1フレーム前の秒と異なったら区切りフレーム
  if(s!=oldsec) sepFrame=frameCount;

  // 1フレーム前の秒を記録
  oldsec=s;

  // サブフレームを代入
  subFrame=frameCount-sepFrame;

  drawClock(height*0.45, new PVector(width/2, height/2), h, m, s);  // 日本時間

  // デジタル表示
  fill(currentTheme.fg);
  textSize(30);
  text(nf(h,2)+":"+nf(m,2)+":"+nf(s,2), 10, height-10);

  if(s%10==5 && subFrame==20) save("a.PNG");
}

// 大きさmag, 中央位置Origの時計を描画
void drawClock(float mag, PVector Orig, float h, float m, float s) {
  pushMatrix();    // translate()の効果をpopMatrix()までの範囲とする
  translate(Orig.x, Orig.y);     // ウィンドウの中央を原点とする
  stroke(currentTheme.fg);

  push();
  fill(currentTheme.bg2);
  strokeWeight(2);
  circle(0, 0, mag*2);           // 時計枠の描画
  pop();
  for (int deg=0; deg<360; deg=deg+6) {  // 文字盤の目盛りを描画
    if (deg%30 == 0) {
      strokeWeight(3);
    } else {
      strokeWeight(1);
    }
    drawLine(deg, mag*0.95, mag);        // mag*0.95からmagまで描画
  }
  strokeWeight(15);
  point(0, 0);
  strokeWeight(5);
  drawLine(h*30.0+m*0.5, -0.1*mag, mag*0.6);   // 時針描画
  strokeWeight(3);
  drawLine(m*6.0+s*0.1, -0.1*mag, mag*0.8);    // 分針描画
  strokeWeight(1);
  drawLine(s*6.0+subFrame*0.1, -0.1*mag, mag*0.9);    // 秒針描画
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
  if (key == 'l') {
    currentTheme = Themes.LIGHT;
  } else if (key == 'd') {
    currentTheme = Themes.DARK;
  }
}