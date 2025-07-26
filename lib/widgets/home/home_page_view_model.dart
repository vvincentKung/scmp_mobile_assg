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

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _hideLoadMoreIndicator = false;
  bool get hideLoadMoreIndicator => _hideLoadMoreIndicator;

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

  var _page = 1;
  int get page => _page;

  bool get isDataUpdating => _isLoading || _isRefreshing || _isLoadingMore;

  HomePageViewModel(this._loginRepository, this._staffsRepository);

  Future<void> firstLoad() async {
    if (isDataUpdating) return;
    _isLoading = true;
    notifyListeners();
    _token = await _loginRepository.getToken() ?? '';
    _isUnauthenticated = _token.isEmpty;
    if (_isUnauthenticated) {
      _isLoading = false;
      notifyListeners();
      return;
    }
    final response = await _staffsRepository.fetchStaffs(
      FetchStaffListRequest(page: 1),
    );
    switch (response) {
      case Ok<StaffListResponse>():
        _staffs = response.value.data;
        _error = null;
        _hideLoadMoreIndicator = response.value.data.isEmpty;
        break;
      case Error<StaffListResponse>():
        _error = response.error;
        _hideLoadMoreIndicator = true;
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

  Future<void> refresh() async {
    if (isDataUpdating) return;
    _isRefreshing = true;
    notifyListeners();
    _page = 1;
    final response = await _staffsRepository.fetchStaffs(
      FetchStaffListRequest(page: _page),
    );
    switch (response) {
      case Ok<StaffListResponse>():
        _staffs = response.value.data;
        _hideLoadMoreIndicator = response.value.data.isEmpty;
        _error = null;
        break;
      case Error<StaffListResponse>():
        _error = response.error;
        _hideLoadMoreIndicator = true;
        break;
    }
    _isRefreshing = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (isDataUpdating) return;
    _isLoadingMore = true;
    notifyListeners();
    final response = await _staffsRepository.fetchStaffs(
      FetchStaffListRequest(page: _page + 1),
    );
    switch (response) {
      case Ok<StaffListResponse>():
        _error = null;
        _staffs = [..._staffs, ...response.value.data];
        _hideLoadMoreIndicator = response.value.data.isEmpty;
        if (response.value.data.isEmpty) break;
        _page++;
        break;
      case Error<StaffListResponse>():
        _error = response.error;
        _hideLoadMoreIndicator = true;
        break;
    }
    _isLoadingMore = false;
    notifyListeners();
  }
}
