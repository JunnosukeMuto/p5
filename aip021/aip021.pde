//////////////////////////////////////////////////////////
//
// 時計描画プログラム（座標変換版）
//
//////////////////////////////////////////////////////////

float mag;           // 時計の大きさ（直径）を格納する変数
float XOrig, YOrig;  // 時計原点座標（画面中央）を格納。

void setup() {
  size(640, 480);
  mag=height*0.45;    //時計の直径をウィンドウ高さの0.9倍とする
  XOrig=width/2;     // 時計の原点をウィンドウの中央に設定する
  YOrig=height/2;
}

void draw() {
  background(192);  // 背景をグレーにする

  int h, m, s;    // 時分秒を取得する
  h=hour();
  m=minute();
  s=second();

  float rad;        // ラジアン角を計算するための変数
  float px, py, px1, py1, px2, py2;     // 針の先端座標を格納する変数

  // 時計枠の描画
  circle(XOrig, YOrig, mag*2);
  // 目盛りの描画
  for (int deg=0; deg<360; deg+=6) {
    rad=deg/180.0*PI;            // [deg]->[rad]変換
    px1=XOrig + mag * 0.95 * cos(rad);
    py1=YOrig + mag * 0.95 * sin(rad);
    px2=XOrig + mag * cos(rad);
    py2=YOrig + mag * sin(rad);
    line(px1, py1, px2, py2);
  }  

  // 時針を描画。h=1で30度回転。長さは時計直径の0.3倍
  rad = (h*30.0 + m/2.0)/180*PI;    // [deg]→[rad]変換。sin(),cos()がラジアン角のみ
  px = XOrig + mag * 0.6 * sin(rad);  // 極座標変換
  py = YOrig - mag * 0.6 * cos(rad);
  line(XOrig, YOrig, px, py);

  // 分針を描画。m=1で6度回転。長さは時計直径の0.4倍
  rad = (m*6.0 + s/10.0)/180*PI;
  px = XOrig + mag*0.8 * sin(rad);
  py = YOrig - mag*0.8 * cos(rad);
  line(XOrig, YOrig, px, py);

  // 秒針を描画。s=1で6度回転。長さは時計直径の0.45倍
  rad = s*6.0/180*PI;
  px = XOrig + mag*0.9 * sin(rad);
  py = YOrig - mag*0.9 * cos(rad);
  line(XOrig, YOrig, px, py);

  // デジタル表示
  textSize(30);
  text(nf(h,2)+":"+nf(m,2)+":"+nf(s,2), 0, height);
}

void keyPressed() {
  if (key == 's') {
    save("3MI37-02-1.PNG");
  }
}