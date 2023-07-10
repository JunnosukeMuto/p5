String [] lines;  // 行を読み込む文字列配列

int [] x;    // x軸，y軸のデータを入れる配列
float [] y;

void setup() {
  size(640, 480);
  lines=loadStrings("graph-data.txt"); // ファイルから読み込み

  x = new int[lines.length];  // ファイルの行数と同数のx[], y[]を用意
  y = new float[lines.length];

  for (int i=0; i<lines.length; i++) {   // 読み込んだ行数分だけ
    String [] s=split(lines[i], " ");  // 空白で分割してs[]に格納
    x[i]=int(s[0]);       // 文字列をfloat型に変換して代入
    y[i]=float(s[1]);
  }
}

void draw() {
  background(0);
  // xは1から10の範囲だが，軸表示を考え0から11とする．1～10と比較せよ
  MyDrawGraph(x, y, 0, 0, 21, 200, 40, 440, 600, 240, 0, 200, 20);
  MyDrawGraph(x, y, 0, 0, 21, 200, 40, 200, 200, 40, 0, 100, 20);
  MyDrawGraph(x, y, 0, 0, 21, 200, 240, 200, 600, 40, 0, 200, 50);

  if (frameCount==1) {
    save("3MI37-09-2.PNG");
  }
}

//  X区間[rx1,rx2], Y区間[ry1,ry2]のグラフを
// (sx1,sy1)-(sx2, sy2) のスクリーンに描画
void MyDrawGraph(int [] xdata, float [] ydata, 
  float rx1, float ry1, float rx2, float ry2, // 元の座標
  float sx1, float sy1, float sx2, float sy2,   // スクリーン座標
  int ly1, int ly2, int ldy  // y軸ラベルの始点，終点，増分
  ) {
  float x0, y0, x1, y1;

  // 温度軸（Y軸）目盛り
  strokeWeight(1);  // 目盛り線の太さ，色，端点を決定
  stroke(#008000);  // mosgreen
  strokeCap(SQUARE);
  textSize(16);
  textAlign(RIGHT, CENTER);  // ラベル位置を設定
  for(int ly=ly1; ly<=ly2; ly+=ldy){
    y1=map(ly, ry1, ry2, sy1, sy2);
    line(sx1, y1, sx2, y1);
    text(ly, sx1, y1);
  }

  //棒グラフ描画
  int n = x.length;     // データ数
  float width = abs(sx2 - sx1) / n * 0.7; //線幅を計算;
  strokeWeight(width);
  stroke(#0000ff); // blue
  strokeCap(SQUARE);
  for (int i = 0; i < n; i++) {
    x0 = map(xdata[i], rx1, rx2, sx1, sx2);  // 線の始点を計算
    y0 = map(       0, ry1, ry2, sy1, sy2);
    x1 = map(xdata[i], rx1, rx2, sx1, sx2);  // 線の終点を計算
    y1 = map(ydata[i], ry1, ry2, sy1, sy2);
    line(x0, y0, x1, y1);
  }
  strokeWeight(3);
  stroke(#00ff00);  // green
  strokeCap(ROUND);
  line(sx1, sy1, sx2, sy1); // X座標の描画
  line(sx1, sy1, sx1, sy2); // Y座標の描画
}

