import 'package:dice/helper/shared_preferences_helpter.dart';
import 'package:flutter/material.dart';

import 'dice.dart';

class DiceList extends ChangeNotifier {
  DiceList() {
    _loadLocalStrage();
  }
  List<Dice> list = [];
  Dice _currentRemovedDice;
  int _currentRemovedDiceIndex;

  final List<Dice> _defaultlist = [
    Dice(faces: 2),
    Dice(number: 2, faces: 3),
    Dice(faces: 4),
    Dice(faces: 6),
    Dice(number: 2, faces: 6, add: 6),
    Dice(number: 3, faces: 6),
    Dice(faces: 10),
    Dice(faces: 20),
    Dice(faces: 100),
  ];

  Future<void> restoreDefault() async {
    list = List.from(_defaultlist);
    await _saveLocalStrage();
    notifyListeners();
  }

  void roll(int index) {
    list[index]?.roll();

    _saveLocalStrage();
    notifyListeners();
  }

  void add(Dice dice) {
    list?.add(dice);

    _saveLocalStrage();
    notifyListeners();
  }

  void remove(int index) {
    // for undo
    _pushRemovedDice(index: index, dice: list[index]);

    list?.removeAt(index);

    _saveLocalStrage();
    notifyListeners();
  }

  void undoRemove() {
    _popRemovedDice();
  }

  void _pushRemovedDice({int index, Dice dice}) {
    _currentRemovedDiceIndex = index;
    _currentRemovedDice = dice;
  }

  void _popRemovedDice() {
    final isNothingToPop =
        _currentRemovedDice == null || _currentRemovedDice == null;
    if (isNothingToPop) {
      _cleanRemovedDice();
      return;
    }

    list.insert(_currentRemovedDiceIndex, _currentRemovedDice);

    _cleanRemovedDice();
    _saveLocalStrage();
    notifyListeners();
  }

  void _cleanRemovedDice() {
    _currentRemovedDiceIndex = null;
    _currentRemovedDice = null;
  }

  void update(int oldIndex, int newIndex) {
    final _index = oldIndex < newIndex ? newIndex - 1 : newIndex;
    final _item = list[oldIndex];
    list
      ..remove(_item)
      ..insert(_index, _item);

    _saveLocalStrage();
    notifyListeners();
  }

  Future<void> _loadLocalStrage() async {
    final length = await SharedPreferencesHelper.loadDiceListLength();
    if (length == null) {
      await restoreDefault();
      return;
    }

    list = await SharedPreferencesHelper.loadDiceList(length);

    await _saveLocalStrage();
    notifyListeners();
  }

  Future<void> _saveLocalStrage() async {
    await SharedPreferencesHelper.saveDiceListLength(list);
  }
}
