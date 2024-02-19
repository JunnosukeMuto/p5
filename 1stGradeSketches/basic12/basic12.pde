/*********************************
12-1（基本課題：80点）
 **********************************/

// 12-1 基本課題(20点)
// 2MI41 武藤淳之助
PImage img;

void setup() {
  size(1280, 480);
  img=loadImage("IPrg12-character.png");
}

void draw() {
  image(img, 640, 0);  // 画像を張り付け
  loadPixels();        // pixels[]配列生成

  // ここでpixels[]配列を線形探索します
  //   #0000ff -> #ffaec9 
  //   #fff200 -> #ff7f27
  //   #ed1c24 -> #a349a4
  // に変更してください
  for (int i = 0; i < pixels.length; ++i) {
    if (pixels[i] == #0000ff) {
        pixels[i] = #ffaec9;
    }
    if (pixels[i] == #fff200) {
        pixels[i] = #ff7f27;
    }
    if (pixels[i] == #ed1c24) {
        pixels[i] = #a349a4;
    }
  }

  updatePixels();   // pixels[]を画像に変換
  image(img, 0, 0); // 比較のため原画像を張付け
}
