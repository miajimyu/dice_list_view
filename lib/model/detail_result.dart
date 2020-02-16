import 'package:flutter/material.dart';

import '../helper/shared_preferences_helpter.dart';

class DetailResult extends ChangeNotifier {
  DetailResult() {
    _loadLocalStrage();
    notifyListeners();
  }

  bool _isShowDetailResult = SharedPreferencesHelper.defalShowDetailResult;

  bool get isShowDetailResult => _isShowDetailResult;

  Future<void> save() async {
    await _saveLocalStrage();
    notifyListeners();
  }

  Future<void> toggleShowDetailResult() async {
    _isShowDetailResult = !_isShowDetailResult;
    await _saveLocalStrage();
    notifyListeners();
  }

  Future<void> _saveLocalStrage() async {
    await SharedPreferencesHelper.saveDetailResult(
      isShowDetailResult: _isShowDetailResult,
    );
  }

  Future<void> _loadLocalStrage() async {
    _isShowDetailResult = await SharedPreferencesHelper.loadDetailResult();
  }
}
