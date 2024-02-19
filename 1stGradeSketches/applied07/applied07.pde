/******************
* 07 応用課題
*
* マウスで描画
* 左ボタンを押ながらマウス軌跡の線を引く
* 右ボタンクリックで画面クリア
* s キーを押したら画像を保存
*
*  * 2MI41 武藤淳之助
*/

void setup() {
  size(640, 480);
  stroke(0);
  strokeWeight(4);
  background(255);
}

void draw() {  // draw()の中を完成させよ
  if (mouseButton == LEFT) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

void keyPressed() {  //keyPressed()の中を完成させよ
  if (key == 's') {
    save("image.png");
  }
}

void mouseClicked() {  //mouseClicked()の中を完成させよ
  if (mouseButton == RIGHT) {
    background(255);
  }
}
