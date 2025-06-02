import 'package:shared_preferences/shared_preferences.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_user_page_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditUserPageWidget extends StatefulWidget {
  final int? accountID;

  const EditUserPageWidget({Key? key, this.accountID}) : super(key: key);

  static String routeName = 'EditUserPage';
  static String routePath = '/editUserPage';

  @override
  State<EditUserPageWidget> createState() => _EditUserPageWidgetState();
}

class _EditUserPageWidgetState extends State<EditUserPageWidget> {
  late EditUserPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? name;
  String? role;
  String? email;
  String? password;
  bool isLoading = false;
  late int accountID;
  String? error;
  String? selectedRole;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditUserPageModel());

    _model.fullNameTextController ??= TextEditingController();
    _model.emailTextController ??= TextEditingController();
    _model.phoneNumberTextController ??= TextEditingController();
    _model.fullNameFocusNode ??= FocusNode();
    _model.emailFocusNode ??= FocusNode();
    _model.phoneNumberFocusNode ??= FocusNode();

    if (widget.accountID != null) {
      accountID = widget.accountID!;
      fetchUserDetail();
    }
  }

  Future<void> fetchUserDetail() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/get/user/$accountID'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final user = data['user'];

        setState(() {
          name = user['name'];
          role = user['role'];
          email = user['email'];
          selectedRole = role;  // Set default role to the current role
          _model.fullNameTextController.text = name ?? '';
          _model.emailTextController.text = email ?? '';
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        throw Exception('Token not found');
      }

      final response = await http.put(
        Uri.parse('http://10.0.2.2:8000/api/update/user/$accountID'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          'name': _model.fullNameTextController.text,
          'role': selectedRole ?? role!,
          'email': _model.emailTextController.text,
          if (_model.phoneNumberTextController.text.isNotEmpty)
            'password': _model.phoneNumberTextController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Optionally show success SnackBar or dialog
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User updated successfully")));
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed to update user: ${response.body}")));
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

  Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }

    // Check if the user is trying to delete their own account
    if (accountID == widget.accountID) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("You cannot delete your own account."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    try {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/api/delete/user/$accountID'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("User deleted successfully")));
        Navigator.pop(context); // Go back to the previous screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed to delete user: ${response.body}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: $e")));
    }
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
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
                'Edit User With Id = $accountID',
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
                  fontStyle:
                  FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 12.0, 8.0),
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
                                controller: _model.phoneNumberTextController,
                                decoration: InputDecoration(
                                  labelText: 'Password (Leave empty to keep current)',
                                ),
                                obscureText: true,
                              ),
                              SizedBox(height: 20),
                              FFButtonWidget(
                                onPressed: updateUser,
                                text: 'Confirm',
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
                              SizedBox(height: 20),
                              FFButtonWidget(
                                onPressed: () async {
                                  // Show confirmation dialog
                                  bool? shouldDelete = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Confirm Deletion'),
                                        content: Text(
                                            'Are you sure you want to delete this user?'),
                                        actions: [
                                          TextButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                          ),
                                          TextButton(
                                            child: Text('Delete'),
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (shouldDelete == true) {
                                    await deleteUser();
                                  }
                                },
                                text: 'Delete This User',
                                options: FFButtonOptions(
                                  width: 170.0,
                                  height: 40.0,
                                  color: Colors.red,
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
      ),
    );
  }
}