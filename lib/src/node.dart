/// Author: Karl
/// Date: 2021/11/3 下午5:00
/// Description:
class Node {
  int element;
  Node left;
  Node right;

  void insert(int item) {
    if (element == null) {
      element = item;
      return;
    }
    if (item >= element) {
      var swap = element;
      element = item;
      item = swap;
      if(right == null) {
        right = Node()..element = item;
      } else{
        right.insert(item);
      }
    } else {

    }

  }

  int finMax() {
    if (right != null) right.finMax();
    return element;
  }

  int finMin() {
    if (left != null) left.finMax();
    return element;
  }
}
