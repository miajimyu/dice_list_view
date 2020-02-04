import 'dart:math';

import 'package:flutter/material.dart';

class Dice {
  Dice({this.number = 1, @required this.faces, this.add = 0});

  final int number;
  final int faces;
  final int add;

  List<int> _results = [];

  String get name {
    var str = '';
    if (add < 0) {
      str = '-$add';
    } else if (add > 0) {
      str = '+$add';
    }

    return '${number}d$faces$str';
  }

  int get result {
    if (_results.isEmpty) {
      return 0;
    }

    return _results.reduce((value, element) => value + element) + add;
  }

  List<int> get resultAll => _results;

  void roll() {
    _results?.clear();
    for (var i = 0; i < number; i++) {
      _results?.add(Random().nextInt(faces) + 1);
    }
  }
}
