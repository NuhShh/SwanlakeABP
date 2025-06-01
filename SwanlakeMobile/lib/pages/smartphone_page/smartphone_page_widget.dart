import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'smartphone_page_model.dart';
export 'smartphone_page_model.dart';

class SmartphonePageWidget extends StatefulWidget {
  const SmartphonePageWidget({super.key});

  static String routeName = 'SmartphonePage';
  static String routePath = '/smartphonePage';

  @override
  State<SmartphonePageWidget> createState() => _SmartphonePageWidgetState();
}

class _SmartphonePageWidgetState extends State<SmartphonePageWidget>
    with TickerProviderStateMixin {
  late SmartphonePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SmartphonePageModel());

    // Load data smartphone reviews saat widget di-init
    _model.fetchSmartphoneReviews();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.ms, begin: 0.0, end: 1.0),
          MoveEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.ms, begin: Offset(0, 50), end: Offset(0, 0)),
        ],
      ),
      'textOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.ms, begin: 0.0, end: 1.0),
          MoveEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.ms, begin: Offset(0, 60), end: Offset(0, 0)),
        ],
      ),
      'listViewOnPageLoadAnimation1': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.ms, begin: 0.0, end: 1.0),
          MoveEffect(curve: Curves.easeInOut, delay: 0.0.ms, duration: 600.ms, begin: Offset(0, 80), end: Offset(0, 0)),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
      anim.trigger == AnimationTrigger.onActionTrigger || !anim.applyInitialState),
      this,
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _model,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
              title: Text(
                'Smartphones',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                  font: GoogleFonts.interTight(
                    fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                    fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FlutterFlowTheme.of(context).titleLarge.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).titleLarge.fontStyle,
                ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: _model.isLoadingReviews
                  ? Center(child: CircularProgressIndicator())
                  : _model.reviewsError != null
                  ? Center(child: Text('Error: ${_model.reviewsError}'))
                  : ListView.builder(
                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: _model.reviews.length,
                itemBuilder: (context, index) {
                  final review = _model.reviews[index];
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 8),
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(
                          ReviewPageWidget.routeName,
                          extra: {'reviewID': review.reviewID},
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x520E151B),
                              offset: Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  review.imageName,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.broken_image, size: 50),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        review.reviewTitle,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 6),
                                      Text(
                                        review.cardDesc,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                          color:
                                          FlutterFlowTheme.of(context).secondaryText,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Read Now',
                                        style: FlutterFlowTheme.of(context)
                                            .labelSmall
                                            .override(
                                          color: FlutterFlowTheme.of(context).primaryText,
                                          fontWeight: FontWeight.w500,
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
                },
              ).animateOnPageLoad(animationsMap['listViewOnPageLoadAnimation1']!),
            ),
          ),
        );
      },
    );
  }
}