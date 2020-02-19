import 'dart:math';

import 'package:flutter/material.dart';

class Dice {
  Dice({
    this.number = 1,
    @required this.faces,
    this.add = 0,
  });

  final int number;
  final int faces;
  final int add;

  final List<int> _results = [];

  String get name {
    var str = '';
    if (add < 0) {
      str = '$add';
    } else if (add > 0) {
      str = '+$add';
    }

    return _buildDiceName(
      numberStr: number.toString(),
      facesStr: faces.toString(),
      addStr: str,
    );
  }

  String get fullName {
    var str = '±0';
    if (add < 0) {
      str = '$add';
    } else if (add > 0) {
      str = '+$add';
    }

    return _buildDiceName(
      numberStr: number.toString(),
      facesStr: faces.toString(),
      addStr: str,
    );
  }

  String _buildDiceName({String numberStr, String facesStr, String addStr}) {
    return '${numberStr}D$facesStr$addStr';
  }

  String get result {
    if (_results.isEmpty) {
      return '';
    }

    return '${_results.reduce((value, element) => value + element) + add}';
  }

  List<int> get results => _results;

  void roll() {
    _results?.clear();
    for (var i = 0; i < number; i++) {
      _results?.add(Random().nextInt(faces) + 1);
    }
  }
}
