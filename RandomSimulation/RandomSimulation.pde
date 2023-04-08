//学科（MI）番号（41）氏名（武藤淳之助）

int a=0, b=0, c=0, d=0;
float random;

// 乱数の種、資料の答えと同じになるようにする仕組み
randomSeed(1234);

for(int i=0; i<1000000; i++){
  random = random(1);
  if (random < 0.90) {  // 90%
    a++;
  } else if (random < 0.96) { // 6%
    b++;
  } else if (random < 0.99) { // 3%
    c++;
  } else {  // 1%
    d++;
  }
}
print(a, b, c, d);