//学科（MI）番号（41）氏名（武藤淳之助）

// 地球の地面クラスを定義
class Earth {
  float size;  // 地面の縦のサイズ
  
  // コンストラクタ、地面の縦サイズ s を指定する
  Earth(float s) {
    size = s;
  }
  
  // 地球の地面を表示
  void display() {
    noStroke();
    fill(#008000);
    rect(0, height - size, width, size);
  }
}


// 隕石クラスを定義
class Meteor {
  PVector pos, vel;        // 隕石の位置, 速度
  float size;              // 隕石の半径
  char name;               // 隕石の名前
  color col;
  // 隕石コンストラクタ
  Meteor() {
    size = 20;                         // 隕石の半径は20に固定
    pos = new PVector(random(size, width - size), -size);
    vel = new PVector(0, random(0.1, 2)); // 初速度をランダムに決定
    if (random(1) < 0.5) {
      name = (char)random('A', 'Z' + 1);    // 大文字隕石
      col = #ffff00;
    } else {
      name = (char)random('a', 'z' + 1);    // 小文字隕石
      col = #ff8000;
    }
  }
  
  // 隕石の落下
  void fall() {
    pos.add(vel);   // 位置を vel だけ増やす
  }
  
  // 隕石が地球と衝突したかチェック
  boolean collision(Earth e) {
    if (pos.y > height - e.size) return true;
    else return false;
  }
  
  // 隕石を表示
  void display() {
    fill(col);       // 各隕石ごとに指定された色で描画
    circle(pos.x, pos.y, size * 2);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(25);
    text(name, pos.x, pos.y);
  }
}


ArrayList <Meteor> meteors; // 隕石 Meteor を入れておくリスト
Earth earth;              // 地球の地面（位置）を管理する

int status;               // 1:ゲーム中、2:BOOM の状態を表す変数
int subFrameCount;        // 上記 2 の状態の時に次の画面に移るまでの時間を管理

int score;                // 現在のスコア
int miss;                 // 失敗した数


void setup() {
  size(640, 480);
  earth = new Earth(30);    // 地面は下から30ドット分
  
  meteors = new ArrayList<Meteor>();  // リストを初期化して
  status = 1;                // 初期状態はゲーム中の画面
}

// スコアとミスを表示(status=1)
void drawScore() {
  fill(255);
  textSize(30);
  textAlign(LEFT, TOP);
  text("Score: " + score, 0, 0);
  text("Miss: " + miss, 300, 0);
}

// ゲームの状態を表示
void drawStatus() {
  fill(255);
  textSize(15);
  textAlign(LEFT, TOP);
  text("status: " + status, 450, 0);
  text("subFrameCount: " + subFrameCount, 450, 15);
}

// BOOM!表示(status=2)
void drawBoom() {
  textSize(100);
  fill(#ff0000);
  textAlign(CENTER, CENTER);
  text("BOOM!", width / 2, height / 2);
}


void draw() {
  background(0);
  earth.display();            // 地球を表示
  for (int i = 0; i < meteors.size(); i++) {  // リストにある全ての隕石について
    Meteor m = meteors.get(i);  // i番目の隕石を m に取り出す
    if (status ==  1) m.fall();  // ゲーム中なら隕石を落下
    m.display();              // 隕石を表示
    if (m.collision(earth)) { // m が earthと衝突したか
      meteors.remove(i);      // 衝突した隕石をリストから削除
      miss++;                 // 失敗数を増やす
      subFrameCount = 0;        // BOOM表示を60フレーム表示するための前準備
      status = 2;               // BOOM状態へ
    }
  }
  drawScore();                // スコアとミスを表示
  if (status ==  2) {            // BOOM 状態なら
    subFrameCount++;          // BOOMとスコア表示の表示時間を制御
    drawBoom();               // BOOM を表示
    if (subFrameCount >=  60) {   // BOOM を60フレーム表示したら
      status = 1;               // ゲーム中の状態へ
    }
  }
  if (random(1) < 0.01) {       // 100フレームに１回だけ
    meteors.add(new Meteor());// 隕石をリストに追加
  }
  if (meteors.size() < 3) {   // 隕石リストが3未満なら隕石を追加
    meteors.add(new Meteor());
  }
  drawStatus();               // ゲームの状態を表示
}


void keyPressed() {
  for (int i = 0; i < meteors.size(); i++) {  //リストにある全ての隕石について
    Meteor m = meteors.get(i);     // i 番目を取り出す
    if (m.name ==  key) {         // 隕石の名前が押されたキーと等しいなら
      meteors.remove(i);        // 隕石を削除
      score += 10;               // スコア加算
      return;                  // 同じ名前が複数あっても1つしか消さない
    }
  }
}
