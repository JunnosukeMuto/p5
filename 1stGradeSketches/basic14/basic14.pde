// 14-基本課題-テンプレート
// 学科番号氏名：MI41武藤淳之助
// 降順（大きい順）にソートするプログラムに変更


//グローバル変数の宣言
int N = 10;             //データ数
int max=100;            //データの最大値
int[] data=new int[N];  //データを保存する配列
int pivotid, pleft, pright; //基準値，比較の要素番号

void setup() {
  //ランダムデータの作成
  randomSeed(1);  //乱数パターンの固定
  for (int i=0; i<data.length; i++) {
    data[i]=int(random(max*0.9)+max*0.1);
  }
  //ソート前のデータ表示
  print("Before                       ");
  printData(data);  

  //ソート
  quick_sort(data);

  //ソート後のデータ表示
  print("After                        ");
  printData(data);
}

//クイックソート(非再帰版)
void quick_sort(int [] d) {
  int ptr;                         //スタックポインタ
  int left=0, right=0;             //整列範囲の左番号，右番号
  int [] leftStack = new int[N];   //左番号用スタック
  int [] rightStack = new int[N];  //右番号用スタック

  //pivot, leftとrightの初期化
  ptr = 0;
  leftStack[ptr] = 0;
  rightStack[ptr]= d.length-1;

  //整列範囲がなくなるまで繰り返す
  ptr++;
  while (ptr-- > 0) {
    pleft= left = leftStack[ptr];
    pright= right = rightStack[ptr];
    pivotid = left;
    int pivot = d[pivotid];

    //pivotより小さい数を左に，大きい数を右にする
    pleft++;
    while (true) {
      //整列範囲の左から順に小さい数を探し，右から順に大きい数を探す
      //■■■■■この下の2行を修正■■■■■
      //while (pleft < pright && d[pleft] <= pivot) pleft++;
      //while (d[pright] > pivot) pright--;
      while (pleft < pright && d[pleft] >= pivot) pleft++;
      while (d[pright] < pivot) pright--;
      
      //見つかった2つの数の場所が行き違っていたら終了
      if (pleft >= pright) break; 
      
      //d[pleft]とd[pright]を入れ替える
      swap(d, pleft, pright);
      print("pivot=" + pivot + " swapData  (" + d[pright] + "," + d[pleft]+")   ");
      printData(d);
      
      //pleftとprightを進める
      pleft++; 
      pright--;
    }
    
    //ピボットデータを入れ替える
    if (pivot != d[pright]) {
      swap(d, pivotid, pright);
      print("pivot=" + pivot + " swappivot (" + d[pright] + "," + d[pivotid]+")   ");
      printData(d);
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

//配列d[a]とd[b]を入れ替える
void swap(int[] d, int a, int b) {
  int t;
  t=d[a];
  d[a]=d[b];
  d[b]=t;
}

//配列dを表示する
void printData(int[] d) {
  for (int i=0; i<d.length; i++) {
    print(d[i]+" ");
  }
  println();
}
