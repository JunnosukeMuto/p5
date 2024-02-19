//学科（2MI）番号（41）氏名（武藤淳之助）

void setup() {
  int [] data = new int[100];
  final int max = 1000;

  randomSeed(1);  //乱数パターンの固定
  for (int i=0; i<data.length; i++) {
    data[i]=int(random(max*0.9)+max*0.1);
  }
  printArray(data, 20);
  shellSort(data);
  printArray(data, 20);
} 

void shellSort(int [] d) {
  int h, i, j, tmp;

  for (h=1; 3*h+1<d.length/9; h=3*h+1) {}

  for (; h>0; h=(h-1)/3) {
    for (i=h; i<d.length; i++) {
      tmp = d[i]; // value to insert
      // insertion sort
      for (j=i; d[j-h]>tmp; j-=h) {
        d[j] = d[j-h];
        if (j-h-h<0) {
          j-=h;
          break;
        }
      }

      d[j]= tmp;
    }
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
