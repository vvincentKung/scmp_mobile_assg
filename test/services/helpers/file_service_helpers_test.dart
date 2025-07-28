import 'package:flutter_test/flutter_test.dart';
import 'package:scmp_mobile_assg/services/helpers/file_service_helpers.dart';

void main() {
  group('@file_service_helpers', () {
    test('#buildFilePath', () {
      final directory = '/path/to/directory';
      final fileName = 'file.txt';
      final expectedPath = '/path/to/directory/file.txt';

      final result = buildFilePath(directory: directory, fileName: fileName);

      expect(result, expectedPath);
    });

  });
}