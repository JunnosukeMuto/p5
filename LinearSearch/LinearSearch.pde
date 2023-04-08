//学科（2MI）出席番号（41）名前（武藤淳之助）

void setup() {
  int [] data1={5, 1, 6, 4, 10, 3, 4, 7, 2, 4};
  int [] data2={5, 1, 6, 8, 10, 3, 0, 7, 2, 9};
  int SearchKey = 4;  // 探索キー
  println("data1 SearchKey "+SearchKey);
  search(data1, SearchKey, 0);
  println();
  println("data2 SearchKey "+SearchKey);
  search(data2, SearchKey, 0);
}

void search(int [] a, int SearchKey, int start) {
  int result = -2;
  //startが配列aのインデックス内にあるか，
  //探索が成功している間続ける
  while (result!=-1) {
    //LinearSearch関数を呼び出して，探索
    result = LinearSearch(a, SearchKey, start);
    if (result!=-1) {
      println(result+"番目に発見");
      //次の探索の開始インデックスを更新
      start = result+1;
    } else {
      println("見つかりません");
    }
  }
}

//開始インデクスstart を引数に追加した線形探索
int LinearSearch(int [] a, int SearchKey, int start) {
  //startから探索を始める
  for (int i=start; i<a.length; i++) {
    //a[i]とSearchKeyを比較．
    if (a[i]==SearchKey) {
      //等しければ，iを戻り値として終了
      return i;
    }
  }
  //探索失敗なので-1を戻り値として終了
  return -1;
}
