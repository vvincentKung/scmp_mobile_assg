import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:scmp_mobile_assg/models/responses/staff_list_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/repositories/login_repository.dart';
import 'package:scmp_mobile_assg/repositories/staffs_repository.dart';
import 'package:scmp_mobile_assg/widgets/home/home_page_view_model.dart';

import 'home_page_view_model_test.mocks.dart';

@GenerateNiceMocks([MockSpec<StaffsRepository>(), MockSpec<LoginRepository>()])
void main() {
  group('@HomePageViewModel', () {
    late MockLoginRepository mockLoginRepository;
    late MockStaffsRepository mockStaffsRepository;
    late HomePageViewModel viewModel;

    setUp(() {
      mockLoginRepository = MockLoginRepository();
      mockStaffsRepository = MockStaffsRepository();
      viewModel = HomePageViewModel(mockLoginRepository, mockStaffsRepository);
    });

    group('#firstLoad', () {
      group('success', () {
        const json = {
          "data": [
            {
              "avatar": "https://reqres.in/img/faces/1-image.jpg",
              "email": "george.bluth@reqres.in",
              "first_name": "George",
              "id": 1,
              "last_name": "Bluth",
            },
          ],
          "page": 1,
          "per_page": 6,
          "support": {"text": "", "url": ""},
          "total": 12,
          "total_pages": 2,
        };

        test('token', () async {
          final result = Result.ok(StaffListResponse.fromJson(json));
          provideDummy<Result<StaffListResponse>>(result);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => result);
          await viewModel.firstLoad();
          expect(viewModel.token, 'valid_token');
        });

        test('staffList', () async {
          final result = Result.ok(StaffListResponse.fromJson(json));
          provideDummy<Result<StaffListResponse>>(result);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => result);
          await viewModel.firstLoad();
          expect(
            viewModel.staffList.map((e) => e.toJson()),
            (result as Ok<StaffListResponse>).value.data.map((e) => e.toJson()),
          );
        });

        test('page', () async {
          final result = Result.ok(StaffListResponse.fromJson(json));
          provideDummy<Result<StaffListResponse>>(result);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => result);
          await viewModel.firstLoad();
          expect(viewModel.page, 1);
        });
      });
      group('token not found', () {
        test('isUnauthenticated is true', () async {
          when(mockLoginRepository.getToken()).thenAnswer((_) async => '');
          await viewModel.firstLoad();
          expect(viewModel.isUnauthenticated, true);
        });
      });

      group('fail', () {
        test('token', () async {
          final error = Result<StaffListResponse>.error(
            Exception('Load failed'),
          );
          provideDummy<Result<StaffListResponse>>(error);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => error);
          await viewModel.firstLoad();
          expect(viewModel.token, 'valid_token');
        });

        test('staffList', () async {
          final error = Result<StaffListResponse>.error(
            Exception('Load failed'),
          );
          provideDummy<Result<StaffListResponse>>(error);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => error);
          await viewModel.firstLoad();
          expect(viewModel.staffList, []);
        });

        test('page', () async {
          final error = Result<StaffListResponse>.error(
            Exception('Load failed'),
          );
          provideDummy<Result<StaffListResponse>>(error);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => error);
          await viewModel.firstLoad();
          expect(viewModel.page, 1);
        });

        test('error', () async {
          final error = Result<StaffListResponse>.error(
            Exception('Load failed'),
          );
          provideDummy<Result<StaffListResponse>>(error);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => error);
          await viewModel.firstLoad();
          expect(viewModel.error.toString(), 'Exception: Load failed');
        });
      });
    });

    group('#refresh', () {
      group('success', () {
        const json = {
          "data": [
            {
              "avatar": "https://reqres.in/img/faces/1-image.jpg",
              "email": "george.bluth@reqres.in",
              "first_name": "George",
              "id": 1,
              "last_name": "Bluth",
            },
          ],
          "page": 1,
          "per_page": 6,
          "support": {"text": "", "url": ""},
          "total": 12,
          "total_pages": 2,
        };

        test('staffList', () async {
          final result = Result.ok(StaffListResponse.fromJson(json));
          provideDummy<Result<StaffListResponse>>(result);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => result);
          await viewModel.refresh();
          expect(
            viewModel.staffList.map((e) => e.toJson()),
            (result as Ok<StaffListResponse>).value.data.map((e) => e.toJson()),
          );
        });

        test('page', () async {
          final result = Result.ok(StaffListResponse.fromJson(json));
          provideDummy<Result<StaffListResponse>>(result);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => result);
          await viewModel.refresh();
          expect(viewModel.page, 1);
        });
      });
      group('fail', () {
        test('staffList', () async {
          final error = Result<StaffListResponse>.error(
            Exception('Load failed'),
          );
          provideDummy<Result<StaffListResponse>>(error);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => error);
          await viewModel.refresh();
          expect(viewModel.staffList, []);
        });

        test('page', () async {
          final error = Result<StaffListResponse>.error(
            Exception('Load failed'),
          );
          provideDummy<Result<StaffListResponse>>(error);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => error);
          await viewModel.refresh();
          expect(viewModel.page, 1);
        });

        test('error', () async {
          final error = Result<StaffListResponse>.error(
            Exception('Load failed'),
          );
          provideDummy<Result<StaffListResponse>>(error);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => error);
          await viewModel.refresh();
          expect(viewModel.error.toString(), 'Exception: Load failed');
        });
      });
    });

    group('#loadMore', () {
      group('success', () {
        const json = {
          "data": [
            {
              "avatar": "https://reqres.in/img/faces/1-image.jpg",
              "email": "george.bluth@reqres.in",
              "first_name": "George",
              "id": 1,
              "last_name": "Bluth",
            },
          ],
          "page": 1,
          "per_page": 6,
          "support": {"text": "", "url": ""},
          "total": 12,
          "total_pages": 2,
        };

        test('staffList', () async {
          final result = Result.ok(StaffListResponse.fromJson(json));
          provideDummy<Result<StaffListResponse>>(result);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => result);
          await viewModel.loadMore();
          expect(
            viewModel.staffList.map((e) => e.toJson()),
            (result as Ok<StaffListResponse>).value.data.map((e) => e.toJson()),
          );
        });

        test('page', () async {
          final result = Result.ok(StaffListResponse.fromJson(json));
          provideDummy<Result<StaffListResponse>>(result);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => result);
          await viewModel.loadMore();
          expect(viewModel.page, 2);
        });

        test('hideLoadMoreIndicator', () async {
          final result = Result.ok(StaffListResponse.fromJson(json));
          provideDummy<Result<StaffListResponse>>(result);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => result);
          await viewModel.loadMore();
          expect(viewModel.hideLoadMoreIndicator, false);
        });
      });
      group('fail', () {
        test('staffList', () async {
          final error = Result<StaffListResponse>.error(
            Exception('Load failed'),
          );
          provideDummy<Result<StaffListResponse>>(error);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => error);
          await viewModel.loadMore();
          expect(viewModel.staffList, []);
        });

        test('page', () async {
          final error = Result<StaffListResponse>.error(
            Exception('Load failed'),
          );
          provideDummy<Result<StaffListResponse>>(error);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => error);
          await viewModel.loadMore();
          expect(viewModel.page, 1);
        });

        test('error', () async {
          final error = Result<StaffListResponse>.error(
            Exception('Load failed'),
          );
          provideDummy<Result<StaffListResponse>>(error);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => error);
          await viewModel.loadMore();
          expect(viewModel.error.toString(), 'Exception: Load failed');
        });

        test('hideLoadMoreIndicator', () async {
          final error = Result<StaffListResponse>.error(
            Exception('Load failed'),
          );
          provideDummy<Result<StaffListResponse>>(error);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => error);
          await viewModel.loadMore();
          expect(viewModel.hideLoadMoreIndicator, true);
        });
      });
      group('success: empty data', () {
        const json = {
          "data": [],
          "page": 1,
          "per_page": 6,
          "support": {"text": "", "url": ""},
          "total": 12,
          "total_pages": 2,
        };

        test('staffList', () async {
          final result = Result.ok(StaffListResponse.fromJson(json));
          provideDummy<Result<StaffListResponse>>(result);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => result);
          await viewModel.loadMore();
          expect(
            viewModel.staffList.map((e) => e.toJson()),
            (result as Ok<StaffListResponse>).value.data.map((e) => e.toJson()),
          );
        });

        test('page', () async {
          final result = Result.ok(StaffListResponse.fromJson(json));
          provideDummy<Result<StaffListResponse>>(result);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => result);
          await viewModel.loadMore();
          expect(viewModel.page, 1);
        });

        test('hideLoadMoreIndicator', () async {
          final result = Result.ok(StaffListResponse.fromJson(json));
          provideDummy<Result<StaffListResponse>>(result);
          when(
            mockLoginRepository.getToken(),
          ).thenAnswer((_) async => 'valid_token');
          when(
            mockStaffsRepository.fetchStaffs(any),
          ).thenAnswer((_) async => result);
          await viewModel.loadMore();
          expect(viewModel.hideLoadMoreIndicator, true);
        });
      });
    });
  });
}
