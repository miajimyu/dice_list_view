import 'package:flutter/material.dart';

class HistoryData {
  HistoryData({
    @required this.diceName,
    @required this.result,
    @required this.results,
    @required this.dateTime,
  });

  final String diceName;
  final int result;
  final List<int> results;
  final DateTime dateTime;
}
