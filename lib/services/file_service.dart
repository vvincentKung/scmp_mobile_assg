import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scmp_mobile_assg/models/staff.dart';

class FileService {
  static final FileService _instance = FileService._internal();

  factory FileService() {
    return _instance;
  }

  FileService._internal();

  Future<File?> saveImageByByte(Uint8List bytes, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      debugPrint('Error saving image: $e');
      return null;
    }
  }

  Future<File?> saveStaffListAsJson(List<Staff> staffs, int page) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/staff_list_$page.json');
      final jsonString = jsonEncode(staffs.map((staff) => staff.toJson()).toList());
      await file.writeAsString(jsonString);
      return file;
    } catch (e) {
      debugPrint('Error saving staff list as JSON: $e');
      return null;      
    }
  }

  Future<List<Staff>> loadStaffListFromJson(int page) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/staff_list_$page.json');
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(jsonString);
        return jsonList.map((json) => Staff.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      debugPrint('Error loading staff list from JSON: $e');
      return [];
    }
  }
}
