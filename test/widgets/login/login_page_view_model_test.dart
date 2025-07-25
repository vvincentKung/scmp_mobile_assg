import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scmp_mobile_assg/widgets/login/login_page_view_model.dart';
import 'package:scmp_mobile_assg/models/requests/login_request.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/repositories/login_repository.dart';

class MockLoginRepository extends Mock implements LoginRepository {

  @override
  Future<Result<LoginResponse>> login(LoginRequest? request) async {
    return super.noSuchMethod(
      Invocation.method(#login, [request]),
      returnValue: Future.value(Ok(LoginResponse(token: ''))),
      returnValueForMissingStub: Future.value(Ok(LoginResponse(token: ''))),
    );
  }
}

void main() {
  late MockLoginRepository mockRepository;
  late LoginPageViewModel viewModel;

  setUp(() {
    mockRepository = MockLoginRepository();
    viewModel = LoginPageViewModel(mockRepository);
  });

  group('@LoginPageViewModel', () {
    group('#Initial', () {
      test('isLoading', () {
        expect(viewModel.isLoading, false);
      });

      test('error', () {
        expect(viewModel.error, null);
      });

      test('email', () {
        expect(viewModel.email, '');
        expect(viewModel.password, '');
        expect(viewModel.token, '');
      });

      test('password', () {
        expect(viewModel.isLoading, false);
        expect(viewModel.error, null);
        expect(viewModel.email, '');
        expect(viewModel.password, '');
        expect(viewModel.token, '');
      });

      test('password', () {
        expect(viewModel.password, '');
      });

      test('token', () {
        expect(viewModel.token, '');
      });
    });

    group('setEmail', () {
      test('works', () {
        viewModel.setEmail('test@example.com');
        expect(viewModel.email, 'test@example.com');
      });
    });

    group('setPassword', () {
      test('works', () {
        viewModel.setPassword('password123');
        expect(viewModel.password, 'password123');
      });
    });

    group('login', () {
      test('success', () async {
        when(mockRepository.login(any)).thenAnswer((_) async => Ok(LoginResponse(token: 'mock_token')));

        await viewModel.login();
        expect(viewModel.token, 'mock_token');
      });

      test('fail', () async {
        final exception = Exception('Login failed');
        when(mockRepository.login(any)).thenAnswer((_) async => Error<LoginResponse>(exception));

        await viewModel.login();
        expect(viewModel.error, exception);
      });
    });
  });
}
