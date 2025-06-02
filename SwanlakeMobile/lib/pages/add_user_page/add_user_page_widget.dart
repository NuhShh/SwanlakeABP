import 'package:shared_preferences/shared_preferences.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'add_user_page_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddUserPageWidget extends StatefulWidget {
  const AddUserPageWidget({Key? key}) : super(key: key);

  static String routeName = 'AddUserPage';
  static String routePath = '/addUserPage';

  @override
  State<AddUserPageWidget> createState() => _AddUserPageWidgetState();
}

class _AddUserPageWidgetState extends State<AddUserPageWidget> {
  late AddUserPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  String? selectedRole = 'USER';

  @override
  void initState() {
    super.initState();
    _model = AddUserPageModel();

    _model.fullNameTextController ??= TextEditingController();
    _model.emailTextController ??= TextEditingController();
    _model.passwordTextController ??= TextEditingController();

    _model.fullNameFocusNode ??= FocusNode();
    _model.emailFocusNode ??= FocusNode();
    _model.passwordFocusNode ??= FocusNode();
  }

  Future<void> createUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/register'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          'name': _model.fullNameTextController.text,
          'role': selectedRole ?? 'USER',
          'email': _model.emailTextController.text,
          'password': _model.passwordTextController.text,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User created successfully")),
        );
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to create user: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New User',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                font: GoogleFonts.interTight(),
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 12.0, 8.0),
            child: FlutterFlowIconButton(
              borderColor: FlutterFlowTheme.of(context).alternate,
              borderRadius: 12.0,
              borderWidth: 1.0,
              buttonSize: 40.0,
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              icon: Icon(
                Icons.close_rounded,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24.0,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: SafeArea(
        top: true,
        child: Form(
          key: _model.formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _model.fullNameTextController,
                              decoration: InputDecoration(
                                labelText: 'Username',
                              ),
                            ),
                            SizedBox(height: 20),
                            Text('Role'),
                            DropdownButton<String>(
                              value: selectedRole,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedRole = newValue;
                                });
                              },
                              items: <String>['USER', 'ADMIN']
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _model.emailTextController,
                              decoration: InputDecoration(
                                labelText: 'Email',
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: _model.passwordTextController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                              ),
                              obscureText: true,
                            ),
                            SizedBox(height: 20),
                            FFButtonWidget(
                              onPressed: isLoading ? null : createUser,
                              text: isLoading ? 'Loading...' : 'Confirm',
                              options: FFButtonOptions(
                                width: 170.0,
                                height: 40.0,
                                color: FlutterFlowTheme.of(context).primary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                                elevation: 0,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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