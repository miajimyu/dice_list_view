import 'package:flutter/foundation.dart';

import 'dice.dart';
import 'history_data.dart';

class History extends ChangeNotifier {
  List<HistoryData> historys = [];

  void add(Dice dice) {
    historys.add(
      HistoryData(
        diceName: dice.name,
        result: dice.result,
        results: dice.results.toList(),
        dateTime: DateTime.now(),
      ),
    );
  }

  void clear() {
    historys.clear();
    notifyListeners();
  }
}
