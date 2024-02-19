/******************
* 07 基本課題
*
* イベントハンドラ・マウスがクリックされたら
* 右クリックと左クリック
*
* 2MI41 武藤淳之助
*/

int k=0;

void setup() {
  size(200, 200);
  fill(0);
  stroke(0);
}

void draw() {
  if (k==0) {
    fill(0);
  } else {
    fill(255);
  }
  rect(0, 0, width-1, height-1);
}

void mouseClicked() {
  print("[mouse click]" + k);
  //ここから上のプログラムは変更しないこと
  if (mouseButton == LEFT) {
      k = 1;
  } else {
      k = 0;
  }
  //ここから下のプログラムは変更しないこと
  println(" --> " + k + "(" + mouseX + ", " + mouseY + ")");
}