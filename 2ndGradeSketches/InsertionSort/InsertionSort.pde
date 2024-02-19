//学科（2MI）番号（41）氏名（武藤淳之助）

void setup() {
  int [] data = new int[100];
  final int max = 1000;

  randomSeed(1);  //乱数パターンの固定
  for (int i=0; i<data.length; i++) {
    data[i]=int(random(max*0.9)+max*0.1);
  }
  printArray(data, 20);
  insertionSort(data);
  printArray(data, 20);
} 

//挿入ソート
void insertionSort(int [] d) {
  int j, tmp;

  for (int i=1; i<d.length; i++) {
    tmp = d[i]; // value to insert

    for (j=i; d[j-1]>tmp; j--) {
      // comparing one by one, find the place to insert
      // at the same time, shift datas forward
      d[j] = d[j-1];
      if (j-1==0) {
        j--;
        break;  // in case of this, d[j] is the smallest
      }
    }

    d[j]= tmp;  // insertion
  }
}

//配列要素の表示
void printArray(int [] a, int n) {
  for (int i=0; i<a.length; i++) {
    print(a[i] + " ");
    if (i%n==n-1) println();
  }
  println();
}
