import 'package:flutter/material.dart';

import 'dice.dart';

class DiceList extends ChangeNotifier {
  List<Dice> list = [
    Dice(faces: 2),
    Dice(number: 2, faces: 3),
    Dice(faces: 4),
    Dice(faces: 6),
    Dice(number: 2, faces: 6, add: 6),
    Dice(number: 100, faces: 6),
    Dice(faces: 10),
    Dice(faces: 20),
    Dice(faces: 100),
  ];

  void roll(int index) {
    list[index]?.roll();
    notifyListeners();
  }

  void add(Dice dice) {
    list?.add(dice);
    notifyListeners();
  }

  void remove(int index) {
    list?.removeAt(index);
    notifyListeners();
  }
}
