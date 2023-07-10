//////////////////////////////////////////////////////////
//
// 温度クライアントプログラミング
//
//////////////////////////////////////////////////////////

import processing.net.*; 
Client cl;   // クライアント接続を管理するクラスと変数

import controlP5.*;
ControlP5 reloadButton;  // ボタンクラスを使用

int [] x;    // x軸，y軸のデータを入れる配列
float [] y;

void setup() {
  size(640, 480);

  // 温度サーバの 8080 ポートに接続する
  cl = new Client(this, "202.251.32.28", 8080);

  x = new int[24];  // 24時間分のデータを格納する配列
  y = new float[24];

  // リロードボタンを作成する
  reloadButton = new ControlP5(this);
  reloadButton
    .addButton("reloadPressed")  // ボタン押下時に実行する関数名
    .setLabel("RELOAD")          // 表示ラベル
    .setSize(80, 25)             // ボタンのサイズ
    .setPosition(width-85, 5)    // ボタンの表示場所
    .setColorForeground(color(#c0c0c0)) // マウスで指した時の色
    .setColorBackground(color(#808080)) // マウスが外れた時の色
    ;
}


// リロードボタンが押されたら
void reloadPressed() {
  // サーバにメッセージ+改行を送信
  cl.write("latest"+char(10));
}

// サーバからのメッセージを受信
String rmes="";
void clientEvent(Client cl) {
  // サーバからの返事（文字列）を読み込む
  rmes=cl.readStringUntil(char(10)).trim();
  println(rmes);
  String [] str=rmes.split(" ");    // 空白を区切り文字として文字列に分解
  // 最初の文字が L なら24×2個の数値データが入っているはず
  if (str[0].equals("L")) {
    for (int i=0; i<24; i++) {
      println(str[i*2+1], str[i*2+2]); // 中身の確認
      x[i]=int(str[i*2+1]);     // float型に変換してx[], y[]に格納
      y[i]=float(str[i*2+2]);
    }
  } else exit();  // 最初の文字がLでなかったら通信エラーなので強制終了
}

void draw() {
  background(0);
  textAlign(CENTER, TOP);
  textSize(32);
  text("Client", width/2, 0);
  
  // 配列x[], y[] を使用してデータを描画
  // X軸の表示を考え前後1時間(3600秒)余分に取る
  MyDrawGraph(x, y, x[0]-3600, 0, x[23]+3600, 40, 40, 440, 600, 40, 0, 40, 5);
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

  // 時間軸（X軸）目盛り
  textAlign(CENTER, TOP);
  for (int i=0; i<24; i++){
    x0 = map(xdata[i], rx1, rx2, sx1, sx2);
    y0 = map(0, ry1, ry2, sy1, sy2);
    if (i%4==3) {
      text(getDateString(xdata[i], "hh:mm"), x0, y0);
      line(x0, sy1, x0, sy2);
    }
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

import java.util.Date;              // 日付クラス
import java.text.SimpleDateFormat;  // 日付の書式クラス

String getDateString(long epoch, String fmt) {
  SimpleDateFormat sdf = new SimpleDateFormat(fmt);
  return sdf.format(new Date(epoch*1000));
}

void keyPressed() {
  if (key == 's') {
    save("3MI37-10-2.PNG");
  }
}