void setup() {
    noLoop();
}

void draw() {
    String [] names = {"alice", "bob", "alex", "steve", "bill"};
    println(printStrings(reverseStrings(names)));
}

String [] reverseStrings(String [] strs) {
    String [] reversedArray = new String [strs.length];
    for (int i = 0; i < strs.length; ++i) {
        String str = strs[i];
        String reversedStr = "";
        for (int j = 0; j < str.length(); ++j) {
            reversedStr = reversedStr + str.charAt(str.length()-1-j);
        }
        reversedArray[i] = reversedStr;
    }
    return reversedArray;
}

String printStrings(String [] strs) {
    for (int i = 0; i < strs.length; ++i) {
        println(i + ":" + strs[i]);
    }
    return "Success!!!";
}