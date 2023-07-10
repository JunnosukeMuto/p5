import processing.net.*;

Server sv;     // サーバ接続を管理するクラスと変数
int clickCount;

void setup() {
  size(400, 200);
  sv = new Server(this, 5555);  // サーバを起動，5555ポートで待ち受け
  frameRate(5);                 // 1秒間に5回送信すればいいかな
}

void draw()
{
  String time=nf(hour(), 2)+":"+nf(minute(), 2)+":"+nf(second(), 2);
  //println(time);
  sv.write("count="+clickCount+" {"+mouseX+","+mouseY+"} "+time);            // 外部に時刻を送信し続ける
}

void mouseClicked() {
  clickCount++;
}
