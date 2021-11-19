import 'dart:isolate';
import 'dart:math';

import 'package:sort_algorithm/src/sort_algorithm.dart';

/// Author: Karl
/// Date: 2021/10/19 下午3:37
/// Description: 基础排序算法

const constOriginalList = [ 8,7, 4, 6, 2, 7, 33, 5, 22];

typedef SortFunction = List<int> Function(List<int> list);

void main() {
  var rng = Random();
  var originalList = List<int>(99999);
  for (var i = 0; i < originalList.length; i++) {
    originalList[i] = rng.nextInt(999999);
  }


  Isolate.spawn(execution, MethodMessage('冒泡排序', bubbleSort, List.of(originalList)));
  Isolate.spawn(execution, MethodMessage('选择排序', selectionSort, List.of(originalList)));
  Isolate.spawn(execution, MethodMessage('插入排序', insertionSort, List.of(originalList)));
  Isolate.spawn(execution, MethodMessage('希尔排序', shellSort, List.of(originalList)));
  Isolate.spawn(execution, MethodMessage('归并排序', mergeSort, List.of(originalList)));
  Isolate.spawn(execution, MethodMessage('分组排序', groupSort, List.of(originalList)));
  Isolate.spawn(execution, MethodMessage('快速排序', quickSort, List.of(originalList)));
  Isolate.spawn(execution, MethodMessage('堆排序', heapSort, List.of(originalList)));
  while (true) {}
}

void execution(MethodMessage message) {
  var startTime = DateTime.now().millisecondsSinceEpoch;
  var list = message.function(List.of(message.target));
  var result;
  if (list.length > 10) {
    var left = list.sublist(0, 5).toString();
    var right = list.sublist(list.length - 5, list.length).toString();
    result = '${left.replaceAll("]", "...")}${right.replaceAll("[", "...")}';
  } else {
    result = '$list';
  }
  print(
      '${message.methodName}耗时: ${DateTime.now().millisecondsSinceEpoch - startTime}ms 结果:$result ');
}

class MethodMessage {
  String methodName;
  SortFunction function;
  List<int> target;

  MethodMessage(this.methodName, this.function, this.target);
}
