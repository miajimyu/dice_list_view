import 'package:dice/widget/dice.dart';
import 'package:flutter/material.dart';

class HistoryData {
  HistoryData({
    @required this.dice,
    @required this.dateTime,
  });

  final Dice dice;
  final DateTime dateTime;

  String get name => dice.name;
  int get result => dice.result;
  List<int> get results => dice.resultAll;
  DateTime get time => dateTime;
}
