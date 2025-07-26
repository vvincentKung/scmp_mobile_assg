import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:scmp_mobile_assg/models/requests/login_request.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/services/api_service.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('@api_service', () {
    late MockClient mockClient;
    setUp(() {
      mockClient = MockClient();
    });
    group('#login', () {
      test('success', () async {
        // Arrange
        final response = http.Response('{"token": "mock_token"}', 200);
        when(
          mockClient.post(
            any,
            body: anyNamed('body'),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => response);
        final actualResult = await ApiService().login(
          mockClient,
          LoginRequest(email: 'email', password: 'password'),
        );
        expect((actualResult as Ok<LoginResponse>).value.toJson(), {
          "token": "mock_token",
        });
      });

      test('statusCode: 400', () async {
        // Arrange
        final response = http.Response('{"error": "mock_error"}', 400);
        when(
          mockClient.post(
            any,
            body: anyNamed('body'),
            headers: anyNamed('headers'),
          ),
        ).thenAnswer((_) async => response);
        final actualResult = await ApiService().login(
          mockClient,
          LoginRequest(email: 'email', password: 'password'),
        );
        expect(
          (actualResult as Error<LoginResponse>).error.toString(),
          "HttpException: mock_error",
        );
      });
    });
  });
}
