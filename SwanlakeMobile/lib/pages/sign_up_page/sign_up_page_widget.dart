import '/auth/custom_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sign_up_page_model.dart';
export 'sign_up_page_model.dart';

class SignUpPageWidget extends StatefulWidget {
  const SignUpPageWidget({super.key});

  static String routeName = 'SignUpPage';
  static String routePath = '/signUpPage';

  @override
  State<SignUpPageWidget> createState() => _SignUpPageWidgetState();
}

class _SignUpPageWidgetState extends State<SignUpPageWidget>
    with TickerProviderStateMixin {
  late SignUpPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SignUpPageModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.nameCreateTextController ??= TextEditingController();
    _model.nameCreateFocusNode ??= FocusNode();

    _model.emailAddressCreateTextController ??= TextEditingController();
    _model.emailAddressCreateFocusNode ??= FocusNode();

    _model.passwordCreateTextController1 ??= TextEditingController();
    _model.passwordCreateFocusNode1 ??= FocusNode();

    _model.passwordCreateTextController2 ??= TextEditingController();
    _model.passwordCreateFocusNode2 ??= FocusNode();

    _model.emailAddressTextController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();

    _model.passwordTextController ??= TextEditingController();
    _model.passwordFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 1.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 80.0),
            end: Offset(0.0, 0.0),
          ),
          ScaleEffect(
            curve: Curves.easeInOut,
            delay: 150.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.8, 0.8),
            end: Offset(1.0, 1.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
      'columnOnPageLoadAnimation2': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          VisibilityEffect(duration: 300.ms),
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 300.0.ms,
            duration: 400.0.ms,
            begin: Offset(0.0, 20.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });
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
        body: SafeArea(
          top: true,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(32.0, 12.0, 32.0, 32.0),
                child: Container(
                  width: double.infinity,
                  height: 230.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primary,
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                    EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 72.0),
                    child: Text(
                      'SwanLake',
                      style: FlutterFlowTheme.of(context).displaySmall.override(
                        font: GoogleFonts.interTight(
                          fontWeight: FlutterFlowTheme.of(context)
                              .displaySmall
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .displaySmall
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context)
                            .displaySmall
                            .fontWeight,
                        fontStyle: FlutterFlowTheme.of(context)
                            .displaySmall
                            .fontStyle,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 170.0, 0.0, 0.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).width >= 768.0
                                ? 530.0
                                : 630.0,
                            constraints: BoxConstraints(
                              maxWidth: 570.0,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4.0,
                                  color: Color(0x33000000),
                                  offset: Offset(
                                    0.0,
                                    2.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 12.0, 0.0, 0.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment(0.0, 0),
                                    child: TabBar(
                                      isScrollable: true,
                                      labelColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      unselectedLabelColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      labelPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          32.0, 0.0, 32.0, 0.0),
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                        font: GoogleFonts.interTight(
                                          fontWeight:
                                          FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .fontWeight,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      unselectedLabelStyle: FlutterFlowTheme.of(
                                          context)
                                          .titleMedium
                                          .override(
                                        font: GoogleFonts.interTight(
                                          fontWeight:
                                          FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .fontWeight,
                                          fontStyle:
                                          FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .fontStyle,
                                        ),
                                        letterSpacing: 0.0,
                                        fontWeight:
                                        FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontWeight,
                                        fontStyle:
                                        FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .fontStyle,
                                      ),
                                      indicatorColor:
                                      FlutterFlowTheme.of(context)
                                          .primaryText,
                                      indicatorWeight: 3.0,
                                      tabs: [
                                        Tab(
                                          text: 'Create Account',
                                        ),
                                        Tab(
                                          text: 'Sign In',
                                        ),
                                      ],
                                      controller: _model.tabBarController,
                                      onTap: (i) async {
                                        [() async {}, () async {}][i]();
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      controller: _model.tabBarController,
                                      children: [
                                        Align(
                                          alignment:
                                          AlignmentDirectional(0.0, -1.0),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                24.0, 16.0, 24.0, 0.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  if (responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                    tablet: false,
                                                  ))
                                                    Container(
                                                      width: 230.0,
                                                      height: 40.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                    ),
                                                  Text(
                                                    'Create Account',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .headlineMedium
                                                        .override(
                                                      font: GoogleFonts
                                                          .interTight(
                                                        fontWeight:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .headlineMedium
                                                            .fontWeight,
                                                        fontStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .headlineMedium
                                                            .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .headlineMedium
                                                          .fontWeight,
                                                      fontStyle:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .headlineMedium
                                                          .fontStyle,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 4.0,
                                                        0.0, 24.0),
                                                    child: Text(
                                                      'Let\'s get started by filling out the form below.',
                                                      textAlign:
                                                      TextAlign.start,
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelMedium
                                                          .override(
                                                        font:
                                                        GoogleFonts
                                                            .inter(
                                                          fontWeight: FlutterFlowTheme.of(
                                                              context)
                                                              .labelMedium
                                                              .fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(
                                                              context)
                                                              .labelMedium
                                                              .fontStyle,
                                                        ),
                                                        letterSpacing:
                                                        0.0,
                                                        fontWeight: FlutterFlowTheme.of(
                                                            context)
                                                            .labelMedium
                                                            .fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(
                                                            context)
                                                            .labelMedium
                                                            .fontStyle,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                                                    child: TextFormField(
                                                      controller: _model.nameCreateTextController,
                                                      focusNode: _model.nameCreateFocusNode,
                                                      decoration: InputDecoration(
                                                        labelText: 'Username',
                                                        labelStyle: FlutterFlowTheme.of(context).labelLarge,
                                                        enabledBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: FlutterFlowTheme.of(context).alternate,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius: BorderRadius.circular(40.0),
                                                        ),
                                                        focusedBorder: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                            color: FlutterFlowTheme.of(context).primary,
                                                            width: 2.0,
                                                          ),
                                                          borderRadius: BorderRadius.circular(40.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                        contentPadding: EdgeInsets.all(24.0),
                                                      ),
                                                      style: FlutterFlowTheme.of(context).bodyLarge,
                                                      validator: _model.nameCreateTextControllerValidator?.asValidator(context),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 0.0,
                                                        0.0, 16.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .emailAddressCreateTextController,
                                                        focusNode: _model
                                                            .emailAddressCreateFocusNode,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.email
                                                        ],
                                                        obscureText: false,
                                                        decoration:
                                                        InputDecoration(
                                                          labelText: 'Email',
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelLarge
                                                              .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight: FlutterFlowTheme.of(
                                                                  context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(
                                                                  context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing:
                                                            0.0,
                                                            fontWeight: FlutterFlowTheme.of(
                                                                context)
                                                                .labelLarge
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                context)
                                                                .labelLarge
                                                                .fontStyle,
                                                          ),
                                                          enabledBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .alternate,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          focusedBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primary,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          errorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          focusedErrorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                          EdgeInsets.all(
                                                              24.0),
                                                        ),
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyLarge
                                                            .override(
                                                          font:
                                                          GoogleFonts
                                                              .inter(
                                                            fontWeight: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                          ),
                                                          letterSpacing:
                                                          0.0,
                                                          fontWeight: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyLarge
                                                              .fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                        ),
                                                        keyboardType:
                                                        TextInputType
                                                            .emailAddress,
                                                        validator: _model
                                                            .emailAddressCreateTextControllerValidator
                                                            .asValidator(
                                                            context),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 0.0,
                                                        0.0, 16.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .passwordCreateTextController1,
                                                        focusNode: _model
                                                            .passwordCreateFocusNode1,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.password
                                                        ],
                                                        obscureText: !_model
                                                            .passwordCreateVisibility1,
                                                        decoration:
                                                        InputDecoration(
                                                          labelText: 'Password',
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelLarge
                                                              .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight: FlutterFlowTheme.of(
                                                                  context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(
                                                                  context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing:
                                                            0.0,
                                                            fontWeight: FlutterFlowTheme.of(
                                                                context)
                                                                .labelLarge
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                context)
                                                                .labelLarge
                                                                .fontStyle,
                                                          ),
                                                          enabledBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .alternate,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          focusedBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primary,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          errorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          focusedErrorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                          EdgeInsets.all(
                                                              24.0),
                                                          suffixIcon: InkWell(
                                                            onTap: () =>
                                                                safeSetState(
                                                                      () => _model
                                                                      .passwordCreateVisibility1 =
                                                                  !_model
                                                                      .passwordCreateVisibility1,
                                                                ),
                                                            focusNode: FocusNode(
                                                                skipTraversal:
                                                                true),
                                                            child: Icon(
                                                              _model.passwordCreateVisibility1
                                                                  ? Icons
                                                                  .visibility_outlined
                                                                  : Icons
                                                                  .visibility_off_outlined,
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .secondaryText,
                                                              size: 24.0,
                                                            ),
                                                          ),
                                                        ),
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyLarge
                                                            .override(
                                                          font:
                                                          GoogleFonts
                                                              .inter(
                                                            fontWeight: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                          ),
                                                          letterSpacing:
                                                          0.0,
                                                          fontWeight: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyLarge
                                                              .fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                        ),
                                                        validator: _model
                                                            .passwordCreateTextController1Validator
                                                            .asValidator(
                                                            context),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 0.0,
                                                        0.0, 16.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .passwordCreateTextController2,
                                                        focusNode: _model
                                                            .passwordCreateFocusNode2,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.password
                                                        ],
                                                        obscureText: !_model
                                                            .passwordCreateVisibility2,
                                                        decoration:
                                                        InputDecoration(
                                                          labelText:
                                                          'Confirm Password',
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelLarge
                                                              .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight: FlutterFlowTheme.of(
                                                                  context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(
                                                                  context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing:
                                                            0.0,
                                                            fontWeight: FlutterFlowTheme.of(
                                                                context)
                                                                .labelLarge
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                context)
                                                                .labelLarge
                                                                .fontStyle,
                                                          ),
                                                          enabledBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .alternate,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          focusedBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primary,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          errorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          focusedErrorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                          EdgeInsets.all(
                                                              24.0),
                                                        ),
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyLarge
                                                            .override(
                                                          font:
                                                          GoogleFonts
                                                              .inter(
                                                            fontWeight: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                          ),
                                                          letterSpacing:
                                                          0.0,
                                                          fontWeight: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyLarge
                                                              .fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                        ),
                                                        validator: _model
                                                            .passwordCreateTextController2Validator
                                                            .asValidator(
                                                            context),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                    AlignmentDirectional(
                                                        0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                          16.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          final success = await _model.registerUser(context);
                                                          if (success && context.mounted) {
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(content: Text('Succesfully Registered! Please Login.')),
                                                            );
                                                            _model.nameCreateTextController?.clear();
                                                            _model.emailAddressCreateTextController?.clear();
                                                            _model.passwordCreateTextController1?.clear();
                                                            _model.passwordCreateTextController2?.clear();
                                                            _model.tabBarController?.animateTo(1);
                                                          }
                                                        },
                                                        text: 'Get Started',
                                                        options:
                                                        FFButtonOptions(
                                                          width: 230.0,
                                                          height: 52.0,
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              0.0),
                                                          iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              0.0),
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primary,
                                                          textStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .titleSmall
                                                              .override(
                                                            font: GoogleFonts
                                                                .interTight(
                                                              fontWeight: FlutterFlowTheme.of(
                                                                  context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(
                                                                  context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme.of(
                                                                context)
                                                                .primaryText,
                                                            letterSpacing:
                                                            0.0,
                                                            fontWeight: FlutterFlowTheme.of(
                                                                context)
                                                                .titleSmall
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                context)
                                                                .titleSmall
                                                                .fontStyle,
                                                          ),
                                                          elevation: 3.0,
                                                          borderSide:
                                                          BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              40.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                            'columnOnPageLoadAnimation1']!),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(0.0, -1.0),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                24.0, 16.0, 24.0, 0.0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  if (responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                    tablet: false,
                                                  ))
                                                    Container(
                                                      width: 230.0,
                                                      height: 40.0,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                    ),
                                                  Text(
                                                    'Welcome Back',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .headlineMedium
                                                        .override(
                                                      font: GoogleFonts
                                                          .interTight(
                                                        fontWeight:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .headlineMedium
                                                            .fontWeight,
                                                        fontStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .headlineMedium
                                                            .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .headlineMedium
                                                          .fontWeight,
                                                      fontStyle:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .headlineMedium
                                                          .fontStyle,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 4.0,
                                                        0.0, 24.0),
                                                    child: Text(
                                                      'Fill out the information below in order to access your account.',
                                                      textAlign:
                                                      TextAlign.start,
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelMedium
                                                          .override(
                                                        font:
                                                        GoogleFonts
                                                            .inter(
                                                          fontWeight: FlutterFlowTheme.of(
                                                              context)
                                                              .labelMedium
                                                              .fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(
                                                              context)
                                                              .labelMedium
                                                              .fontStyle,
                                                        ),
                                                        letterSpacing:
                                                        0.0,
                                                        fontWeight: FlutterFlowTheme.of(
                                                            context)
                                                            .labelMedium
                                                            .fontWeight,
                                                        fontStyle: FlutterFlowTheme.of(
                                                            context)
                                                            .labelMedium
                                                            .fontStyle,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 0.0,
                                                        0.0, 16.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .emailAddressTextController,
                                                        focusNode: _model
                                                            .emailAddressFocusNode,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.email
                                                        ],
                                                        obscureText: false,
                                                        decoration:
                                                        InputDecoration(
                                                          labelText: 'Email',
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelLarge
                                                              .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight: FlutterFlowTheme.of(
                                                                  context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(
                                                                  context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing:
                                                            0.0,
                                                            fontWeight: FlutterFlowTheme.of(
                                                                context)
                                                                .labelLarge
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                context)
                                                                .labelLarge
                                                                .fontStyle,
                                                          ),
                                                          enabledBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primaryBackground,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          focusedBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primary,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          errorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .alternate,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          focusedErrorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .alternate,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              24.0,
                                                              24.0,
                                                              0.0,
                                                              24.0),
                                                        ),
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyLarge
                                                            .override(
                                                          font:
                                                          GoogleFonts
                                                              .inter(
                                                            fontWeight: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                          ),
                                                          letterSpacing:
                                                          0.0,
                                                          fontWeight: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyLarge
                                                              .fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                        ),
                                                        keyboardType:
                                                        TextInputType
                                                            .emailAddress,
                                                        validator: _model
                                                            .emailAddressTextControllerValidator
                                                            .asValidator(
                                                            context),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 0.0,
                                                        0.0, 16.0),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .passwordTextController,
                                                        focusNode: _model
                                                            .passwordFocusNode,
                                                        autofocus: true,
                                                        autofillHints: [
                                                          AutofillHints.password
                                                        ],
                                                        obscureText: !_model
                                                            .passwordVisibility,
                                                        decoration:
                                                        InputDecoration(
                                                          labelText: 'Password',
                                                          labelStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .labelLarge
                                                              .override(
                                                            font: GoogleFonts
                                                                .inter(
                                                              fontWeight: FlutterFlowTheme.of(
                                                                  context)
                                                                  .labelLarge
                                                                  .fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(
                                                                  context)
                                                                  .labelLarge
                                                                  .fontStyle,
                                                            ),
                                                            letterSpacing:
                                                            0.0,
                                                            fontWeight: FlutterFlowTheme.of(
                                                                context)
                                                                .labelLarge
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                context)
                                                                .labelLarge
                                                                .fontStyle,
                                                          ),
                                                          enabledBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .alternate,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          focusedBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .primary,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          errorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          focusedErrorBorder:
                                                          OutlineInputBorder(
                                                            borderSide:
                                                            BorderSide(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2.0,
                                                            ),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                40.0),
                                                          ),
                                                          filled: true,
                                                          fillColor: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              24.0,
                                                              24.0,
                                                              0.0,
                                                              24.0),
                                                          suffixIcon: InkWell(
                                                            onTap: () =>
                                                                safeSetState(
                                                                      () => _model
                                                                      .passwordVisibility =
                                                                  !_model
                                                                      .passwordVisibility,
                                                                ),
                                                            focusNode: FocusNode(
                                                                skipTraversal:
                                                                true),
                                                            child: Icon(
                                                              _model.passwordVisibility
                                                                  ? Icons
                                                                  .visibility_outlined
                                                                  : Icons
                                                                  .visibility_off_outlined,
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .secondaryText,
                                                              size: 24.0,
                                                            ),
                                                          ),
                                                        ),
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyLarge
                                                            .override(
                                                          font:
                                                          GoogleFonts
                                                              .inter(
                                                            fontWeight: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyLarge
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                context)
                                                                .bodyLarge
                                                                .fontStyle,
                                                          ),
                                                          letterSpacing:
                                                          0.0,
                                                          fontWeight: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyLarge
                                                              .fontWeight,
                                                          fontStyle: FlutterFlowTheme.of(
                                                              context)
                                                              .bodyLarge
                                                              .fontStyle,
                                                        ),
                                                        validator: _model
                                                            .passwordTextControllerValidator
                                                            .asValidator(
                                                            context),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                    AlignmentDirectional(
                                                        0.0, 0.0),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0,
                                                          0.0,
                                                          0.0,
                                                          16.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          final success = await _model.loginUser(context);
                                                          if (success && context.mounted) {
                                                            context.goNamed(HomePageWidget.routeName);
                                                          }
                                                        },
                                                        text: 'Sign In',
                                                        options:
                                                        FFButtonOptions(
                                                          width: 230.0,
                                                          height: 52.0,
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              0.0),
                                                          iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              0.0),
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primary,
                                                          textStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .titleSmall
                                                              .override(
                                                            font: GoogleFonts
                                                                .interTight(
                                                              fontWeight: FlutterFlowTheme.of(
                                                                  context)
                                                                  .titleSmall
                                                                  .fontWeight,
                                                              fontStyle: FlutterFlowTheme.of(
                                                                  context)
                                                                  .titleSmall
                                                                  .fontStyle,
                                                            ),
                                                            color: FlutterFlowTheme.of(
                                                                context)
                                                                .primaryText,
                                                            letterSpacing:
                                                            0.0,
                                                            fontWeight: FlutterFlowTheme.of(
                                                                context)
                                                                .titleSmall
                                                                .fontWeight,
                                                            fontStyle: FlutterFlowTheme.of(
                                                                context)
                                                                .titleSmall
                                                                .fontStyle,
                                                          ),
                                                          elevation: 3.0,
                                                          borderSide:
                                                          BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              40.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                            'columnOnPageLoadAnimation2']!),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animateOnPageLoad(
                              animationsMap['containerOnPageLoadAnimation']!),
                        ),
                      ],
                    ),
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