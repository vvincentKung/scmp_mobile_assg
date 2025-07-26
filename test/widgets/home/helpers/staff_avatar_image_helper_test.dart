import 'package:flutter_test/flutter_test.dart';
import 'package:scmp_mobile_assg/widgets/home/helpers/staff_avatar_image_helper.dart';

void main() {
  group('@staff_avatar_image_helper', () {
    group('#isNetworkImage', () {
      test('http URL', () {
        expect(isNetworkImage('http://example.com/image.jpg'), isTrue);
      });

      test('https URL', () {
        expect(isNetworkImage('https://example.com/image.jpg'), isTrue);
      });

      test('non-URL', () {
        expect(isNetworkImage('not_a_url'), isFalse);
      });

      test('empty string', () {
        expect(isNetworkImage(''), isFalse);
      });
    });
  });
}
