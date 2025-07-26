import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/models/requests/login_request.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/repositories/login_repository.dart';

class HomePageViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Exception? _error;
  Exception? get error => _error;

  final LoginRepository _loginRepository;

  var _token = '';
  String get token => _token;

  var _isUnauthenticated = false;
  bool get isUnauthenticated => _isUnauthenticated;

  HomePageViewModel(this._loginRepository);

  Future<void> fetchToken() async {
    _isLoading = true;
    notifyListeners();
    _token = await _loginRepository.getToken() ?? '';
    _isUnauthenticated = _token.isEmpty;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteToken() async {
    _isLoading = true;
    notifyListeners();
    await _loginRepository.deleteToken();
    _isLoading = false;
    notifyListeners();
    fetchToken();
  }

  // Add more methods as needed for login logic
}
