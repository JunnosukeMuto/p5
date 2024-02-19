//学科（2MI）出席番号（41）名前（武藤淳之助）

Table table;         //読込み用CSVファイル
final int N=3; //データ数
final int max=10000;             //データの最大値
final int times=300;             //ソートの回数
Student [] data;             //データ作成用

//Student クラスの定義
class Student {
  //メンバの宣言
  private int keycode;
  private String name;
  private String dep;

  //コンストラクタ
  Student(int keycode, String name, String dep) {
    this.keycode = keycode;
    this.name = name;
    this.dep = dep;
  }

  public int getKeycode() {
    return this.keycode;
  }

  //メンバの表示
  public void print() {
    println("keycode    " + this.keycode);
    println("name       " + this.name);
    println("department " + this.dep);
    println();
  }
}

void setup() {
  int row;
  //CSVファイルを読み込んで，data配列に格納
  table = loadTable("data.csv");//CSVファイルのオープン
  //データの読込み
  row = table.getRowCount();  //行数の取得
  data = new Student[row];    //データを保存する配列の領域確保
  for (int i=0; i<row; i++) {  //データの読み込み
    data[i] = new Student(table.getInt(i, 0), table.getString(i, 1), table.getString(i, 2));
    //data[i].print();
  }
  //1572, 2000を探索キーとして探索
  search(data, 1572);
  search(data, 2000);
}

//配列と探索キーを引数として二分探索し，結果を表示
void search(Student [] a, int SearchKey) {
  int result = binarySearch(a, SearchKey);
  println("SearchKey ", SearchKey);
  if (result > 0) {
    data[result].print();
  } else {
    println("データは見つかりませんでした");
  }
}

//学生クラス Stduentのオブジェクトが格納されている配列について，
//二分探索をする
int binarySearch(Student [] a, int SearchKey) {
  int mid, lower, upper;
  //探索範囲を配列全体とする
  lower = 0;
  upper = a.length-1;
  //探索範囲がある間続ける
  while (lower<=upper) {
    //中央の位置midを計算する
    mid = (lower+upper)/2;
    //中央のオブジェクトのkeycodeとSearchKeyを比較
    //一致していればmidを返す．
    //そうでなければ新しい探索範囲を設定
    if (a[mid].getKeycode()==SearchKey) {
      return mid;
    } else if (a[mid].getKeycode()>SearchKey) {
      upper = mid-1;
    } else if (a[mid].getKeycode()<SearchKey) {
      lower = mid+1;
    }
  }
  //探索失敗として終了
  return -1;
}
