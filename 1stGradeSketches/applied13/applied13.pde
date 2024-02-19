/*******************
 * IPrg13_ex2 (応用)
 * csv data
 * 2MI41 武藤淳之助
 */

void setup() {
  Table csv;
  int[] num;
  String[] name;
  float[] h;
  int row, col;
  csv=loadTable("IPrg13_ex2_data.csv");
  row=csv.getRowCount();
  num=new int[row];
  name=new String[row];
  h=new float[row];
  
  for(int i=0; i<row; i++) {
    num[i]=csv.getInt(i,0);
    name[i]=csv.getString(i,1);
    h[i]=csv.getFloat(i,2);
  }
  
  println("***** load data *****");
  printData(num,name,h);
  bubble_sort(num,name,h);
  println("***** sorted data *****");
  printData(num,name,h);
}

/******
 * float[] d の小さい順に並べる
 */
void bubble_sort(int[] num, String[] str, float[] data) {
  // outside loop
  // When the loop turned once, the most right data must be the biggest data.
  // Twice the loop turned twice, the second right data must be the second biggest data.
  // When the loop turned the data's length minus 1 times, the second left data must be the second smallest data.
  // Then, the most left data most be the smallest data. so, you only need to turn the loop the data's length minus 1 times.
  for (int i=0; i<data.length-1; i++) {
    //printData(num, str, data);
    boolean is_never_swapped_in_a_loop=true;
    // inside loop
    // Compares data[j] and data[j+1] and swaps if data[j] is bigger.
    // So, you only need to swap the data's length minus 1 times at first.
    // After that, i data was already swapped. so you have to exclude them.
    for (int j = 0; j < data.length-1-i; j++) {
      if (data[j] > data[j+1]) {
        swap(num, str, data, j, j+1);
        is_never_swapped_in_a_loop = false;
      }
    }
    
    if (is_never_swapped_in_a_loop)
      // If the data was never swapped in a loop, it's already sorted.
      return;
  }
}

/******
 * n[i],s[i],d[i]とn[j],s[j],d[j]をそれぞれ入れ替える
 */
void swap(int[] num, String[] str, float[] data, int m, int n) {
  int tmp1 = num[m];
  num[m]=num[n];
  num[n]=tmp1;

  String tmp2 = str[m];
  str[m]=str[n];
  str[n]=tmp2;

  float tmp3 = data[m];
  data[m]=data[n];
  data[n]=tmp3;
}

void printData(int[] num, String[] str, float[] data) {
  for(int i=0; i<num.length; i++) {
    print(num[i]+"\t"+str[i]+"\t");
    if(str[i].length()<8)
      print("\t");
    println(data[i]);
  }
}
