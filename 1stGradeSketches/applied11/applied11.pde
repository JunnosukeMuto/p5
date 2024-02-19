// 11-応用課題-テンプレート
//　 最大値を赤で塗りつぶし，数値と名前を表示
// 学科番号氏名：MI41武藤淳之助

// setup() とdraw()で使えるよう，
// 関数の外で宣言（グローバル変数）
Table csv;    //csvファイルを読み込むためのTableクラスインスタンス
int [] h;     //1列目のデータを保存するための配列
int max=0;      //最大値

void setup() {
  size(640, 250);
  noLoop();
  textSize(16);

  // csvファイルを読み込む
  csv = loadTable("11-data2.csv");

  // int型配列hを作成
  h=new int[csv.getRowCount()];
  // 数値（int型）として読み込んでh[ ]配列に格納
  for (int i=0; i<h.length; i++) {
    h[i]=csv.getInt(i, 0);
  }
  
  //配列hの要素の最大値を求め，maxに代入
  for (int i = 0; i < h.length; i++) {
    if (h[i]>max) {
      max = h[i];
    }
  }
}

void draw() {
  translate(0, height);
  int w = width/h.length; 
  //棒グラフを描くlen
  for (int i=0; i<h.length; i++) {

    //h[i]が最大値ならば,最大値の値と名前を表示し，棒の色を赤にする
    //そうでなければ棒の色を白にする
    if (h[i]==max) {        
      fill(0);
      text("Value = " + h[i] + "  Name = " + csv.getString(i, 1), 0, -height+20);
      fill(255, 0, 0);
    } else {
      fill(255);
    }

    rect(i*w, 0, w, -h[i]*2);
  }
}
