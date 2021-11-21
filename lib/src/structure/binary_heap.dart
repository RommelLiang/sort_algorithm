/// Author: Karl
/// Date: 2021/11/20 上午11:12
/// Description: 二叉堆

class BinaryHeap {
  List<int> heapList;

  BinaryHeap() {
    heapList = [];
  }

  ///插入操作
  void insert(int num) {
    ///将数据按顺序向后排序
    heapList.add(num);

    ///开始上滤
    percolateUp(num);
  }

  ///插入操作
  void deleteRoot() {
    ///将最后一个节点的元素放入第一个节点，并删除最后一个节点
    heapList[0] = heapList[heapList.length - 1];
    heapList.removeAt(heapList.length - 1);

    ///开始下滤
    percolateDown();
    systemOutList('删除根节点');
  }

  ///上滤
  void percolateUp(int num) {
    ///首先找到最后一位新加入的元素
    ///并不断与其父节点比较。如果大于它的父节点，则将其向上移动
    ///不断将向上交换，直至目标不再大于父节点
    for (var hole = heapList.length - 1;
        heapList[hole].compareTo(heapList[((hole - 1) ~/ 2)]) > 0;
        hole = (hole - 1) ~/ 2) {
      heapList[hole] = heapList[(hole - 1) ~/ 2];
      heapList[(hole - 1) ~/ 2] = num;
    }
  }

  void systemOutList(String val) {
    print('$val:$heapList');
  }

  ///下滤
  void percolateDown({int targetIndex = 0}) {
    ///首先找到根节点，此时里面已经是放置着删除之前的最后一个元素
    ///并不断与其字节点最小的对比，并将其和大于它的元素中最小的交换
    ///不断将向下交换，直至目标不再小于任意子节点
    var heapLength = heapList.length - 1;
    int targetChild;
    for (var hole = targetIndex; 2 * hole + 1 <= heapLength; hole = targetChild) {
      ///找到左子节点，并默认为目标穴位
      targetChild = 2 * hole + 1;
      ///找到最小的子节点，作为目标穴位
      ///如果左子节点小于右子节点，则目标节点为右子节点
      if (targetChild < heapList.length - 1 &&
          heapList[targetChild].compareTo(heapList[targetChild + 1]) < 0) {
        targetChild++;
      }
      if (heapList[targetChild].compareTo(heapList[hole]) > 0) {
        ///如果目标穴位里的值小于其最小的子节点
        ///那么进行下滤，将二者交换；
        var temp = heapList[hole];
        heapList[hole] = heapList[targetChild];
        heapList[targetChild] = temp;
      } else {
        break;
      }
    }
  }

  ///将数组堆化
  void buildHeap(List<int> list){
    heapList = List.from(list);
    ///beginIndex为第一个非叶子节点
    var beginIndex = heapList.length~/2 -1;
    ///用第一个非叶子节点和它的子节点对比
    ///找出左右两个子节点中大于当前节点的数据并与父节点交换
    ///不断的将最大值推到堆的根部。
    ///注意此处，是将当前位置的值进行下滤
    ///相对的，对于较大的值，是一个上滤的过程
    for (var i = beginIndex; i >= 0; i--) {
      percolateDown(targetIndex: i);
    }
  }

  ///原始的堆排序
  List<int> heapSore(){
    var sortList= <int>[];
    ///堆化后的数据
    var rank = heapList.length;
    for(var i = 0;i < rank;i++){
      ///取出跟节点
      sortList.add(heapList[0]);
      deleteRoot();
    }
    print('排序后的数组：$sortList');
    return sortList;
  }
}
