void setup() {
    double k = 50;
    double m = 10;
    double omg = Math.pow(k / m, 0.5);
    double tmin = 0;
    double tmax = 20;
    double h = 0.1;
    double t0 = 0;  // time
    double y10 = 0; // position
    double y20 = 1; // velocity
    double y11, y21, y1t;
    double K1, K2, K3, K4, L1, L2, L3, L4;
    PrintWriter output = createWriter("output.csv");
    long N = Math.round((tmax - tmin) / h);
    
    output.println("t0, y0, y1t");
    
    for (int i = 0; i < N; ++i) {
        K1 = deriv_y1(k,m,t0,y10,y20);
        L1 = deriv_y2(k,m,t0,y10,y20);
        K2 = deriv_y1(k,m,t0 + h / 2,y10 + K1 * h / 2,y20 + L1 * h / 2);
        L2 = deriv_y2(k,m,t0 + h / 2,y10 + K1 * h / 2,y20 + L1 * h / 2);
        K3 = deriv_y1(k,m,t0 + h / 2,y10 + K2 * h / 2,y20 + L2 * h / 2);
        L3 = deriv_y2(k,m,t0 + h / 2,y10 + K2 * h / 2,y20 + L2 * h / 2);
        K4 = deriv_y1(k,m,t0 + h,y10 + K3 * h,y20 + L3 * h);
        L4 = deriv_y2(k,m,t0 + h,y10 + K3 * h,y20 + L3 * h);
        
        y11 = y10 + h * (K1 + 2 * K2 + 2 * K3 + K4) / 6;
        y21 = y20 + h * (L1 + 2 * L2 + 2 * L3 + L4) / 6;
        y1t = Math.sin(omg * t0) / omg; // y1t: actual answer
        
        println("t0=" + t0 + " y0=" + y10 + "y1t=" + y1t);
        output.println(t0 + "," + y10 + "," + y1t);
        
        t0 = t0 + h;
        y10 = y11;
        y20 = y21;
    }
    output.close();
}

double deriv_y1(double k, double m, double t, double y1, double y2) {
    return y2;
}

double deriv_y2(double k, double m, double t, double y1, double y2) {
    return - (k / m) * y1;
}