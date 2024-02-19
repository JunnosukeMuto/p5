//学科（MI）番号（41）氏名（武藤淳之助）
int [] count = new int[10];
final int n = 10;
int m = 7;

// 1万回試行
for (int k=0; k<10000; k++) {
  // 10個から7個を選んでcount[ ]++
  m = 7;
  for (int i = 0; i < n; i++) {
    if (int(random(n-i)) < m) {
      count[i]++;
      m--;
    }
  }
}


// 結果表示
int total=0;
for (int i=0; i<10; i++) {
  total+=count[i];
  println("count["+i+"]="+count[i]);
}
println("total="+total);
