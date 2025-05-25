import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'sign_up_page_widget.dart' show SignUpPageWidget;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class SignUpPageModel extends FlutterFlowModel<SignUpPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for name_Create widget.
  FocusNode? nameCreateFocusNode;
  TextEditingController? nameCreateTextController;
  String? Function(BuildContext, String?)?nameCreateTextControllerValidator;
  // State field(s) for emailAddress_Create widget.
  FocusNode? emailAddressCreateFocusNode;
  TextEditingController? emailAddressCreateTextController;
  String? Function(BuildContext, String?)?
  emailAddressCreateTextControllerValidator;
  // State field(s) for password_Create widget.
  FocusNode? passwordCreateFocusNode1;
  TextEditingController? passwordCreateTextController1;
  late bool passwordCreateVisibility1;
  String? Function(BuildContext, String?)?
  passwordCreateTextController1Validator;
  // State field(s) for password_Create widget.
  FocusNode? passwordCreateFocusNode2;
  TextEditingController? passwordCreateTextController2;
  late bool passwordCreateVisibility2;
  String? Function(BuildContext, String?)?
  passwordCreateTextController2Validator;
  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordCreateVisibility1 = false;
    passwordCreateVisibility2 = false;
    passwordVisibility = false;
    nameCreateTextController ??= TextEditingController();
    nameCreateFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    emailAddressCreateFocusNode?.dispose();
    emailAddressCreateTextController?.dispose();

    passwordCreateFocusNode1?.dispose();
    passwordCreateTextController1?.dispose();

    passwordCreateFocusNode2?.dispose();
    passwordCreateTextController2?.dispose();

    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    nameCreateTextController?.dispose();
    nameCreateFocusNode?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }

  Future<bool> registerUser(BuildContext context) async {
    final name = nameCreateTextController?.text.trim();
    final email = emailAddressCreateTextController?.text.trim();
    final pass1 = passwordCreateTextController1?.text;
    final pass2 = passwordCreateTextController2?.text;

    print('DEBUG - name: $name');
    print('DEBUG - email: $email');
    print('DEBUG - pass1: $pass1');
    print('DEBUG - pass2: $pass2');

    if ([name, email, pass1, pass2].any((e) => e == null || e.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All field must be filled')),
      );
      return false;
    }

    if (pass1 != pass2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password does not match')),
      );
      return false;
    }

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': pass1,
        'role': 'USER',
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);
      await prefs.setString('user_name', name ?? 'User');

      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration Failed: ${response.body}')),
      );
      return false;
    }
  }


  Future<bool> loginUser(BuildContext context) async {
    final email = emailAddressTextController?.text.trim();
    final password = passwordTextController?.text;

    if (email == null || password == null) return false;

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8000/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', token);

      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${response.body}')),
      );
      return false;
    }
  }
}