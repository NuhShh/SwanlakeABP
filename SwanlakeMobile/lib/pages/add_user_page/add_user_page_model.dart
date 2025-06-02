import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';

class AddUserPageModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  // Username
  FocusNode? fullNameFocusNode;
  TextEditingController? fullNameTextController;
  String? Function(BuildContext, String?)? fullNameTextControllerValidator =
      (context, val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the user\'s full name.';
    }
    return null;
  };

  // Email
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator =
      (context, val) {
    if (val == null || val.isEmpty) {
      return 'Please enter an email.';
    }
    if (!val.contains('@')) {
      return 'Enter a valid email address.';
    }
    return null;
  };

  // Password
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  String? Function(BuildContext, String?)? passwordTextControllerValidator =
      (context, val) {
    if (val == null || val.isEmpty) {
      return 'Please enter a password.';
    }
    if (val.length < 6) {
      return 'Password must be at least 6 characters.';
    }
    return null;
  };

  @override
  void dispose() {
    fullNameFocusNode?.dispose();
    fullNameTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    super.dispose();
  }
}