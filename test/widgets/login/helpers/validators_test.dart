import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:scmp_mobile_assg/widgets/login/helpers/validators.dart';

void main() {
  group('@validators.dart', () {
    group('#validateEmail', () {
      test('returns false for null', () {
        expect(validateEmail(null), isFalse);
      });

      test('returns false for empty string', () {
        expect(validateEmail(''), isFalse);
      });

      test('returns false for missing username', () {
        expect(validateEmail('@example.com'), isFalse);
      });

      test('returns false for missing @', () {
        expect(validateEmail('testemail.com'), isFalse);
      });

      test('returns false for missing domain', () {
        expect(validateEmail('test@'), isFalse);
      });

      test('returns true for valid email', () {
        expect(validateEmail('test@example.com'), isTrue);
      });
    });

    group('#validatePassword', () {
      test('returns false for null', () {
        expect(validatePassword(null), isFalse);
      });

      test('returns false for empty string', () {
        expect(validatePassword(''), isFalse);
      });

      test('returns false for less than 6 chars', () {
        expect(validatePassword('abc12'), isFalse);
      });

      test('returns false for more than 10 chars', () {
        expect(validatePassword('abcdefghijk'), isFalse);
      });

      test('returns false for special characters', () {
        expect(validatePassword('abc12!'), isFalse);
      });

      test('returns true for valid password with 6 digits', () {
        expect(validatePassword('abc123'), isTrue);
      });

      test('returns true for valid password with 10 digits', () {
        expect(validatePassword('Abc1234567'), isTrue);
      });
    });
  });
}
