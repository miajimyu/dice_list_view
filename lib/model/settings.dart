import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends ChangeNotifier {
  Settings() {
    _load();
  }

  bool _isShowResultDialog = true;

  bool get isShowResultDialog => _isShowResultDialog;

  Future<void> toggleShowResultDialog() async {
    _isShowResultDialog = !_isShowResultDialog;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('_isShowResultDialog', _isShowResultDialog);
    notifyListeners();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    _isShowResultDialog = prefs.getBool('_isShowResultDialog') ?? true;
  }
}
