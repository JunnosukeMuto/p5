void setup() {
    float GJ_EPS = 0.000001;
    int n = 3;
    float [][] a = {
        {1,2,3,1},
        {2,1,1,2},
        {3,1,1,5}
    };

    for (int i = 0; i < n; ++i) {
        println(a[i][n]);
    }
}

void gauss_jordan(int n, float a[][]) {
    for (int i = 0; i < n; ++i) {
        f = abs(a[i][i]);   // a[0][0], a[1][1], .. ,a[n-1][n-1]
        for (int k = i+1; k < n; ++k) {
            g = abs(a[k][i]);   // i=0: a[1][0], .. ,a[n-1][0]  i=1: a[2][1], .. ,a[n-1][1]  i=n-1: a[n][n-1]
        }
    }
}