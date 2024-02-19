/*******************
 * IPrg13_ex1 (基本)
 * bubble sort
 * 2MI41 武藤淳之助
 */

void setup() {
  noLoop();
}

void draw() {
  // create data to sort
  float[] data=new float[10];
  randomSeed(1);
  for (int i=0; i<data.length; i++)
    data[i]=int(random(1.0)*100)/10.0;
  
  printData(data);
  bubble_sort(data);
  printData(data);
}

void bubble_sort(float[] data) {
  // outside loop
  // When the loop turned once, the most right data must be the biggest data.
  // Twice the loop turned twice, the second right data must be the second biggest data.
  // When the loop turned the data's length minus 1 times, the second left data must be the second smallest data.
  // Then, the most left data most be the smallest data. so, you only need to turn the loop the data's length minus 1 times.
  for (int i=0; i<data.length-1; i++) {
    //printData(data);
    boolean is_never_swapped_in_a_loop=true;
    // inside loop
    // Compares data[j] and data[j+1] and swaps if data[j] is smaller.
    // So, you only need to swap the data's length minus 1 times at first.
    // After that, i data was already swapped. so you have to exclude them.
    for (int j = 0; j < data.length-1-i; j++) {
      if (data[j] < data[j+1]) {
        swap(data, j, j+1);
        is_never_swapped_in_a_loop = false;
      }
    }
    
    if (is_never_swapped_in_a_loop)
      // If the data was never swapped in a loop, it's already sorted.
      return;
  }
}

void swap(float[] data, int m, int n) {
  float tmp = data[m];
  data[m]=data[n];
  data[n]=tmp;
}

void printData(float[] data) {
  for (int i=0; i<data.length; i++)
    print(" "+data[i]);
  println();
}