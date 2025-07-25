import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:scmp_mobile_assg/widgets/login/login_page_view_model.dart';
import 'package:scmp_mobile_assg/models/requests/login_request.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/repositories/login_repository.dart';

import 'login_page_view_model_test.mocks.dart';

@GenerateNiceMocks([MockSpec<LoginRepository>()])
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
        final result = Ok(LoginResponse(token: 'mock_token'));
        provideDummy<Result<LoginResponse>>(result);
        when(mockRepository.login(any)).thenAnswer((_) async => result);

        await viewModel.login();
        expect(viewModel.token, 'mock_token');
      });

      test('fail', () async {
        final exception = Exception('Login failed');
        final error = Error<LoginResponse>(exception);
        provideDummy<Result<LoginResponse>>(error);
        when(mockRepository.login(any)).thenAnswer((_) async => error);

        await viewModel.login();
        expect(viewModel.error, exception);
      });
    });
  });
}
