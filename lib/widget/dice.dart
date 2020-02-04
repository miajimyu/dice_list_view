import 'dart:math';

import 'package:flutter/material.dart';

class Dice {
  Dice({this.number = 1, @required this.faces});

  final int number;
  final int faces;
  int _result;
  List<int> _results = [];

  String get name => '${number}d$faces';
  int get result => _result;
  List<int> get resultAll => _results;

  int roll() {
    int sum = 0;
    _results?.clear();
    for (var i = 0; i < number; i++) {
      var result = Random().nextInt(faces) + 1;
      sum += result;
      _results?.add(result);
    }
    _result = sum;

    return _result;
  }
}
