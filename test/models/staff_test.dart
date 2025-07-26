import 'package:flutter_test/flutter_test.dart';
import 'package:scmp_mobile_assg/models/staff.dart';

void main() {
  group('@Staff', () {
    group('#fromJson', () {
      const json = {
        "avatar": "https://reqres.in/img/faces/1-image.jpg",
        "email": "george.bluth@reqres.in",
        "first_name": "George",
        "id": 1,
        "last_name": "Bluth",
      };
      test('avatar', () {
        final staff = Staff.fromJson(json);
        expect(staff.avatar, "https://reqres.in/img/faces/1-image.jpg");
      });

      test('email', () {
        final staff = Staff.fromJson(json);
        expect(staff.email, "george.bluth@reqres.in");
      });

      test('first_name', () {
        final staff = Staff.fromJson(json);
        expect(staff.firstName, "George");
      });

      test('id', () {
        final staff = Staff.fromJson(json);
        expect(staff.id, 1);
      });

      test('last_name', () {
        final staff = Staff.fromJson(json);
        expect(staff.lastName, "Bluth");
      });
    });

    group('#toJson', () {
      test('', () {
        expect(
          Staff(
            id: 1,
            email: "mock_email",
            firstName: "mock_firstName",
            lastName: "mock_lastName",
            avatar: "mock_avatar",
          ).toJson(),
          {
            "id": 1,
            "email": "mock_email",
            "first_name": "mock_firstName",
            "last_name": "mock_lastName",
            "avatar": "mock_avatar",
          },
        );
      });
    });
  });
}
