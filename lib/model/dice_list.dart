import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dice.dart';

List<Dice> defaultlist = [
  Dice(faces: 2),
  Dice(number: 2, faces: 3),
  Dice(faces: 4),
  Dice(faces: 6),
  Dice(number: 2, faces: 6, add: 6),
  Dice(faces: 10),
  Dice(faces: 20),
  Dice(faces: 100),
];

class DiceList extends ChangeNotifier {
  DiceList() {
    _load();
  }

  List<Dice> list = [];

  void roll(int index) {
    list[index]?.roll();

    _save();
    notifyListeners();
  }

  void add(Dice dice) {
    list?.add(dice);

    _save();
    notifyListeners();
  }

  void remove(int index) {
    list?.removeAt(index);

    _save();
    notifyListeners();
  }

  void update(int oldIndex, int newIndex) {
    final _index = oldIndex < newIndex ? newIndex - 1 : newIndex;
    final _item = list[oldIndex];
    list
      ..remove(_item)
      ..insert(_index, _item);

    _save();
    notifyListeners();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final length = prefs.getInt('diceListLength');

    if (length == null) {
      list = defaultlist;
      notifyListeners();
      return;
    }

    for (var i = 0; i < length; i++) {
      final strList = prefs.getStringList('diceList$i');
      list.add(
        Dice(
          number: int.parse(strList[0]),
          faces: int.parse(strList[1]),
          add: int.parse(strList[2]),
        ),
      );
    }
    notifyListeners();
    return;
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('diceListLength', list.length);

    for (var i = 0; i < list.length; i++) {
      await prefs.setStringList('diceList$i', [
        list[i].number.toString(),
        list[i].faces.toString(),
        list[i].add.toString(),
      ]);
    }
  }
}
