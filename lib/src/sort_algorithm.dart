import 'dart:math';


/// Author: Karl
/// Date: 2021/10/19 下午3:37
/// Description: 基础排序算法

void swap(List<int> list, int a, int b) {
  var temp = list[a];
  list[a] = list[b];
  list[b] = temp;
}

///冒泡排序
List<int> bubbleSort(List<int> list) {
  if (list.length < 2) return list;
  ///遍历数据开始循环
  for (var i = 0; i < list.length - 1; i++) {
    var hasExchange = false;
    ///从最后一个元素开始遍历
    for (var j = list.length - 1; j > i; j--) {
      ///发现位置不对（后面的值大于前面的），交换位置
      if (list[j] > list[j - 1]) {
        hasExchange = true;
        ///交换位置
        swap(list, j, j - 1);
      }
    }
    ///没有发生交换，说明没有顺序错误，直接结束当前循环
    if (!hasExchange) {
      break;
    }
  }
  return list;
}

///选择排序
List<int> selectionSort(List<int> list) {
  if (list.length < 2) return list;
  ///开启循环
  for (var i = 0; i < list.length - 1; i++) {
    var maxIndex = i;
    ///循环寻找最大的元素
    for (var j = i + 1; j < list.length; j++) {
      if (list[j] > list[maxIndex]) {
        maxIndex = j;
      }
    }
    ///讲元素放在序列起始位置
    if (i != maxIndex) {
      ///交换
      swap(list, i, maxIndex);
    }
  }
  return list;
}

List<int> insertionSort(List<int> list) {
  if (list.length < 2) return list;
  for (var i = 1; i < list.length; i++) {
    ///如果不满足 list[j] > list[j - 1]，说明无需插入，没必要继续循环判断
    for (var j = i; j > 0 && list[j] > list[j - 1]; j--) {
      swap(list, j, j - 1);
    }
  }
  return list;
}

///希尔排序（缩减增量插入排序，更高级的插入排序算法）
List<int> shellSort(List<int> list) {
  if (list.length < 2) return list;
  for (var gap = list.length ~/ 2; gap > 0; gap ~/= 2) {
    for (var i = gap; i < list.length; i++) {
      ///其实这里是个插入排序
      for (var j = i; j >= gap && list[j] > list[j - gap]; j -= gap) {
        swap(list, j, j - gap);
      }
    }
  }
  return list;
}

///归并排序
List<int> mergeSort(List<int> list) {
  if (list.length < 2) return list;
  ///分割数字
  var left = list.sublist(0, list.length ~/ 2);
  var right = list.sublist(list.length ~/ 2);
  ///开始递归，并接分割完成后合并数组
  return _mergeSortMerge(mergeSort(left), mergeSort(right));
}

List<int> _mergeSortMerge(List<int> left, List<int> right) {
  var merge = List<int>(left.length + right.length);
  var leftIndex = 0;
  var rightIndex = 0;
  var mergeIndex = 0;
  ///合并数组（此时的数组已是有序的），遍历两个目标数组，取出最大（最小）的放到新数组中
  while (leftIndex < left.length && rightIndex < right.length) {
    if (left[leftIndex] >= right[rightIndex]) {
      merge[mergeIndex++] = left[leftIndex++];
    } else if (left[leftIndex] < right[rightIndex]) {
      merge[mergeIndex++] = right[rightIndex++];
    }
  }
  while (leftIndex < left.length) {
    merge[mergeIndex++] = left[leftIndex++];
  }

  while (rightIndex < right.length) {
    merge[mergeIndex++] = right[rightIndex++];
  }
  return merge;
}

///分组排序（快速排序的基础）
List<int> groupSort(List<int> list) {
  if (list.length < 2) return list;
  ///选取目标值
  var chosenNum = list[Random().nextInt(list.length)];
  ///三个数组，比目标值大的、和目标值相等的和比目标值小的
  var small = <int>[];
  var same = <int>[];
  var large = <int>[];

  ///遍历元素并将元素放入合适的组内
  for (var i = 0; i < list.length; i++) {
    if (list[i] > chosenNum) {
      large.add(list[i]);
    } else if (list[i] < chosenNum) {
      small.add(list[i]);
    } else {
      same.add(list[i]);
    }
  }
  ///继续对小于目标值的元素分组
  if (small.isNotEmpty) {
    small = groupSort(small);
  }
  ///继续对大于目标值的元素分组
  if (large.isNotEmpty) {
    large = groupSort(large);
  }
  return large..addAll(same)..addAll(small);
}

///快速排序
List<int> quickSort(List<int> list) {
  if (list.length < 2) return list;
  _quickPartition(list, 0, list.length - 1);
  return list;
}

///快速记选取目标值
int _pivotIndex(int min, int max) {
  var i = min + Random().nextInt(max - min);
  return i;
}

void _quickPartition(List<int> list, int low, int height) {
  if (low < height) {
    ///随机选取目标值并放在最后
    swap(list, _pivotIndex(low, height), height);
    var pivot = list[height];
    var i = (low - 1);

    ///找到比目标大的值并按发现顺序向前排列
    for (var j = low; j < height; j++) {
      if (list[j] >= pivot) {
        i++;
        swap(list, i, j);
      }
    }

    ///将目标值放在所有比它大的值后面
    var targetPoint = i + 1;
    swap(list, targetPoint, height);

    ///开启下轮循环
    _quickPartition(list, low, i);//比目标值小的元素
    _quickPartition(list, i + 2, height);//比目标值大的元素
  }
}

///堆排序
List<int> heapSort(List<int> list) {
  if (list.length < 2) return list;
  var len = list.length - 1;
  var beginIndex = list.length~/2 - 1;
  ///将数组堆化
  ///beginIndex为第一个非叶子节点，用第一个非叶子节点和它的
  ///子节点对比，找出左右两个子节点中大于当前节点的数据并与父节点交换，不断的
  ///将最大值推到堆的根部。
  ///有点类似于堆的上滤
  for (var i = beginIndex; i >= 0; i--) {
    _maxHeapify(i, len, list);
  }

  ///取出根部最大的值
  ///不断取根节点的值，同时，采用下滤的方法把最后一个节点插入到合适的位置
  ///操作方法类似于堆的删除操作
  for (var i = len; i > 0; i--) {
    swap(list,0, i);
    _maxHeapify(0, i - 1,list);
  }
  return list;
}

void _maxHeapify(int index, int len, List<int> list) {
  var li = 2*index + 1; /// 左子节点索引
  var ri = li + 1; /// 右子节点索引
  var cMin = li; /// 子节点值最小索引，默认左子节点。
  if (li > len) return; /// 左子节点索引超出计算范围，直接返回。
  if (ri <= len && list[ri] < list[li]) {
    cMin = ri;
  }
  if (list[cMin] < list[index]) {/// 如果父节点大于子节点
    swap(list, cMin, index); /// 父节点和最小的子节点调换，
    _maxHeapify(cMin, len, list); /// 继续判断换下后的父节点是否符合堆的特性。
  }
}
