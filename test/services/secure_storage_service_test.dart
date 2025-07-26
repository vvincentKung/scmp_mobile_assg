import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:scmp_mobile_assg/services/secure_storage_service.dart';

import 'secure_storage_service_test.mocks.dart';

@GenerateMocks([FlutterSecureStorage])
void main() {
  late MockFlutterSecureStorage mockStorage;
  late SecureStorageService service;
  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    service = SecureStorageService();
  });
  group('@SecureStorageService', () {
    test('#saveToken', () async {
      when(
        mockStorage.write(key: 'token', value: 'test_token'),
      ).thenAnswer((_) async => Future.value());
      await service.saveToken(mockStorage, 'test_token');
      verify(mockStorage.write(key: 'token', value: 'test_token')).called(1);
    });

    test('#getToken', () async {
      when(
        mockStorage.read(key: 'token'),
      ).thenAnswer((_) async => Future.value('test_token'));
      final actual = await service.getToken(mockStorage);
      expect(actual, 'test_token');
    });

    test('#deleteToken', () async {
      when(
        mockStorage.delete(key: 'token'),
      ).thenAnswer((_) async => Future.value());
      await service.deleteToken(mockStorage);
      verify(mockStorage.delete(key: 'token')).called(1);
    });
  });
}
