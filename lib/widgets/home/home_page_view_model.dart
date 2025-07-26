import 'package:scmp_mobile_assg/models/requests/fetch_staff_list_request.dart';
import 'package:scmp_mobile_assg/models/responses/staff_list_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/models/staff.dart';
import 'package:scmp_mobile_assg/repositories/login_repository.dart';
import 'package:scmp_mobile_assg/repositories/staffs_repository.dart';
import 'package:scmp_mobile_assg/widgets/home/base_view_model.dart';

class HomePageViewModel extends BaseViewModel {

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _hideLoadMoreIndicator = false;
  bool get hideLoadMoreIndicator => _hideLoadMoreIndicator;

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

  bool get isDataUpdating => isLoading || _isRefreshing || _isLoadingMore;

  HomePageViewModel(this._loginRepository, this._staffsRepository);

  Future<void> firstLoad() async {
    if (isDataUpdating) return;
    isLoading = true;
    notifyListeners();
    _token = await _loginRepository.getToken() ?? '';
    _isUnauthenticated = _token.isEmpty;
    if (_isUnauthenticated) {
      isLoading = false;
      notifyListeners();
      return;
    }
    final response = await _staffsRepository.fetchStaffs(
      FetchStaffListRequest(page: 1),
    );
    switch (response) {
      case Ok<StaffListResponse>():
        _staffs = response.value.data;
        error = null;
        _hideLoadMoreIndicator = response.value.data.isEmpty;
        break;
      case Error<StaffListResponse>():
        error = response.error;
        _hideLoadMoreIndicator = true;
        _staffs = [];
        break;
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteToken() async {
    isLoading = true;
    notifyListeners();
    await _loginRepository.deleteToken();
    _token = '';
    _isUnauthenticated = true;
    isLoading = false;
    notifyListeners();
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
        error = null;
        break;
      case Error<StaffListResponse>():
        error = response.error;
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
        error = null;
        _staffs = [..._staffs, ...response.value.data];
        _hideLoadMoreIndicator = response.value.data.isEmpty;
        if (response.value.data.isEmpty) break;
        _page++;
        break;
      case Error<StaffListResponse>():
        error = response.error;
        _hideLoadMoreIndicator = true;
        break;
    }
    _isLoadingMore = false;
    notifyListeners();
  }
}
