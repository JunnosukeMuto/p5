//学科（2MI）番号（41）氏名（武藤淳之助）

Table csv;  //表を扱うクラス
float [][] temperature = new float [13][31*24];

// y年m月の日数を返す関数
int days(int y, int m) {
  //月ごとの日数を記録しておく変数。days[0]は使わない
  int days[] = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
  if (y%4==0 && m==2) return 29;  // うるう年の2月だけ例外で29日
  else return days[m];
}

void setup() {
  size(800, 720);
  for (int m=1; m<=12; m++) {  // 1月から12月までのループを構成
    int d = days(2020, m);      // 2020年m月の日数をdに取得する
    csv = loadTable("data-2020" + nf(m, 2) + ".csv");  // m月のデータ読み込み
    for (int i=0; i<d*24; i++) {
      temperature[m][i]=csv.getFloat(6+i, 1);
    }
  }
}

void draw() {
  for (int m=1; m<=12; m++) {  // 1月から12月までのループを構成
    pushMatrix();
    translate(20, 60*m-10 );  // 縦 60 ドットおきに表示する
    scale(1, -1);
    int d = days(2020, m);      // 2020年m月の日数をdに取得する 
    for (int i=0; i<d*24; i++) {
      line(i, 0, i, temperature[m][i]);
    }
    popMatrix();
  }
}
