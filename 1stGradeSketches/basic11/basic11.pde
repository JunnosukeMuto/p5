// 11-基本課題-テンプレート
//　 グラフと平均を示す赤線を表示
// 学科番号氏名：MI41武藤淳之助

// setup() とdraw()で使えるよう，
// 関数の外で宣言（グローバル変数）
String [ ] lines; //テキストを1行ずつ格納する文字列配列
int [ ] h;     // lines[ ]を数値に変換して格納
int sum = 0;  //合計
float avg = 0;  //平均

void setup(){
  size(640, 250);
  noLoop();
  // 45行の String データをlines[ ]配列に保存
  lines=loadStrings("11-data1.txt");

  // 45個のint配列を作成
  h=new int[ lines.length ];
  // 数値（int型）に変換しh[ ]配列に格納
  for(int i=0; i<h.length; i++){
    h[i]=int(lines[i]);
  }
  // 配列h[]の合計を求める
  for (int i = 0; i < h.length; i++) {
    sum += h[i];
  }

  // 配列h[]の平均を求める
  avg = float(sum) / float(h.length);

}

void draw(){
  // 左上に合計と平均を表示する
  fill(0);
  textSize(16);
  text("Sum = " + sum + "  Average = " + avg, 0,20);
  
  // 棒グラフを描く
  fill(255);
  translate(0, height);
  scale(1, -1);
  int w = width/h.length;  
  for(int i=0; i<h.length; i++){
    rect(i*w, 0, w, h[i]);
  }
  
  // 平均を示す赤線を描画する
  strokeWeight(3);
  stroke(255,0,0);
  line(0, height-avg, width, height-avg);
}
