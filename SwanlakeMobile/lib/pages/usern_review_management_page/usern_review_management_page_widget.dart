import 'package:swanlake/flutter_flow/flutter_flow_icon_button.dart';

import '../../flutter_flow/form_field_controller.dart';
import '../edit_form/edit_form_widget.dart';
import '../edit_user_page/edit_user_page_widget.dart';
import '../review_page/review_page_widget.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'usern_review_management_page_model.dart';

class UsernReviewManagementPageWidget extends StatefulWidget {
  const UsernReviewManagementPageWidget({super.key});

  static String routeName = 'UsernReviewManagementPage';
  static String routePath = '/usernReviewManagementPage';

  @override
  State<UsernReviewManagementPageWidget> createState() =>
      _UsernReviewManagementPageWidgetState();
}

class _UsernReviewManagementPageWidgetState
    extends State<UsernReviewManagementPageWidget> {
  late UsernReviewManagementPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = UsernReviewManagementPageModel();
    _model.choiceChipsValueController ??=
        FormFieldController<List<String>>(['Users']);
    _model.loadData();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void safeSetState(VoidCallback fn) {
    if (mounted) setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UsernReviewManagementPageModel>(
      create: (_) => _model,
      child: Consumer<UsernReviewManagementPageModel>(
        builder: (context, model, child) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              body: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 16, 16, 0),
                          child: Text(
                            'Admin Dashboard',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                              font: GoogleFonts.interTight(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16, 4, 16, 8),
                          child: FlutterFlowChoiceChips(
                            options: const [
                              ChipData('Users'),
                              ChipData('Reviews')
                            ],
                            onChanged: (val) async {
                              safeSetState(() =>
                              _model.choiceChipsValue = val?.firstOrNull);
                              await _model.loadData();
                              safeSetState(() {});
                            },
                            selectedChipStyle: ChipStyle(
                              backgroundColor:
                              FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontWeight,
                                color: FlutterFlowTheme.of(context).info,
                              ),
                              iconColor: FlutterFlowTheme.of(context).info,
                              iconSize: 18.0,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).accent1,
                              borderWidth: 1.0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            unselectedChipStyle: ChipStyle(
                              backgroundColor:
                              FlutterFlowTheme.of(context).alternate,
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryText,
                              ),
                              iconColor:
                              FlutterFlowTheme.of(context).secondaryText,
                              iconSize: 18.0,
                              elevation: 0.0,
                              borderColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderWidth: 1.0,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            chipSpacing: 8.0,
                            rowSpacing: 12.0,
                            multiselect: false,
                            initialized: _model.choiceChipsValue != null,
                            controller: _model.choiceChipsValueController!,
                            wrapped: true,
                          ),
                        ),
                        Expanded(
                          child: model.isLoading
                              ? const Center(child: CircularProgressIndicator())
                              : model.error != null
                              ? Center(child: Text(model.error!))
                              : model.choiceChipsValue == 'Users'
                              ? ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16),
                            itemCount: model.users.length,
                            itemBuilder: (context, index) {
                              final user = model.users[index];
                              return ListTile(
                                leading: const Icon(Icons.person),
                                title: Text(user.name),
                                subtitle: Text(
                                    '${user.email} - Role: ${user.role}'),
                                onTap: () {
                                  context.pushNamed(
                                    EditUserPageWidget.routeName,
                                    extra: {'accountID': user.accountID},
                                  );
                                },
                              );
                            },
                          )
                              : model.choiceChipsValue == 'Reviews'
                              ? ListView.builder(
                            padding:
                            const EdgeInsets.symmetric(
                                horizontal: 16),
                            itemCount: model.reviews.length,
                            itemBuilder: (context, index) {
                              final review =
                              model.reviews[index];
                              return ListTile(
                                leading: Image.network(
                                  review.imageName,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context,
                                      error,
                                      stackTrace) =>
                                  const Icon(
                                      Icons.broken_image),
                                ),
                                title:
                                Text(review.reviewTitle),
                                subtitle: Text(
                                    'Rating: ${review.rating}'),
                                onTap: () {
                                  context.pushNamed(
                                    EditFormWidget.routeName,
                                    extra: {'reviewID': review.reviewID},
                                  );
                                },
                              );
                            },
                          )
                              : const Center(
                              child: Text(
                                  'Pilih kategori di atas')),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: FlutterFlowIconButton(
                        borderColor: FlutterFlowTheme.of(context).alternate,
                        borderRadius: 12.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                        icon: Icon(
                          Icons.refresh,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () async {
                          await model.loadData();
                          safeSetState(() {});
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: model.choiceChipsValue == 'Users'
                            ? FFButtonWidget(
                          onPressed: () {
                            Navigator.pushNamed(context, 'AddUserPage');
                          },
                          text: 'Add User',
                          options: FFButtonOptions(
                            width: 170,
                            height: 40,
                            color: FlutterFlowTheme.of(context).accent1,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            elevation: 0,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        )
                            : model.choiceChipsValue == 'Reviews'
                            ? FFButtonWidget(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, 'PostFormPage');
                          },
                          text: 'Add Review',
                          options: FFButtonOptions(
                            width: 170,
                            height: 40,
                            color:
                            FlutterFlowTheme.of(context).accent1,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            elevation: 0,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}