import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}