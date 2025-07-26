import 'package:flutter_test/flutter_test.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';

void main() {
  group('@LoginResponse', () {
    test('#fromJson', (){
      const json = {
        "token": "mock_token",
      };
      final response = LoginResponse.fromJson(json);
      expect(response.token, "mock_token");
    });

    test('#toJson', (){
      expect(LoginResponse(token: 'mock_token').toJson(), {
        "token": "mock_token",
      });
    });
  });
}
