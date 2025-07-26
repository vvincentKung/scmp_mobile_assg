import 'package:http/http.dart' as http;
import 'package:scmp_mobile_assg/models/requests/fetch_staff_list_request.dart';
import 'package:scmp_mobile_assg/models/requests/login_request.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';
import 'package:scmp_mobile_assg/models/responses/staff_list_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/services/api_service.dart';
import 'package:scmp_mobile_assg/services/secure_storage_service.dart';

class StaffsRepository {
  final ApiService _apiService;
  final SecureStorageService _secureStorageService;

  StaffsRepository(this._apiService, this._secureStorageService);

  Future<Result<StaffListResponse>> fetchStaffs(FetchStaffListRequest request) async {
    final result = await _apiService.fetchStaffList(http.Client(), request);
    return result;
  }
}
