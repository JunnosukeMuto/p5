//学科（2MI）番号（41）氏名（武藤淳之助）

ArrayList<Integer> queue; //キュー
int ballWidth = 50;       //円の大きさ
int n = 0;                //整数を追加する順番

//要素の表示
void displayElement(int index) {
  int x = (index+1)*ballWidth;
  int y = 70;
  fill(190);
  ellipse(x, y, ballWidth, ballWidth);
  fill(0);
  text(queue.get(index), x-5, y+5);
}

void setup() {
  size(600, 120);
  stroke(0);
  textSize(16);
  //スタックの領域確保
  queue = new ArrayList<Integer>();

  //最初の要素の追加
  queue.add(n);
  n++;
}

void draw() {
  background(255);
  text("Size : " + queue.size(), 20, 20 );

  //リストの順に表示
  for (int i=0; i<queue.size(); i++) {
    //要素の表示
    displayElement(i);
  }
}

//queue
void myqueue(Integer element) {
  queue.add(element);
}

//dequeue
Integer mydequeue() {
  Integer tmp;
  if (queue.size()<=0) {
    return -1;
  }
  tmp = queue.get(0);
  queue.remove(0);
  return tmp;
}

void mousePressed() {
  //左クリックでqueue
  //右クリックでdequeue
  if (mouseButton == LEFT) {
    myqueue(n);
    n++;
  } else if (mouseButton == RIGHT) {
    mydequeue();
  }
}
