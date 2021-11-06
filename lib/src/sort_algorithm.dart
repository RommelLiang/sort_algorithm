import 'dart:math';

import 'package:sort_algorithm/src/node.dart';

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
  for (var i = 0; i < list.length - 1; i++) {
    var hasExchange = false;
    for (var j = list.length - 1; j > i; j--) {
      if (list[j] > list[j - 1]) {
        hasExchange = true;
        swap(list, j, j - 1);
      }
    }
    if (!hasExchange) {
      break;
    }
  }
  return list;
}

///选择排序
List<int> selectionSort(List<int> list) {
  if (list.length < 2) return list;
  for (var i = 0; i < list.length - 1; i++) {
    var maxIndex = i;
    for (var j = i + 1; j < list.length; j++) {
      if (list[j] > list[maxIndex]) {
        maxIndex = j;
      }
    }
    if (i != maxIndex) {
      swap(list, i, maxIndex);
    }
  }
  return list;
}

///插入排序
List<int> insertionSort(List<int> list) {
  if (list.length < 2) return list;
  for (var i = 1; i < list.length; i++) {
    ///如果不满足 list[j] > list[j - 1]，说明无需插叙，没必要继续循环判断
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
  var left = list.sublist(0, list.length ~/ 2);
  var right = list.sublist(list.length ~/ 2);
  return _mergeSortMerge(mergeSort(left), mergeSort(right));
}

List<int> _mergeSortMerge(List<int> left, List<int> right) {
  var merge = List<int>(left.length + right.length);
  var leftIndex = 0;
  var rightIndex = 0;
  var mergeIndex = 0;
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
  var chosenNum = list[Random().nextInt(list.length)];
  var small = <int>[];
  var same = <int>[];
  var large = <int>[];

  for (var i = 0; i < list.length; i++) {
    if (list[i] > chosenNum) {
      large.add(list[i]);
    } else if (list[i] < chosenNum) {
      small.add(list[i]);
    } else {
      same.add(list[i]);
    }
  }
  if (small.isNotEmpty) {
    small = groupSort(small);
  }
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
    _quickPartition(list, low, i);
    _quickPartition(list, i + 2, height);
  }
}
