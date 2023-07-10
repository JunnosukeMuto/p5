int N=84;  // セルの縦の数
int M=120;  // セルの横の数

int XOrig=10;  // 描画原点
int YOrig=35;  
float mag=5;    // セル１個あたりの大きさ

float [][] src = new float[N+2][M+2];
float [][] dst = new float[N+2][M+2];

void setup() {
  size(640, 480);
  noStroke();
  InitCell(src);  //全セル初期化
  InitCell(dst);
}

void draw() {
  background(0);
  DrawThermoBar();  //温度のカラーバーを表示
  for (int i = 0; i < 5; ++i) {
    step();
  }
  DrawAllCell(src); //全セル描画
  text(nf(frameRate, 2, 1), 400, 15);  // フレームレートを表示

  if (frameCount==300) {
    save("a.PNG");
  }
}

float lambda=0.001;// 温度拡散率λ [m^2/sec]
float dt=1.0/300.0;// Δt[sec]
float dx=0.005;// Δx[m]

void step() {
  for (int i=1; i<=N; i++) {
    //境界条件以外のセル（シミュレーション対象）を更新
    for (int j=1; j<=M; j++) {
      dst[i][j] = src[i][j] + lambda * dt * (src[i-1][j]+src[i][j-1]+src[i+1][j]+src[i][j+1]-4.0*src[i][j])/dx/dx;
    }
  }
  for (int i=1; i<=N; i++) { //データの書き戻し 
    for (int j=1; j<=M; j++) {
      src[i][j] = dst[i][j];
    }
  }
}

//全セルを描画
void DrawAllCell(float [][] data) {
  noStroke();
  //境界条件を描画
  for (int i=1; i<=N; i++) {
    DrawCell(i, 0, data[i][0]);     // 左壁
    DrawCell(i, M+1, data[i][M+1]); // 右壁
  }
  for (int j=1; j<=M; j++) {
    DrawCell(0, j, data[0][j]);     // 上壁
    DrawCell(N+1, j, data[N+1][j]); // 下壁
  }
  // シミュレーション対象のセルを描画
  for (int i=1; i<=N; i++) {
    for (int j=1; j<=M; j++) {
      DrawCell(i, j, data[i][j]);
    }
  }
}

//全セルを初期化
void InitCell(float [][] data) {
  // 境界条件を初期化
  for (int i=1; i<=N; i++) {
    data[i][0]=300.0;     // 左壁
    data[i][M+1]=0.0;     // 右壁
  }
  for (int j=1; j<=M; j++) {
    data[0][j]=0.0;       // 上壁
    data[N+1][j]=0.0;     // 下壁
  }
  // シミュレーション対象のセルを初期化
  for (int i=1; i<=N; i++) {
    for (int j=1; j<=M; j++) {
      data[i][j]=150.0;
    }
  }
}

// 温度のカラーバーを表示
void DrawThermoBar(){
  textAlign(LEFT,TOP);     // 文字描画の左上座標を基準点にする
  for (int x=0; x<=300; x++) {
    color c=Temp2Color(map(x, 0, 300, 0, 1.0));
    stroke(c);
    line(x, 15, x, 25);
    fill(255);
    if(x%50==0) text(str(x), x, 0);
  }
}


// i行j列のセルを温度tempで描画
void DrawCell(int i, int j, float temp) {
  fill(Temp2Color(map(temp, 0, 300, 0, 1))); //写像して色に変換
  PVector v1=TransCoord(new PVector(j, i));  // (x, y)に変換
  rect(v1.x, v1.y, mag, mag);                // 描画
}


// セル番号(j, i)をグラフィックス座標(x, y)に変換
PVector TransCoord(PVector p){
  p.mult(mag);         // i,jが1違うとmag離れる
  p.add(XOrig, YOrig); // XOrig, YOrig に平行移動
  return p;
}


// t値 0..1.0 を色に変換
color Temp2Color(float t) {
  color c;
  int val = int((t % 0.5) / 0.5 * 256.0);
  if (t < 0.0) {
    c=color(0, 255, 255);       // 水色
  } else if (t < 0.5) {
    c=color(val, 255, 255-val); // 水色→黄色
  } else if (t < 1.0) {
    c=color(255, 255-val, 0);   // 黄色→赤
  } else {
    c=color(255, 0, 0);         // 赤
  }
  return c;
}

// マウスで左ドラッグした場所を１０００度で熱する
void mouseDragged() {
  if (mouseButton==LEFT) {         // 左ボタンだったら1000度
    // マウス位置をセル番号(j,i)に変換しv1に代入
    PVector v1=InvTransCoord(new PVector(mouseX, mouseY));
    // 整数に変換し1<=j<=M, 1<=i<=N に制限
    int j=(int)constrain(v1.x, 1, M);
    int i=(int)constrain(v1.y, 1, N);
    src[i][j]=1000.0;
  }
}

// グラフィックス座標(x, y)をセル番号(j, i)に変換
PVector InvTransCoord(PVector p){
  p.sub(XOrig, YOrig);
  p.div(mag);
  return p;
}

// マウスがクリックされたら境界条件を変更
void mouseClicked() {
  if (mouseButton==RIGHT) {
    // マウス位置をセル番号(j,i)に変換しv1に代入
    PVector v1=InvTransCoord(new PVector(mouseX, mouseY));
    float t;
    if (v1.x<=1) {                   // 左
      t=300.0-src[1][0];
      for (int i=1; i<=N; i++) {
        src[i][0]=dst[i][0]=t;
      }
    } else if (v1.x>=M) {            // 右
      t=300.0-src[1][M+1];
      for (int i=1; i<=N; i++) {
        src[i][M+1]=dst[i][M+1]=t;
      }
    } else if (v1.y<=1) {            // 上
      t=300.0-src[0][1];
      for (int j=1; j<=M; j++) {
        src[0][j]=dst[0][j]=t;
      }
    } else if (v1.y>=N) {            // 下
      t=300.0-src[N+1][1];
      for (int j=1; j<=M; j++) {
        src[N+1][j]=dst[N+1][j]=t;
      }
    }
  }
}
