/*********************************
12-2（応用課題：20点）
 **********************************/

// 12-2 応用課題(20点)
// 2MI41 武藤淳之助
void setup() {
  String [] lines;
  int [] table = new int [7]; // 0番目は使わない
  int maxeye=0;  //最大の目
  int max=0;        //出現回数の最大値

  lines=loadStrings("IPrg12-dice.txt");

  // ここでlinesに入っているサイコロの目を数えてください
  // linesは文字列，int(lines[i]) を忘れずに！
  for (int i = 0; i < lines.length; ++i) {
    table[int(lines[i])]++;
  }

  for (int i=1; i<=6; i++) {
    println(i+" : "+table[i]);
    // ここで出現回数の最大値を求めます
    // 最大値を更新する際，最大の目maxeyeも記録
    if (max < table[i]) {
        max = table[i];
        maxeye = i;
    }
  }
  println("最大の目 "+maxeye);
  println("出現回数 "+max);
}
