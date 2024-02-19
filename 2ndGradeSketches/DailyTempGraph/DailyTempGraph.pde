//学科（2MI）番号（41）氏名（武藤淳之助）

Table csv;  //表を扱うクラス

float [][] temperature = new float [4][31];  // 1月から3月までの毎日の平均気温を入れる配列

// y年m月の日数を返す関数
int days(int y, int m) {
  //月ごとの日数を記録しておく変数。days[0]は使わない
  int days[]={0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  if (y%4==0 && m==2) return 29;  // うるう年の2月だけ例外で29日
  else return days[m];
}

void setup() {
  size(800, 620);
  for (int m=1; m<=3; m++) {  // 1月から3月までのループを構成
    int d=days(2020, m);       // 2020年m月の日数をdに取得する
    csv=loadTable("data-2020"+nf(m, 2)+".csv");  // m月のデータ読み込み

    // これ以下の部分を記述する
    for (int i=0; i<d; i++) {
      float sum = 0;
      float average;
      for (int j=0; j<24; j++) {
        sum += csv.getFloat(i*24+6+j, 1);
      }
      average = sum/24;
      temperature[m][i] = average;
    }
    // ここまでの部分を記述する
  }
}

void draw() {
  for (int m=1; m<=3; m++) {  // 1月から3月までのループを構成
    pushMatrix();
    translate(20, 200*m-10);
    int d=days(2020, m);      // 2020年m月の日数をdに取得する 
    for (int i=0; i<d; i++) {
      fill(255);
      rect(i*24, 0, 24, temperature[m][i]*(-10));
      textAlign(CENTER, BOTTOM);
      fill(0);
      text(nf(temperature[m][i], 1, 1), i*24+12, temperature[m][i]*(-10));
    }
    popMatrix();
  }
}
