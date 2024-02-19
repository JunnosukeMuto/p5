//学科（MI）番号（41）氏名（武藤淳之助）

boolean areThoseNearlyEquals(final float a, final float b) {
  if (abs(a-b) < abs(a)*1e-6) {
    return true;
  } else {
    return false;
  }
}

float recurrenceRelation(final float d, final float xn) {
  return (2*xn + d/(xn*xn))/3;
}

float solve(final float d, final float x1) {
  final int num_of_repetition = 200;
  float xn = x1;
  float xnplus1;

  for (int i=0; i<num_of_repetition; i++) {
    xnplus1 = recurrenceRelation(d, xn);
    if (areThoseNearlyEquals(xn, xnplus1)) {
      return xnplus1;
    }
    xn = xnplus1;
  }

  println("It doesn't converge.");
  System.exit(0);
  return 9999;
}

void printCubeRoot(int d) {
  println(d + " " + nf(solve(d,d),1,6));
}

void setup() {
  for (int d=1; d<=9; d++) {
    printCubeRoot(d);
  }
}
