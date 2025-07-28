import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:scmp_mobile_assg/models/exceptions/unauthorized_exception.dart';
import 'package:scmp_mobile_assg/models/requests/fetch_staff_list_request.dart';
import 'package:scmp_mobile_assg/models/requests/login_request.dart';
import 'package:scmp_mobile_assg/models/responses/error_response.dart';
import 'package:scmp_mobile_assg/models/responses/login_response.dart';
import 'package:scmp_mobile_assg/models/responses/staff_list_response.dart';
import 'package:scmp_mobile_assg/models/result.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  final _shortTimeout = Duration(seconds: 3);
  final _logInTimeout = Duration(seconds: 10);
  final _downloadTimeout = Duration(seconds: 30);
  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<Result<LoginResponse>> login(
    http.Client client,
    LoginRequest request,
  ) async {
    try {
      final response = await client.post(
        Uri.parse('https://reqres.in/api/login?delay=5'),
        headers: {'x-api-key': 'reqres-free-v1'},
        body: request.toJson(),
      ).timeout(
            _logInTimeout,
            onTimeout: () {
              throw TimeoutException('Request timed out');
            },
          );
      if (response.statusCode == 200) {
        return Result.ok(
          LoginResponse.fromJson(json.decode(utf8.decode(response.bodyBytes))),
        );
      }
      final errorResponse = ErrorResponse.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );
      return Result.error(HttpException(errorResponse.error));
    } on Exception catch (e) {
      debugPrint('Error during login: $e');
      return Result.error(Exception('Failed to login'));
    } finally {
      client.close();
    }
  }

  Future<Result<StaffListResponse>> fetchStaffList(
    http.Client client,
    FetchStaffListRequest request,
  ) async {
    try {
      final response = await client
          .get(
            Uri.parse('https://reqres.in/api/users?page=${request.page}'),
            headers: {'x-api-key': 'reqres-free-v1'},
          )
          .timeout(
            _shortTimeout,
            onTimeout: () {
              throw TimeoutException('Request timed out');
            },
          );
      if (response.statusCode == 200) {
        return Result.ok(
          StaffListResponse.fromJson(
            json.decode(utf8.decode(response.bodyBytes)),
          ),
        );
      }

      if (response.statusCode == 401) {
        return Result.error(UnauthorizedException());
      }

      final errorResponse = ErrorResponse.fromJson(
        json.decode(utf8.decode(response.bodyBytes)),
      );

      return Result.error(HttpException(errorResponse.error));
    } on Exception catch (_) {
      return Result.error(Exception('Failed to fetch staff list'));
    } finally {
      client.close();
    }
  }

  Future<Result<Uint8List>> downloadStaffImage(
    http.Client client,
    String url,
    String fileName,
  ) async {
    try {
      final response = await client
          .get(Uri.parse(url))
          .timeout(
            _downloadTimeout,
            onTimeout: () {
              throw TimeoutException('Request timed out');
            },
          );
      return Ok(response.bodyBytes);
    } catch (_) {
      return Error(Exception('Failed to download image'));
    }
  }
}
