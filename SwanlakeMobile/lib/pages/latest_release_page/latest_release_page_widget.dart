import '../review_page/review_page_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'latest_release_page_model.dart';
export 'latest_release_page_model.dart';


class LatestReleasePageWidget extends StatefulWidget {
  const LatestReleasePageWidget({super.key});

  static String routeName = 'LatestReleasePage';
  static String routePath = '/latestReleasePage';

  @override
  State<LatestReleasePageWidget> createState() => _LatestReleasePageWidgetState();
}

class _LatestReleasePageWidgetState extends State<LatestReleasePageWidget>
    with TickerProviderStateMixin {
  late LatestReleasePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effectsBuilder: () => [
        FadeEffect(curve: Curves.easeInOut, delay: 0.ms, duration: 600.ms, begin: 0.0, end: 1.0),
        MoveEffect(curve: Curves.easeInOut, delay: 0.ms, duration: 600.ms, begin: Offset(0, 50), end: Offset(0, 0)),
      ],
    ),
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effectsBuilder: () => [
        FadeEffect(curve: Curves.easeInOut, delay: 0.ms, duration: 600.ms, begin: 0.0, end: 1.0),
        MoveEffect(curve: Curves.easeInOut, delay: 0.ms, duration: 600.ms, begin: Offset(0, 60), end: Offset(0, 0)),
      ],
    ),
    'listViewOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effectsBuilder: () => [
        FadeEffect(curve: Curves.easeInOut, delay: 0.ms, duration: 600.ms, begin: 0.0, end: 1.0),
        MoveEffect(curve: Curves.easeInOut, delay: 0.ms, duration: 600.ms, begin: Offset(0, 80), end: Offset(0, 0)),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LatestReleasePageModel());
    _model.fetchLatestReviews();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  String formatDate(String rawDate) {
    try {
      final dt = DateTime.parse(rawDate);
      return '${dt.day.toString().padLeft(2, '0')} ${_monthName(dt.month)} ${dt.year}';
    } catch (e) {
      return rawDate;
    }
  }

  String _monthName(int month) {
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _model,
      builder: (context, _) {
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
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 30,
                ),
                onPressed: () => context.safePop(),
              ),
              title: Text(
                'Latest Review',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                  font: GoogleFonts.interTight(),
                ),
              ),
              centerTitle: false,
              elevation: 0,
            ),
            body: SafeArea(
              child: _model.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _model.error != null
                  ? Center(child: Text(_model.error!))
                  : ListView.builder(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 24),
                itemCount: _model.reviews.length,
                itemBuilder: (context, index) {
                  final review = _model.reviews[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: InkWell(
                      onTap: () => context.pushNamed(
                        ReviewPageWidget.routeName,
                        extra: {'reviewID': review.reviewID},
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x520E151B),
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                review.imageName,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, _) =>
                                    Icon(Icons.broken_image),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Column(
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
                                      style: FlutterFlowTheme.of(context).bodyMedium,
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      'Reviewed on ${formatDate(review.createdAt)}',
                                      style: FlutterFlowTheme.of(context).labelMedium,
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
                },
              ),
            ),
          ),
        );
      },
    );
  }
}