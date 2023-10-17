void setup() {
    double h = 0.2;
    double xmin = 0.0;
    //double xmax = 2.0;
    double y0 = 1.0;
    int count = 10;
    PrintWriter output = createWriter("euler_output.csv");
    
    output.println("x,y");
    euler(output, h, count, xmin, y0);
    output.close();
}

void euler(PrintWriter output, double h, int count, double x0, double y0) {
    double x = x0;
    double y = y0;
    for (int i = 0; i <= count; ++i) {
        output.println(x + "," + y);
        println("x=" + x + " y=" + y);
        y = y + deriv_y(x,y) * h;
        x = x + h;
    }
}

double deriv_y(double x, double y) {
    return 2 * y / (1 + x);
}