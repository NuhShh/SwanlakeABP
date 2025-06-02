import 'package:shared_preferences/shared_preferences.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
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
  bool isLoading = false;
  late int accountID;
  late int loggedInAccountID;
  bool isLoggedInIDLoaded = false;
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

    initData(); // 👈 Load ID login dan detail user
  }

  Future<void> initData() async {
    await loadLoggedInAccountID();

    if (widget.accountID != null) {
      accountID = widget.accountID!;
      await fetchUserDetail();
    }
  }

  Future<void> loadLoggedInAccountID() async {
    final prefs = await SharedPreferences.getInstance();
    loggedInAccountID = prefs.getInt('account_id') ?? -1;
    print("🔐 loggedInAccountID loaded: $loggedInAccountID");
    setState(() {
      isLoggedInIDLoaded = true;
    });
  }

  Future<void> fetchUserDetail() async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) throw Exception('Token not found');

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
          selectedRole = role;
          _model.fullNameTextController.text = name ?? '';
          _model.emailTextController.text = email ?? '';
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      print("❌ Error fetchUserDetail: $e");
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
      if (token == null) throw Exception('Token not found');

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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User updated successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update user: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
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

    print("🗑️ Deleting user: accountID=$accountID, loggedInAccountID=$loggedInAccountID");

    if (accountID == loggedInAccountID) {
      print("🚫 BLOCKED: User tried to delete own account.");
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User deleted successfully")),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to delete user: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
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
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          title: Text(
            'Edit User With Id = $accountID',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              font: GoogleFonts.interTight(),
              letterSpacing: 0.0,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: FlutterFlowIconButton(
                icon: Icon(Icons.close_rounded),
                onPressed: () => context.pop(),
              ),
            ),
          ],
          elevation: 0,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : SafeArea(
          child: Form(
            key: _model.formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _model.fullNameTextController,
                          decoration: InputDecoration(labelText: 'Username'),
                        ),
                        SizedBox(height: 20),
                        Text('Role'),
                        DropdownButton<String>(
                          value: selectedRole,
                          onChanged: (newValue) =>
                              setState(() => selectedRole = newValue),
                          items: ['USER', 'ADMIN']
                              .map((role) => DropdownMenuItem(
                            value: role,
                            child: Text(role),
                          ))
                              .toList(),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _model.emailTextController,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _model.phoneNumberTextController,
                          decoration: InputDecoration(
                            labelText:
                            'Password (Leave empty to keep current)',
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: 20),
                        FFButtonWidget(
                          onPressed: updateUser,
                          text: 'Confirm',
                          options: FFButtonOptions(
                            width: 170,
                            height: 40,
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
                          onPressed: isLoggedInIDLoaded
                              ? () async {
                            bool? shouldDelete = await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Confirm Deletion'),
                                content: Text(
                                    'Are you sure you want to delete this user?'),
                                actions: [
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                  ),
                                ],
                              ),
                            );

                            if (shouldDelete == true) {
                              await deleteUser();
                            }
                          }
                              : null,
                          text: 'Delete This User',
                          options: FFButtonOptions(
                            width: 170,
                            height: 40,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
