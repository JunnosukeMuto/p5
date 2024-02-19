/*******************************
課題9-2　（応用課題：20点）　ひな形
*******************************/

// 09-2 応用課題(20点)
// 2MI41 武藤淳之助
Table csv;
void setup() {
  size(800, 200);
  csv= loadTable("IPrg09-word.csv");
  PFont font=createFont("M PLUS 1", 40, true);
  textFont(font);  //40ドットの漢字フォントを作成
  textSize(40);
  frameRate(1);  //1秒ごとに切り替える
}

int r=0;  //表示する単語の番号（乱数）を格納
          //1回目のみ0番の単語から始める
void draw() {
  background(255);
  fill(0);
  text(csv.getString(r,0), 30, 70); // 単語表示
  if ( frameCount%2==0 ) {       //2回目だったら
    text(csv.getString(r,1), 30, 170);//意味も表示
    // 意味を表示したら次の単語を選ぶ
    r=int(random(csv.getRowCount()));
  }
}
