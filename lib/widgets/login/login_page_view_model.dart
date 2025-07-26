import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/models/requests/login_request.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/repositories/login_repository.dart';
import 'package:scmp_mobile_assg/widgets/home/base_view_model.dart';

class LoginPageViewModel extends BaseViewModel {

  final LoginRepository _loginRepository;

  var _email = '';
  var _password = '';
  var _token = '';

  String get email => _email;
  String get password => _password;
  String get token => _token;

  LoginPageViewModel(this._loginRepository);

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future login() async {
    isLoading = true;
    notifyListeners();
    final response = await _loginRepository.login(
      LoginRequest(email: email, password: password),
    );
    switch (response) {
      case Ok<LoginResponse>():
        final result = response.value;
        _token = result.token;
        error = null;
        break;
      case Error<LoginResponse>():
        error = response.error;
        _token = '';
        break;
    }
    isLoading = false;
    notifyListeners();
  }

  // Add more methods as needed for login logic
}
