import 'package:flutter/material.dart';
import 'package:scmp_mobile_assg/models/requests/fetch_staff_list_request.dart';
import 'package:scmp_mobile_assg/models/responses/staff_list_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/models/staff.dart';
import 'package:scmp_mobile_assg/repositories/login_repository.dart';
import 'package:scmp_mobile_assg/repositories/staffs_repository.dart';

class HomePageViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Exception? _error;
  Exception? get error => _error;

  final LoginRepository _loginRepository;
  final StaffsRepository _staffsRepository;

  var _token = '';
  String get token => _token;

  var _isUnauthenticated = false;
  bool get isUnauthenticated => _isUnauthenticated;

  var _staffs = <Staff>[];
  List<Staff> get staffList => _staffs;

  HomePageViewModel(this._loginRepository, this._staffsRepository);

  Future<void> firstLoad() async {
    _isLoading = true;
    notifyListeners();
    _token = await _loginRepository.getToken() ?? '';
    _isUnauthenticated = _token.isEmpty;
    if(_isUnauthenticated) {
      _isLoading = false;
      notifyListeners();
      return;
    }
    final response = await _staffsRepository.fetchStaffs(FetchStaffListRequest(page: 1));
    switch (response) {
      case Ok<StaffListResponse>():
        _staffs = response.value.data;
        _error = null;
        break;
      case Error<StaffListResponse>():
        _error = response.error;
        _staffs = [];
        break;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteToken() async {
    _isLoading = true;
    notifyListeners();
    await _loginRepository.deleteToken();
    _isLoading = false;
    notifyListeners();
    firstLoad();
  }

  // Add more methods as needed for login logic
}
