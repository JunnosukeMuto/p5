import processing.net.*; 

Client cl;   // クライアント接続を管理するクラスと変数

void setup() { 
  size(400, 200); 
  cl = new Client(this, "127.0.0.1", 5555);  // サーバの5555ポートに接続する
} 

String t=""; // 時刻を保存する文字列
void draw() {
  background(0);
  textSize(20);
  textAlign(CENTER, CENTER);
  if (cl.available()>0) { // クライアントが文字を受信したら
    t=cl.readString();    // 受信した文字をtに保存
  }
  text(t, width/2, height/2);
}
