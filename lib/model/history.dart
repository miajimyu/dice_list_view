import 'dice.dart';
import 'history_data.dart';

class History {
  final List<HistoryData> historys = [];

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
}
