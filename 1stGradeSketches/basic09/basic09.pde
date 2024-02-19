/*******************************
課題9-1　IPrg09-1（基本）　ひな形
*******************************/

//  09-1 基本課題(80点)
// 2MI41 武藤淳之助
String [] lines;
PrintWriter file;

void setup() {
  lines = loadStrings("IPrg09-data1.txt");
  file = createWriter("IPrg09-data2.csv");
  for (int i=1; i<=lines.length; i++) {
    file.print(lines[i-1]);
    if (i%5==0) {  // 5回に1回だけ改行
      file.println();
    } else {
      file.print(',');
    }
  }
  file.close();
}