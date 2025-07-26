import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageFactory {
  static final SecureStorageFactory _instance = SecureStorageFactory._internal();
  factory SecureStorageFactory() {
    return _instance;
  }
  SecureStorageFactory._internal();
  
  FlutterSecureStorage create() {
    return FlutterSecureStorage(
    aOptions: const AndroidOptions(
      encryptedSharedPreferences: true,
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    ),
    iOptions: const IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );
  }
}
