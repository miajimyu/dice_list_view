import 'package:dice/widget/dice.dart';
import 'package:flutter/material.dart';

import 'history_data.dart';

class History extends ChangeNotifier {
  final List<HistoryData> historys = [];

  void add(Dice dice) {
    historys.add(HistoryData(dice: dice, dateTime: DateTime.now()));
    notifyListeners();
  }
}
