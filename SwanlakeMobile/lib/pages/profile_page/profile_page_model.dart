import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  String userName = 'User';
  String userEmail = 'user@example.com';
  String userRole = ''; // tambah ini

  Future<void> fetchUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');

    if (token == null) return;

    final response = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/user'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      userName = data['name'];
      userEmail = data['email'];
      userRole = data['role'] ?? '';
    } else {
      print('Gagal fetch user: ${response.body}');
    }
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}