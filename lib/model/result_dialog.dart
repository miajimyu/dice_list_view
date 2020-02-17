import 'package:flutter/material.dart';

import '../helper/shared_preferences_helpter.dart';

class ResultDialog extends ChangeNotifier {
  ResultDialog() {
    _loadLocalStrage();
    notifyListeners();
  }

  bool _isShowResultDialog = SharedPreferencesHelper.defaultIsShowDetailResult;

  bool get isShowResultDialog => _isShowResultDialog;

  Future<void> restoreDefault() async {
    _isShowResultDialog = SharedPreferencesHelper.defaultIsShowDetailResult;
    await _saveLocalStrage();
    notifyListeners();
  }

  Future<void> toggleShowResultDialog() async {
    _isShowResultDialog = !_isShowResultDialog;
    await _saveLocalStrage();
    notifyListeners();
  }

  Future<void> _saveLocalStrage() async {
    await SharedPreferencesHelper.saveIsShowResultDialog(
      isShowResultDialog: _isShowResultDialog,
    );
  }

  Future<void> _loadLocalStrage() async {
    _isShowResultDialog =
        await SharedPreferencesHelper.loadIsShowResultDialog();
  }
}
