import 'package:flutter_test/flutter_test.dart';
import 'package:scmp_mobile_assg/models/responses/staff_list_response.dart';

void main() {
  group('@StaffListResponse', () {
    group('#fromJson', () {
      const json = {
        "data": [
          {
            "avatar": "https://reqres.in/img/faces/1-image.jpg",
            "email": "george.bluth@reqres.in",
            "first_name": "George",
            "id": 1,
            "last_name": "Bluth",
          },
        ],
        "page": 1,
        "per_page": 6,
        "support": {
          "text":
              "Tired of writing endless social media content? Let Content Caddy generate it for you.",
          "url":
              "https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral",
        },
        "total": 12,
        "total_pages": 2,
      };

      test('data', () {
        final response = StaffListResponse.fromJson(json);
        expect(response.data.map((e) => e.toJson()), [
          {
            "avatar": "https://reqres.in/img/faces/1-image.jpg",
            "email": "george.bluth@reqres.in",
            "first_name": "George",
            "id": 1,
            "last_name": "Bluth",
          },
        ]);
      });

      test('page', () {
        final response = StaffListResponse.fromJson(json);
        expect(response.page, 1);
      });

      test('per_page', () {
        final response = StaffListResponse.fromJson(json);
        expect(response.perPage, 6);
      });

      test('support', () {
        final response = StaffListResponse.fromJson(json);
        expect(response.support.toJson(), {
          "text":
              "Tired of writing endless social media content? Let Content Caddy generate it for you.",
          "url":
              "https://contentcaddy.io?utm_source=reqres&utm_medium=json&utm_campaign=referral",
        });
      });

      test('total', () {
        final response = StaffListResponse.fromJson(json);
        expect(response.total, 12);
      });

      test('total_pages', () {
        final response = StaffListResponse.fromJson(json);
        expect(response.totalPages, 2);
      });

      
    });
  });
}
