int N=42;  // セルの縦の数
int M=60;  // セルの横の数

int XOrig=10;    // 描画原点
int YOrig=35;  
float mag=10;    // セル１個あたりの大きさ

void setup() {
  size(640, 480);
  InitCell(src);  //全セル初期化
}

float [][] src = new float[N+2][M+2];

void draw() {
  background(0);
  DrawThermoBar();  //温度のカラーバーを表示
  DrawAllCell(src); //全セル描画
  if(frameCount==1) save("3MI37-06-1.PNG");
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
    data[i][0]=0.0;     // 左壁
    data[i][M+1]=300.0;     // 右壁
  }
  for (int j=1; j<=M; j++) {
    data[0][j]=300.0;       // 上壁
    data[N+1][j]=0.0;     // 下壁
  }
  // シミュレーション対象のセルを初期化
  for (int i=1; i<=N; i++) {
    for (int j=1; j<=M; j++) {
      if (i<=N/2) {
        data[i][j]=100.0;
      } else {
        data[i][j]=200.0;
      }
      if (j<=M/2) {
        data[i][j]+=50.0;
      }
    }
  }
}

// 温度のカラーバーを表示
void DrawThermoBar(){
  textAlign(LEFT,TOP);
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
  t=t+1e-5;
  int val = int((0.5-0.5*cos(t*6.0*PI)) * 256.0);
  if (t < 0.0) {
    c=color(255, 0, 255);           //　紫
  } else if (t < 1.0/6.0) {
    c=color(255-val, 0, 255);       //　紫→青
  } else if (t < 2.0/6.0) {
    c=color(0, 255-val, 255);       //　青→水色
  } else if (t < 3.0/6.0) {
    c=color(0, 255, 255-val);       //　水色→緑
  } else if (t < 4.0/6.0) {
    c=color(255-val, 255, 0);       //　緑→黄色
  } else if (t < 5.0/6.0) {
    c=color(255, 255-val, 0);       //　黄色→赤
  } else if (t < 6.0/6.0) {
    c=color(255, 255-val, 255-val); //　赤→白
  } else {
    c=color(255, 255, 255);         //　白
  }
  return c;
}