import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scmp_mobile_assg/models/requests/login_request.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/repositories/login_repository.dart';
import 'package:scmp_mobile_assg/services/api_service.dart';

class MockApiService extends Mock implements ApiService {
  @override
  Future<Result<LoginResponse>> login(LoginRequest request) {
    return super.noSuchMethod(
      Invocation.method(#login, [request]),
      returnValue: Future.value(Result.ok(LoginResponse(token: 'mock_token'))),
      returnValueForMissingStub: Future.value(
        Result.ok(LoginResponse(token: 'mock_token')),
      ),
    );
  }
}

void main() {
  group('@LoginRepository', () {
    late MockApiService mockApiService;
    late LoginRepository loginRepository;

    setUp(() {
      mockApiService = MockApiService();
      loginRepository = LoginRepository(mockApiService);
    });

    group('#login', () {
      test('success', () async {
        final request = LoginRequest(email: 'user', password: 'pass');
        final result = Result<LoginResponse>.ok(LoginResponse(token: 'abc123'));

        when(mockApiService.login(request)).thenAnswer((_) async => result);

        final actualResult = await loginRepository.login(request);
        expect(actualResult, result);
      });

      test('fail', () async {
        final request = LoginRequest(email: 'user', password: 'wrongPassword');
        final result = Result<LoginResponse>.error(Exception('Login failed'));

        when(mockApiService.login(request)).thenAnswer((_) async => result);

        final actualResult = await loginRepository.login(request);
        expect(actualResult, result);
      });
    });
  });
}
