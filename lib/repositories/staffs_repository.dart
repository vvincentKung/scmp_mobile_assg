import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:scmp_mobile_assg/models/exceptions/unauthorized_exception.dart';
import 'package:scmp_mobile_assg/models/requests/fetch_staff_list_request.dart';
import 'package:scmp_mobile_assg/models/responses/staff_list_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/models/staff.dart';
import 'package:scmp_mobile_assg/services/api_service.dart';
import 'package:scmp_mobile_assg/services/file_service.dart';

class StaffsRepository {
  final ApiService _apiService;
  final FileService _fileService;

  StaffsRepository(this._apiService, this._fileService);

  Future<Result<StaffListResponse>> fetchStaffs(
    FetchStaffListRequest request,
  ) async {
    final result = await _apiService.fetchStaffList(http.Client(), request);
    if (result is Error<StaffListResponse> && result.error is UnauthorizedException) {
      return result;
    }
    if (result is! Ok<StaffListResponse>) {
      final localStaffList = await _fileService.loadStaffListFromJson(
        request.page,
      );
      return Result.ok(
        StaffListResponse(
          data: localStaffList,
          page: request.page,
          totalPages: request.page,
          perPage: localStaffList.length,
          total: localStaffList.length,
          support: StaffListResponseSupport(
            url: '',
            text: '',
          ),
        ),
      );
    }
    _cacheStaffList(result.value.data, request.page);
    return result;
  }

  Future<List<Staff>> _cacheStaffList(List<Staff> staffs, int page) async {
    final remoteStaffList = <Staff>[];
    for (final staff in staffs) {
      final result = await _apiService.downloadStaffImage(
        http.Client(),
        staff.avatar,
        staff.avatar.split('/').last,
      );
      if (result is! Ok<Uint8List>) {
        remoteStaffList.add(staff);
        continue;
      }
      final file = await _fileService.saveImageByByte(
        result.value,
        staff.avatar.split('/').last,
      );
      if (file == null) {
        remoteStaffList.add(staff);
        continue;
      }
      remoteStaffList.add(staff.copyWith(avatar: file.path));
    }
    await _fileService.saveStaffListAsJson(remoteStaffList, page);
    return remoteStaffList;
  }
}
