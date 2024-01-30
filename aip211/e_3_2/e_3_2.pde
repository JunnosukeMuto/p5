int i, M;
double x, y, z, v;
int num = 10000000;
double r = 3.0;

// モンテカルロ法による球の体積計算
void setup() {
    M = 0;  // 球の中に入った点の数のカウンター

    // 球に外接する立方体領域で乱数x,yを生成
    for (i = 0; i <= num; ++i) {
        x = GetRandom(-r, r);
        y = GetRandom(-r, r);
        z = GetRandom(-r, r);

        if (f(x, y, z) <= 0) {
            M = M + 1;  // 球面上か球の内側ならカウンターを増やす
        }
    }

    v = Math.pow(2*r, 3) * M/num;
    println("v=" + v);
}

double GetRandom(double min, double max) {
    return min + (max - min) * ((double)random(10000) / 10000);
}

// 0なら球面上、正なら球の外、負なら球の内
double f(double x, double y, double z) {
    return Math.pow(x, 2) + Math.pow(y, 2) +Math.pow(z, 2) - Math.pow(r, 2);
}