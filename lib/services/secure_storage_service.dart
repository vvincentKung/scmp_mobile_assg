import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:scmp_mobile_assg/models/exceptions/unauthorized_exception.dart';
import 'package:scmp_mobile_assg/models/requests/fetch_staff_list_request.dart';
import 'package:scmp_mobile_assg/models/requests/login_request.dart';
import 'package:scmp_mobile_assg/models/responses/error_response.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';
import 'package:scmp_mobile_assg/models/responses/staff_list_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';

class SecureStorageService {
  final storage = FlutterSecureStorage(
    aOptions: const AndroidOptions(
      encryptedSharedPreferences: true,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
  static final SecureStorageService _instance = SecureStorageService._internal();

  factory SecureStorageService() {
    return _instance;
  }

  SecureStorageService._internal();

  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> deleteToken() async {
    await storage.delete(key: 'token');
  }
}
