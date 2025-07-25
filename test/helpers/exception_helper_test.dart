import 'package:flutter_test/flutter_test.dart';
import 'dart:io';
import 'package:scmp_mobile_assg/helpers/exception_helper.dart';

void main() {
  group('@exception_helper', () {
    group('#getExceptionMessage', () {
      test('error is null', () {
        expect(getExceptionMessage(null), equals('No error occurred'));
      });

      test('HttpException', () {
        final httpException = HttpException('Not Found');
        expect(getExceptionMessage(httpException), equals('Not Found'));
      });

      test('Generic Exception', () {
        final exception = Exception('Something went wrong');
        expect(
          getExceptionMessage(exception),
          contains('Exception: Something went wrong'),
        );
      });
    });
  });
}
