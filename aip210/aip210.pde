float h = 1;
float xmin = 0;
float xmax = 2;
int i, inum;
float x, s, stheo;

// 台形公式で面積を求める
void setup() {
    // 厳密解
    stheo = pow(xmax,3)/3 + 3*xmax -(pow(xmin,3)+3*xmin);

    // 数値積分
    inum = int((xmax-xmin)/h);
    x = xmin;
    s = 0;

    for(i = 1; i <= inum; i++) {
        s = s + h/2 * (f(x) + f(x+h));
        x = x + h;
    }

    println("stheo=" + stheo);
    println("s=" + s);
}

// 積分する関数
float f(float x) {
    return pow(x, 2) + 3;
}