// 14-応用課題-テンプレート
// 学科番号氏名：MI41武藤淳之助
// キーボードからの入力によって円の表示順序を変更する

//グローバル変数宣言
int N = 500;  //円の数
int t = 0;    //カウンター，円を描画するごとに1つ増やす
int pivotid, pleft, pright; //基準値，比較の要素番号

CIRCLE [] circles = new CIRCLE[N];  //CIRCLEオブジェクトを保存する配列

//CIRCLEクラスの定義
class CIRCLE {
  float x, y;   //円の中心座標
  float r;      //円の半径
  color c;      //円の色
  float id;     //生成された順番

  //コンストラクタ
  //CIRCLEオブジェクト生成時に，中心座標, 半径, 色をランダムに決定する
  CIRCLE() {
    x = random(width);
    y = random(height);
    r = random(100);
    c = color(random(128, 255), random(128, 255), random(128, 255));
  }
}

void setup() {
  size(640, 480);
  noStroke();
  background(255);

  //配列circlesにN個のCIRCLEオブジェクトを保存
  for (int i=0; i<N; i++) {
    circles[i] = new CIRCLE();
    circles[i].id = (float)i;
  }
}

void draw() {
  //配列に保存されている順に円を表示
  fill(circles[t].c);
  circle(circles[t].x, circles[t].y, circles[t].r);
  //次の円を表示するためにカウンタを1増やす
  t++;

  //配列の最後までを表示したらカウンタを0に戻す
  if (t>=circles.length) {
    background(255);
    t = 0;
  }
}

//クイックソート
//引数の配列dの入れ替えと同時に配列circlesの入れ替えも行う
void quick_sort(float [] d) {
  int ptr;                         //スタックポインタ
  int left=0, right=0;             //整列範囲の左番号，右番号
  int [] leftStack = new int[N];   //左番号用スタック
  int [] rightStack = new int[N];  //右番号用スタック

  //pivot, leftとrightの初期化
  ptr = 0;
  leftStack[ptr] = 0;
  rightStack[ptr]= d.length-1;

  //スタックが空になるまで繰り返す
  ptr++;
  while (ptr-- > 0) {
    pleft= left = leftStack[ptr];
    pright= right = rightStack[ptr];
    pivotid = left;
    float pivot = d[pivotid];

    //***** ここから *****
    //pivotより小さい数を左に，大きい数を右にする
    pleft++;
    while (true) {
      //整列範囲の左から順にpivotより大きい数を探し，右から順にpivotより小さい数を探す
      while (pleft < pright && d[pleft] <= pivot) pleft++;
      while (d[pright] > pivot) pright--;

      //見つかった2つの数の場所が行き違っていたら終了
      if (pleft >= pright) break; 

      //配列dとcirclesのpleft番目の要素とpright番目の要素を入れ替える
      //■■■■■この下に処理を追加する■■■■■
      swap(d, pleft, pright);
      swap(circles, pleft, pright);

      //plefとprightを進める
      pleft++; 
      pright--;
    }
    //ピボットデータを入れ替える
    //配列dとcirclesのleft番目の要素とpright番目の要素を入れ替える
    //■■■■■if文の中に処理を追加する■■■■■
    if (pivot != d[pright]) {
       swap(d, pivotid, pright);
       swap(circles, pivotid, pright);
    }

    //新しい整列範囲を保存する
    if (left < pright-1) {
      leftStack[ptr] = left;
      rightStack[ptr] = pleft-1;
      ptr++;
    }
    if (pright+1 < right ) {
      leftStack[ptr] = pright+1; 
      rightStack[ptr] = right;
      ptr++;
    }
  }
}

//float型配列についてd[a]とd[b]を入れ替える
void swap(float [] d, int a, int b) {
  float tmp;
  tmp=d[a];
  d[a]=d[b];
  d[b]=tmp;
}

//CIRCLE型配列についてd[a]とd[b]を入れ替える
void swap(CIRCLE [] d, int a, int b) {
  CIRCLE tmp;
  tmp=d[a];
  d[a]=d[b];
  d[b]=tmp;
}

//キーを押して，表示順を切り替える
void keyPressed() {
  float data[] = new float[circles.length];    //ソートに使うデータを保存

  //ソートに使うデータを配列dataにコピー
  //■■■■■else if文を追加する■■■■■
  if (key=='x') {
    for (int i=0; i<data.length; i++) {
      data[i] = circles[i].x;
    }
  } else if (key=='y') {
    for (int i=0; i<data.length; i++) {
      data[i] = circles[i].y;
    }
  } else if (key=='r') {
    for (int i=0; i<data.length; i++) {
      data[i] = circles[i].r;
    }
  } else {
    for (int i=0; i<data.length; i++) {
      data[i] = circles[i].id;
    }
  }

  //data配列を使ってソート
  quick_sort(data);
  //画面をクリアして，先頭から表示する
  background(255);
  t=0;
}