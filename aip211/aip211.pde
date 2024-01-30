int i, M;
double x, y, s;
int num = 100000;
double r = 1.0;

// モンテカルロ法による円の面積計算
void setup() {
    M = 0;  // 円の中に入った点の数のカウンター

    // 円に外接する正方形領域で乱数x,yを生成
    for (i = 0; i <= num; ++i) {
        x = GetRandom(-r, r);
        y = GetRandom(-r, r);

        if (f(x, y) <= 0) {
            M = M + 1;  // 円周上か円の内側ならカウンターを増やす
        }
    }

    s = Math.pow(2*r, 2) * M/num;
    println("s=" + s);
}

double GetRandom(double min, double max) {
    return min + (max - min) * ((double)random(10000) / 10000);
}

// 0なら円周上、正なら円の外、負なら円の内
double f(double x, double y) {
    return Math.pow(x, 2) + Math.pow(y, 2) - Math.pow(r, 2);
}