float GJ_EPS = 0.000001;
int N = 3;
float[][] a = new float[N][N+1];

// 逆行列を求めるプログラム
void setup() {
    int i, j, k;
    float[][] x = new float[N][N];
    float a0[][] = {
        { 3, 1, -1 },
        { 1, 2, 1 },
        { -1, 1, 3 },
    };

    for (k = 0; k <= N-1; ++k) {

        // aにa0をコピー
        for (i = 0; i <= N-1; ++i) {
            for (j = 0; j <= N-1; ++j) {
                a[i][j] = a0[i][j];
            }
        }

        // aのN列目（拡大係数行列の1列多い部分）を、単位行列のk列目にする
        for (i = 0; i <= N-1; ++i) {
            if (i == k) {
                a[i][N] = 1;
            } else {
                a[i][N] = 0;
            }
        }

        // ガウス・ヨルダン法を適用すると、aのN列目がaの逆行列のk列目になっている
        gauss_jordan(N, a);

        // 結果をxに保存
        for (i = 0; i <= N-1; ++i) {
            x[i][k] = a[i][N];
        }
    }

    // 結果の出力
    for (i = 0; i <= N-1; ++i) {
        for (j = 0; j <= N-1; ++j) {
            if (j != N-1) {
                print(x[i][j] + ",");
            } else {
                println(x[i][j]);
            }
        }
    }
}

// 連立一次方程式を解くプログラム
// 1. a[0][0]が、0列目の中で最大になるように行を入れ替える（ゼロ除算防止）
// 2. 0行目をa[0][0]で割って、a[0][0]を1にする（規格化）
// 3. 0行目の式を使って、他の行の式の0列目を全て0にする
// 4. a[n-1][n-1]までそれを繰り返す
// 5. n列目に解が表れている
void gauss_jordan(int n, float a[][]) {
    int i, j, k, mr;
    float f, g, dummy;

    for (i = 0; i <= n-1; ++i) {

        // fに列の最大値を格納し、mrに最大値の行のインデックスを格納する
        f = abs(a[i][i]);
        mr = i;
        for (k = i+1; k <= n-1; ++k) {
            g = abs(a[k][i]);
            if (f < g) {
                f = g;
                mr = k;
            }
        }

        // 列の最大値が0でないか確認
        if (f < GJ_EPS) {
            println("*** CONV. ERROR in gauss_jordan ***");
            return;
        }

        // i行目とmr行目を入れ替える
        for (j = 0; j <= n; ++j) {
            dummy = a[mr][j];
            a[mr][j] = a[i][j];
            a[i][j] = dummy;
        }

        // i行目をa[i][i]で割って、a[i][i]を1にする
        for (j = i+1; j <= n; ++j) {
            a[i][j] = a[i][j]/a[i][i];
        }

        // i行目の式を使って、ほかの式のi列目を全て0にする
        for (k = 0; k <= n-1; ++k) {
            if (k != i) {
                for (j = i+1; j <= n; ++j) {
                    a[k][j] = a[k][j] - a[k][i] * a[i][j];
                }
            }
        }
    }
}
