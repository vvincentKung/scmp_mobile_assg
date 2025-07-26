import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:scmp_mobile_assg/models/requests/login_request.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/repositories/login_repository.dart';
import 'package:scmp_mobile_assg/services/api_service.dart';
import 'package:scmp_mobile_assg/services/secure_storage_service.dart';

import 'login_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ApiService>(), MockSpec<SecureStorageService>()])
void main() {
  group('@LoginRepository', () {
    late MockApiService mockApiService;
    late MockSecureStorageService mockSecureStorageService;
    late LoginRepository loginRepository;
    setUp(() {
      mockApiService = MockApiService();
      mockSecureStorageService = MockSecureStorageService();
      loginRepository = LoginRepository(
        mockApiService,
        mockSecureStorageService,
      );
    });

    group('#login', () {
      test('success', () async {
        final result = Result.ok(LoginResponse(token: 'abc123'));
        provideDummy(result);
        when(mockApiService.login(any,any)).thenAnswer((_) async => result);
        when(
          mockSecureStorageService.saveToken(any,any),
        ).thenAnswer((_) async => {});
        when(
          mockSecureStorageService.getToken(any),
        ).thenAnswer((_) async => 'abc123');
        final actualResult = await loginRepository.login(
          LoginRequest(email: 'email', password: 'password'),
        );
        expect(
          (actualResult as Ok<LoginResponse>).value.toJson(),
          (result as Ok<LoginResponse>).value.toJson(),
        );
      });

      test('fail', () async {
        final request = LoginRequest(email: 'email', password: 'wrongPassword');
        final result = Result<LoginResponse>.error(Exception('Login failed'));
        provideDummy(result);
        when(mockApiService.login(any,any)).thenAnswer((_) async => result);
        when(
          mockSecureStorageService.saveToken(any,any),
        ).thenAnswer((_) async => {});
        when(
          mockSecureStorageService.getToken(any),
        ).thenAnswer((_) async => null);

        final actualResult = await loginRepository.login(request);
        expect(
          (actualResult as Error<LoginResponse>).error.toString(),
          (result as Error<LoginResponse>).error.toString(),
        );
      });
    });
  });
}
