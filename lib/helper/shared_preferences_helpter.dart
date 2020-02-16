import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/dice.dart';

class SharedPreferencesHelper {
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Detail Result
  static const defalShowDetailResult = false;
  static const keyIsShowDetailResult = 'isShowDetailResult';
  static Future<void> saveDetailResult(
      {@required bool isShowDetailResult}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsShowDetailResult, isShowDetailResult);
  }

  static Future<bool> loadDetailResult() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsShowDetailResult) ?? defalShowDetailResult;
  }

  // Result Dialog
  static const defaultIsShowDetailResult = true;
  static const keyIsShowResultDialog = 'isShowResultDialog';
  static Future<void> saveIsShowResultDialog(
      {@required bool isShowResultDialog}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsShowResultDialog, isShowResultDialog);
  }

  static Future<bool> loadIsShowResultDialog() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsShowResultDialog) ?? defaultIsShowDetailResult;
  }

  // Dice List
  static const keyDiceListLength = 'diceListLength';
  static const keyDiceList = 'diceList';
  static Future<void> saveDiceListLength(List<Dice> list) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt(keyDiceListLength, list.length);

    for (var i = 0; i < list.length; i++) {
      await prefs.setStringList('$keyDiceList$i', [
        list[i].number.toString(),
        list[i].faces.toString(),
        list[i].add.toString(),
      ]);
    }
  }

  static Future<int> loadDiceListLength() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyDiceListLength);
  }

  static Future<List<Dice>> loadDiceList(int length) async {
    final list = <Dice>[];

    final prefs = await SharedPreferences.getInstance();
    for (var i = 0; i < length; i++) {
      final strList = prefs.getStringList('$keyDiceList$i');
      list.add(
        Dice(
          number: int.parse(strList[0]),
          faces: int.parse(strList[1]),
          add: int.parse(strList[2]),
        ),
      );
    }

    return list;
  }
}
