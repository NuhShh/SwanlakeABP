import 'package:shared_preferences/shared_preferences.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'change_password_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({super.key});

  static String routeName = 'ChangePassword';
  static String routePath = '/changePassword';

  @override
  State<ChangePasswordWidget> createState() => _ChangePasswordWidgetState();
}

class _ChangePasswordWidgetState extends State<ChangePasswordWidget> {
  late ChangePasswordModel _model;

  late String userName;
  late String userEmail;
  late String userRole;
  String password = '';
  late int accountID;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChangePasswordModel());

    _model.emailAddresTextController ??= TextEditingController();
    _model.emailAddresFocusNode ??= FocusNode();

    _model.emailAddressTextController1 ??= TextEditingController();
    _model.emailAddressFocusNode1 ??= FocusNode();

    _model.emailAddressTextController2 ??= TextEditingController();
    _model.emailAddressFocusNode2 ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> updatePassword() async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      // Fetch user data to get userName, userEmail, userRole, accountID
      final responseAccount = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (responseAccount.statusCode == 200) {
        final data = jsonDecode(responseAccount.body);
        userName = data['name'];
        userEmail = data['email'];
        userRole = data['role'] ?? '';
        password = data['password'] ?? '';
        accountID = data['accountID'] ?? 0;
      } else {
        print('Gagal fetch user: ${responseAccount.body}');
      }

      // Sending the updated data
      final response = await http.put(
        Uri.parse('http://10.0.2.2:8000/api/update/user/$accountID'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          'name': userName,
          'email': userEmail,
          'role': userRole,
          'password': _model.emailAddressTextController1?.text ?? '',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password berhasil diperbarui")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal memperbarui password: ${response.body}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30.0,
          ),
          onPressed: () async {
            context.safePop();
          },
        ),
        actions: [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Align(
        alignment: AlignmentDirectional(0.0, -1.0),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: 570.0,
          ),
          decoration: BoxDecoration(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                child: Text(
                  'Change Password',
                  style: FlutterFlowTheme.of(context).headlineMedium.override(
                    font: GoogleFonts.interTight(
                      fontWeight: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .fontWeight,
                      fontStyle: FlutterFlowTheme.of(context)
                          .headlineMedium
                          .fontStyle,
                    ),
                    letterSpacing: 0.0,
                    fontWeight: FlutterFlowTheme.of(context)
                        .headlineMedium
                        .fontWeight,
                    fontStyle: FlutterFlowTheme.of(context)
                        .headlineMedium
                        .fontStyle,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: TextFormField(
                  controller: _model.emailAddressTextController1,
                  focusNode: _model.emailAddressFocusNode1,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                    hintText: 'Enter your new password',
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    contentPadding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 20.0, 24.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
                child: TextFormField(
                  controller: _model.emailAddressTextController2,
                  focusNode: _model.emailAddressFocusNode2,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm your new password';
                    }
                    if (value != _model.emailAddressTextController1?.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Confirm New Password',
                    labelStyle: FlutterFlowTheme.of(context).labelMedium,
                    hintText: 'Confirm your new password',
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    contentPadding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 20.0, 24.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium,
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () {
                    // Validasi form sebelum update password
                    if ((_model.emailAddressTextController1?.text.isEmpty ?? true) ||
                        (_model.emailAddressTextController2?.text.isEmpty ?? true)) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill in all fields')));
                    } else if (_model.emailAddressTextController1?.text != _model.emailAddressTextController2?.text) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Passwords do not match')));
                    } else {
                      updatePassword();
                    }
                  },
                  text: 'Confirm',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50.0,
                    color: FlutterFlowTheme.of(context).primary,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.interTight(
                        fontWeight: FlutterFlowTheme.of(context)
                            .titleSmall
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .titleSmall
                            .fontStyle,
                      ),
                    ),
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}