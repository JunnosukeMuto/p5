void setup() {
    double H = 0.2;
    double Xmin = 0.0;
    double Xmax = 2.0;
    double N = (Xmax - Xmin) / H;
    double x0, x1, y0, y1;
    PrintWriter output = createWriter("euler_output.csv");
    
    x0 = 0;
    y0 = 1;
    
    output.println("x,y");
    
    for (int i = 0; i <= N; ++i) {
        println("x=" + x0 + " y=" + y0);
        
        x1 = x0 + H;
        y1 = y0 + deriv_y(x0, y0) * H;
        
        output.println(x0 + "," + y0);
        
        x0 = x1;
        y0 = y1;
    }
    output.close();
}

double deriv_y(double x, double y) {
    return 2 * y / (1 + x);
}