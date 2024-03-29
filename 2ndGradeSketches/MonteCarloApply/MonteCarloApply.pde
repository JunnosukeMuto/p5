//学科（MI）番号（41）氏名（武藤淳之助）

int n=300000;  // 試行回数 
int m=0;       // サイコロの目の合計が40以上になった

// 乱数の種、資料の答えと同じになるようにする仕組み
randomSeed(1234);

for (int i=0; i<n; i++) {         // 30万回試行

  int count = 0;

  for (int j = 0; j < 10; ++j) {  // サイコロを10回振る
    count += int(random(1, 7));   // 1~6までの数がランダムに出る
  }

  if (count >= 40) {              // 出た目の合計が40以上ならm++
    m++;
  }
}
println((float)m/n);  // 確率はm/n
