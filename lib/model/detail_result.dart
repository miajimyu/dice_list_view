import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailResult extends ChangeNotifier {
  DetailResult() {
    _load();
  }
  static const defalShowDetailResult = false;
  bool _isShowDetailResult = defalShowDetailResult;

  bool get isShowDetailResult => _isShowDetailResult;

  Future<void> toggleShowDetailResult() async {
    _isShowDetailResult = !_isShowDetailResult;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('_isShowDetailResult', _isShowDetailResult);
    notifyListeners();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _isShowDetailResult =
        prefs.getBool('_isShowDetailResult') ?? defalShowDetailResult;
    notifyListeners();
  }
}
