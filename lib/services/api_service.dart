import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:scmp_mobile_assg/models/exceptions/unauthorized_exception.dart';
import 'package:scmp_mobile_assg/models/requests/fetch_staff_list_request.dart';
import 'package:scmp_mobile_assg/models/requests/login_request.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';
import 'package:scmp_mobile_assg/models/responses/staff_list_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<Result<LoginResponse>> login(LoginRequest request) async {
    final client = http.Client();
    try {
      final response = await client.post(
        Uri.parse('https://reqres.in/api/login?delay=5'),
        headers: {'x-api-key': 'reqres-free-v1'},
        body: '{"email": "${request.email}", "password": "${request.password}"}',
      );
      if (response.statusCode == 200) {
        return Result.ok(
          LoginResponse.fromJson(json.decode(utf8.decode(response.bodyBytes))),
        );
      } else {
        return Result.error(HttpException('Invalid response'));
      }
    } on Exception catch (exception) {
      return Result.error(exception);
    } finally {
      client.close();
    }
  }

  Future<Result<StaffListResponse>> fetchStaffList(FetchStaffListRequest request) async {
    final client = http.Client();
    try {
      final response = await client.get(
        Uri.parse('https://reqres.in/api/users?page=${request.page}'),
      );
      if (response.statusCode == 200) {
        return Result.ok(
          StaffListResponse.fromJson(json.decode(utf8.decode(response.bodyBytes))),
        );
      }

      if(response.statusCode == 401) {
        return Result.error(UnauthorizedException());
      }

      return Result.error(HttpException('Invalid response'));
    } on Exception catch (exception) {
      return Result.error(exception);
    } finally {
      client.close();
    }
  }
}
