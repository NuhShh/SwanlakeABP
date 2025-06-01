import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'top_rated_page_model.dart';
export 'top_rated_page_model.dart';

class TopRatedPageWidget extends StatefulWidget {
  const TopRatedPageWidget({super.key});

  static String routeName = 'TopRatedPage';
  static String routePath = '/topRatedPage';

  @override
  State<TopRatedPageWidget> createState() => _TopRatedPageWidgetState();
}

class _TopRatedPageWidgetState extends State<TopRatedPageWidget>
    with TickerProviderStateMixin {
  late TopRatedPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TopRatedPageModel());
    _model.fetchTopRatedReviews();
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
                'Top Rated',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                  font: GoogleFonts.interTight(),
                ),
              ),
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: _model.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : _model.error != null
                  ? Center(child: Text(_model.error!))
                  : ListView.builder(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
                itemCount: _model.reviews.length,
                itemBuilder: (context, index) {
                  final review = _model.reviews[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      onTap: () {
                        context.pushNamed(
                          ReviewPageWidget.routeName,
                          extra: {'reviewID': review.reviewID},
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context)
                              .secondaryBackground,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              color: Color(0x520E151B),
                              offset: Offset(0, 2),
                            )
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
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
                                      style:
                                      FlutterFlowTheme.of(context).bodyMedium,
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      '⭐ ${review.rating.toStringAsFixed(1)}',
                                      style:
                                      FlutterFlowTheme.of(context).labelMedium,
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