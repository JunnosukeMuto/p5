//学科（MI）番号（41）氏名（武藤淳之助）

int n=30000000;  // 試行回数 
int m=0;         // 表が2回以上出た

// 乱数の種、資料の答えと同じになるようにする仕組み
randomSeed(1234);

for (int i=0; i<n; i++) {         // 3000万回試行

  int count = 0;

  for (int j = 0; j < 4; ++j) {   // コインを4回投げる

    if (random(1) < 0.5) {        // 表が半分の確率で出る
      count++;
    }
  }

  if (count >= 2) {               // 表が4回中2回出たらm++
    m++;
  }
}
println((float)m/n);  // 確率はm/n
