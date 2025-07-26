import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  Exception? _error;

  bool get isLoading => _isLoading;
  Exception? get error => _error;

  set isLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  set error(Exception? value) {
    if (_error != value) {
      _error = value;
      notifyListeners();
    }
  }

}
