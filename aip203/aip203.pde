void setup() {
    double H = 0.02;
    double Xmin = 0.0;
    double Xmax = 2.0;
    long N = Math.round((Xmax - Xmin) / H);
    double x0, x1, y0, y1;
    PrintWriter output = createWriter("runge_kutta_output.csv");
    
    x0 = 0;
    y0 = 1;
    
    output.println("x,y");
    
    for (int i = 0; i <= N; ++i) {
        println("x=" + x0 + " y=" + y0);
        
        x1 = x0 + H;
        double k1 = deriv_y(x0, y0);
        double k2 = deriv_y(x0 + H / 2, y0 + k1 * H / 2);
        double k3 = deriv_y(x0 + H / 2, y0 + k2 * H / 2);
        double k4 = deriv_y(x0 + H, y0 + k3 * H);
        y1 = y0 + (k1 + 2 * k2 + 2 * k3 + k4) / 6 * H;
        
        output.println(x0 + "," + y0);
        
        x0 = x1;
        y0 = y1;
    }
    output.close();
}

double deriv_y(double x, double y) {
    return 2 * y / (1 + x);
}