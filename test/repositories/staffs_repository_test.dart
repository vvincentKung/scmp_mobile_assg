import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:scmp_mobile_assg/models/exceptions/unauthorized_exception.dart';
import 'package:scmp_mobile_assg/models/requests/fetch_staff_list_request.dart';
import 'package:scmp_mobile_assg/models/responses/staff_list_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/repositories/staffs_repository.dart';
import 'package:scmp_mobile_assg/services/api_service.dart';
import 'package:scmp_mobile_assg/services/file_service.dart';
import 'staffs_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ApiService>(), MockSpec<FileService>()])
void main() {
  group('@StaffsRepository', () {
    late MockApiService mockApiService;
    late MockFileService mockFileService;
    late StaffsRepository staffsRepository;
    setUp(() {
      mockApiService = MockApiService();
      mockFileService = MockFileService();
      staffsRepository = StaffsRepository(mockApiService, mockFileService);
    });
    group('#fetchStaffs', () {
      test('success', () async {
        const json = {
          "data": [
            {
              "avatar": "https://reqres.in/img/faces/1-image.jpg",
              "email": "george.bluth@reqres.in",
              "first_name": "George",
              "id": 1,
              "last_name": "Bluth",
            },
            {
              "avatar": "https://reqres.in/img/faces/2-image.jpg",
              "email": "janet.weaver@reqres.in",
              "first_name": "Janet",
              "id": 2,
              "last_name": "Weaver",
            },
          ],
          "page": 1,
          "per_page": 6,
          "support": {
            "text":
                "Tired of writing endless social media content? Let Content Caddy generate it for you.",
            "url":
                "https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral",
          },
          "total": 12,
          "total_pages": 2,
        };
        final result = Result.ok(StaffListResponse.fromJson(json));
        provideDummy<Result<StaffListResponse>>(result);
        when(
          mockApiService.fetchStaffList(any, any),
        ).thenAnswer((_) async => result);

        final mockDownloadStaffImageResult = Result<Uint8List>.ok(Uint8List(0));
        provideDummy(mockDownloadStaffImageResult);
        when(
          mockApiService.downloadStaffImage(any, any, any),
        ).thenAnswer((_) async => mockDownloadStaffImageResult);
        when(
          mockFileService.saveImageByByte(any, any),
        ).thenAnswer((_) async => File('path/to/mock_image.jpg'));
        when(
          mockFileService.saveStaffListAsJson(any, any),
        ).thenAnswer((_) async => File('path/to/mock_staff_list.json'));

        when(
          mockFileService.loadStaffListFromJson(any),
        ).thenAnswer((_) async => (result as Ok<StaffListResponse>).value.data);

        final actualResult = await staffsRepository.fetchStaffs(
          const FetchStaffListRequest(page: 1),
        );
        expect((actualResult as Ok<StaffListResponse>).value.toJson(), json);
      });

      test('fail', () async {
        const json = {
          "data": [
            {
              "avatar": "https://reqres.in/img/faces/1-image.jpg",
              "email": "george.bluth@reqres.in",
              "first_name": "George",
              "id": 1,
              "last_name": "Bluth",
            },
            {
              "avatar": "https://reqres.in/img/faces/2-image.jpg",
              "email": "janet.weaver@reqres.in",
              "first_name": "Janet",
              "id": 2,
              "last_name": "Weaver",
            },
          ],
          "page": 1,
          "per_page": 6,
          "support": {
            "text":
                "Tired of writing endless social media content? Let Content Caddy generate it for you.",
            "url":
                "https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral",
          },
          "total": 12,
          "total_pages": 2,
        };
        final result = Result.ok(StaffListResponse.fromJson(json));
        provideDummy<Result<StaffListResponse>>(result);
        final error = Result<StaffListResponse>.error(Exception('Load failed'));
        when(
          mockApiService.fetchStaffList(any, any),
        ).thenAnswer((_) async => error);
        when(
          mockFileService.loadStaffListFromJson(any),
        ).thenAnswer((_) async => (result as Ok<StaffListResponse>).value.data);
        final actualResult = await staffsRepository.fetchStaffs(
          const FetchStaffListRequest(page: 1),
        );
        expect(
          (actualResult as Ok<StaffListResponse>).value.data.map(
            (e) => e.toJson(),
          ),
          (result as Ok<StaffListResponse>).value.data.map((e) => e.toJson()),
        );
      });

      test('status: 401', () async {
        final error = Result<StaffListResponse>.error(UnauthorizedException());
        provideDummy<Result<StaffListResponse>>(error);
        when(
          mockApiService.fetchStaffList(any, any),
        ).thenAnswer((_) async => error);
        final actualResult = await staffsRepository.fetchStaffs(
          const FetchStaffListRequest(page: 1),
        );
        expect(
          (actualResult as Error<StaffListResponse>).error,
          isA<UnauthorizedException>(),
        );
      });
    });
  });
}
