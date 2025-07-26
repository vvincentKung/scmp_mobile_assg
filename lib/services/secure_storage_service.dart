import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();

  factory SecureStorageService() {
    return _instance;
  }

  SecureStorageService._internal();

  Future<void> saveToken(FlutterSecureStorage storage, String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> getToken(FlutterSecureStorage storage) async {
    return await storage.read(key: 'token');
  }

  Future<void> deleteToken(FlutterSecureStorage storage) async {
    await storage.delete(key: 'token');
  }
}
