import processing.net.*; 
Client cl;   // クライアント接続を管理するクラスと変数

import controlP5.*;
ControlP5 reloadButton;  // ボタンクラスを使用

import java.util.Date;              // 日付クラス
import java.text.SimpleDateFormat;  // 日付の書式フォーマットを扱うクラス

int [] x;    // x軸，y軸のデータを入れる配列
float [] y1;
float [] y2;
float [] y3;

int graphN=120;           // サーバから取得するデータ数
int m=60;                 // m分おきに取得
int nlx=5;                // ラベル個数

boolean drawable=false;   // グラフを読み込まで描画しないフラグ
// reloadPressed()とdraw()で使用

String acct="3mi37";     // 各自のアカウント，パスワードに変更
String pass="ff6ewm";

void setup() {
  size(640, 480);

  // 温度サーバの 8080 ポートに接続する
  x = new int[graphN];  // graphN件のデータを格納する配列を用意
  y1 = new float[graphN];
  y2 = new float[graphN];
  y3 = new float[graphN];

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

// サーバからメッセージ受信するまでtrueにならない
// 処理が先に進まないようにするギミック
boolean recvOK;            // waitAndRecv()とclientEvent()で利用

// サーバから600件のデータを受信したらtrueになるフラグ
boolean drawOK=false;      // draw()とreloadPressed()で使用

// 認証が成功したらtrueになるフラグ
boolean authOK;            // reloadPressed()と clientEvent()で使用

// 以下は clientEvent()とreloadPressed()で使用
int dbN;              // infoで取得したデータベースの全レコード数
int rcvEpoch;              // getで取得したEpoch時間
float rcvTemperature;      // getで取得した温度
float rcvHumid;
float rcvPress;

// リロードボタンが押されたら
void reloadPressed() {
  authOK=false;            // まだ認証していなのでfalseにしておく

  // サーバに8080ポートで接続
  cl = new Client(this, "202.251.32.28", 8080);
  if (!cl.active()) return;// 接続できなければ終了
  // 認証情報を送信
  sendAndRecv("user "+acct+" "+pass);  // 認証情報を送信し応答を待つ
  if (!authOK || !recvOK) { // 認証失敗または応答なしなら強制終了
    cl.stop();
    return;
  }
  // サーバのレコード件数を問い合わせ
  sendAndRecv("info"); // infoを送信し応答を待つ
  for (int i=0; i<graphN; i++) {
    //600件のデータを取得するためのコマンドを発行
    int recNo=(dbN-1+(i+1-graphN)*m);
    sendAndRecv("get "+recNo);  //getを送信
    x[i]=rcvEpoch;         // 1レコード取得するたび 配列x[],y[]に保存
    y1[i]=rcvTemperature;
    y2[i]=rcvHumid;
    y3[i]=rcvPress;
  }
  sendAndRecv("quit");     // quitを送信し応答を待つ（最大1[ms]×1000回）
  cl.stop();
  drawOK=true;             // データを読み込んだのでdraw()でグラフを描画する
}

// サーバにメッセージを送信して応答を待つ
// reloadPressed()から使用される
void sendAndRecv(String mes) {
  // d[msec]置きにチェックしながら n回待つ
  // n回待ってパケットが返らなければエラーとして処理
  int d=1, n=1000;
  recvOK=false;            // フラグを未受信にしておき
  cl.write(mes+char(10));  // サーバにコマンドを送信
  for (int i=0; i<n; i++) { 
    delay(d);              // しばらく待って
    if (recvOK) return;    // サーバからパケットが返ってないかチェック
    //print(i);            //このコメントを外すと待ち時間が可視化できる
  }
  println("Timeout("+d*n+"[ms])"); // n回待って返ってこなければエラー
}

// サーバからのメッセージを受信
// メッセージの先頭文字を見て処理を分けるアプリケーションプロトコルを実装
void clientEvent(Client cl) {
  // サーバからの返事（文字列）を読み込む
  String rmes=cl.readStringUntil(char(10)).trim();
  //println(rmes);
  String [] str=rmes.split(" ");    // 空白を区切り文字として文字列に分解
  if (str[0].equals("hello")) {
    // 先頭が hello なら認証成功
    authOK=true;
    println(rmes);
  } else if (str[0].equals("L")) {
    // 先頭が L なら24×2個の数値データが入っている
    for (int i=0; i<24; i++) {
      x[i]=int(str[i*2+1]);     // float型に変換してx[], y[]に格納
      y1[i]=float(str[i*2+2]);
    }
  } else if (str[0].equals("I")) {
    // 先頭が I ならデータ件数，日付，時刻，Epoch，日付，時刻，Epoch
    dbN=int(str[1]);
    println(rmes);
  } else if (str[0].equals("G")) {
    // 先頭が G なら日付，時刻，Epoch，温度1，湿度1，温度2，湿度2，気圧2
    rcvEpoch=int(str[3]);     // Epochと温度1をreloadPressed()関数に返却
    rcvTemperature=float(str[4]);
    rcvHumid=float(str[5]);
    rcvPress=float(str[8]);
    print(".");
  } else if (str[0].equals("bye")) {
    // 先頭が bye なら quit成功
    println(char(10)+rmes);
  } else {
    println(rmes);   // 上記に当てはまらないメッセージ（エラー）を表示
  }
  // サーバから来たメッセージ処理が終わったことを waitTimer()に知らせる
  recvOK=true;
}


void draw() {
  background(0);
  textAlign(CENTER, TOP);
  textSize(32);
  text("Client", width/2, 0);

  // 配列x[], y[] を使用してデータを描画
  if (drawOK) {
    MyDrawGraph(x, y1, x[0], 0, x[graphN-1], 40, 40, 140, 600, 40, graphN/nlx, 0, 40, 10);
    MyDrawGraph(x, y2, x[0], 20, x[graphN-1], 80, 40, 300, 600, 160, graphN/nlx, 20, 80, 20);
    MyDrawGraph(x, y3, x[0], 960, x[graphN-1], 1050, 40, 440, 600, 320, graphN/nlx, 960, 1040, 20);
  }
}


//  X区間[rx1,rx2], Y区間[ry1,ry2]のグラフを
// (sx1,sy1)-(sx2, sy2) のスクリーンに描画
void MyDrawGraph(int [] xdata, float [] ydata, 
  float rx1, float ry1, float rx2, float ry2, // 元の座標
  float sx1, float sy1, float sx2, float sy2, // スクリーン座標
  int lx, // x軸ラベルの間隔（何レコードおきか指定）
  int ly1, int ly2, int ldy  // y軸ラベルの始点，終点，増分
  ) {
  float x0, y0, x1, y1;
  // 温度軸（Y軸）目盛り
  strokeWeight(1);  // 線の太さ，色，端点を決定
  stroke(#008000);  // mosgreen
  strokeCap(SQUARE);
  textSize(16);
  textAlign(RIGHT, CENTER);
  for (int ly=ly1; ly<=ly2; ly+=ldy) {
    y1=map(ly, ry1, ry2, sy1, sy2);
    line(sx1, y1, sx2, y1);
    text(ly, sx1, y1);
  }

  // 時間軸（X軸）目盛り
  textAlign(CENTER, TOP);
  for (int i=0; i<graphN; i++) {
    x0 = map(xdata[i], rx1, rx2, sx1, sx2);  // 線の始点を計算
    y0 = sy1; //map(0, ry1, ry2, sy1, sy2);
    if (i%lx==lx-1) {
      text(getDateString(xdata[i], "d hh:mm"), x0, y0);
      line(x0, sy1, x0, sy2);
    }
  }
  //棒グラフ描画
  float width = 2;
  strokeWeight(width);
  stroke(#0000ff); // blue
  strokeCap(SQUARE);
  float ox=0, oy=0;
  for (int i = 0; i < graphN; i++) {
    x1 = map(xdata[i], rx1, rx2, sx1, sx2);  // 線の終点を計算
    y1 = map(ydata[i], ry1, ry2, sy1, sy2);
    if (i!=0) {line(ox, oy, x1, y1);}
    ox=x1; oy=y1;
  }
  // XY軸描画
  strokeWeight(3);
  stroke(#00ff00);  // green
  strokeCap(ROUND);
  line(sx1, sy1, sx2, sy1); // X座標の描画
  line(sx1, sy1, sx1, sy2); // Y座標の描画
}


String getDateString(long epoch, String fmt) {
  SimpleDateFormat sdf = new SimpleDateFormat(fmt);
  return sdf.format(new Date(epoch*1000));
}

void keyPressed() {
  if (key == 's') {
    save("3MI37-11-1.PNG");
  }
}