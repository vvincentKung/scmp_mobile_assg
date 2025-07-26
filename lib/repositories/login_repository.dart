import 'package:scmp_mobile_assg/models/requests/login_request.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';
import 'package:scmp_mobile_assg/services/api_service.dart';
import 'package:scmp_mobile_assg/services/secure_storage_service.dart';

class LoginRepository {
  final ApiService _apiService;
  final SecureStorageService _secureStorageService;

  LoginRepository(this._apiService, this._secureStorageService);

  Future<Result<LoginResponse>> login(LoginRequest request) async {
    final result = await _apiService.login(request);
    if (result is! Ok<LoginResponse>) {
      return result;
    }
    await _secureStorageService.saveToken(result.value.token);
    final token = await _secureStorageService.getToken();
    if (token == null) {
      return Result.error(Exception('Failed to retrieve token'));
    }
    return Result.ok(LoginResponse(
      token: token,
    ));
  }

  Future<String?> getToken() async {
    return await _secureStorageService.getToken();
  }

  Future<void> deleteToken() async {
    await _secureStorageService.deleteToken();
  }
}
