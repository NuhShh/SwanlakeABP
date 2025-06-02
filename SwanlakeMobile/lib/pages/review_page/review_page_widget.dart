import '/components/comments_thread/comments_thread_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'review_page_model.dart';
export 'review_page_model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';

class ReviewPageWidget extends StatefulWidget {
  final int? reviewID;

  const ReviewPageWidget({Key? key, this.reviewID}) : super(key: key);

  static String routeName = 'ReviewPage';
  static String routePath = '/reviewPage';

  @override
  State<ReviewPageWidget> createState() => _ReviewPageWidgetState();
}

class _ReviewPageWidgetState extends State<ReviewPageWidget> {
  late ReviewPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? imageName;
  String? productType;
  late int reviewID;
  String? reviewTitle;
  String? reviewText;
  double? reviewRating;
  String? processor;
  String? processorDesc;
  String? ram;
  String? ramDesc;
  String? storage;
  String? storageDesc;
  String? display;
  String? displayDesc;
  String? battery;
  String? batteryDesc;
  String? camera;
  String? cameraDesc;

  bool isLoading = false;
  String? error;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReviewPageModel());

    if (widget.reviewID != null) {
      reviewID = widget.reviewID!;
      fetchReviewDetail();
    } else {
      error = 'Review ID tidak tersedia';
    }
  }

  Future<void> fetchReviewDetail() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');

      if (token == null) throw Exception('Token not found');

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/get/review/$reviewID'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('Response review detail: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final review = data['review'];

        setState(() {
          reviewTitle = review['reviewTitle'] ?? '';
          reviewText = review['reviewText'] ?? '';
          imageName = review['imageName'] ?? '';
          productType = review['productType'] ?? '';
          reviewRating = (review['rating'] as num?)?.toDouble() ?? 0.0;
          processor = review['processor'] ?? '';
          processorDesc = review['processorDesc'] ?? '';
          ram = review['ram'] ?? '';
          ramDesc = review['ramDesc'] ?? '';
          storage = review['storage'] ?? '';
          storageDesc = review['storageDesc'] ?? '';
          display = review['display'] ?? '';
          displayDesc = review['displayDesc'] ?? '';
          battery = review['battery'] ?? '';
          batteryDesc = review['batteryDesc'] ?? '';
          camera = review['camera'] ?? '';
          cameraDesc = review['cameraDesc'] ?? '';
        });
      } else {
        throw Exception('Failed to load review: ${response.statusCode}');
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

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Widget specRow(String label, String value, String? desc) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: $value',
            style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (desc != null && desc.isNotEmpty)
            Text(
              desc,
              style: FlutterFlowTheme.of(context).bodyMedium,
            ),
        ],
      ),
    );
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
            'Details',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              font: GoogleFonts.interTight(
                fontWeight:
                FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                fontStyle:
                FlutterFlowTheme.of(context).headlineMedium.fontStyle,
              ),
              letterSpacing: 0.0,
            ),
          ),
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : error != null
              ? Center(child: Text('Error: $error'))
              : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      imageName ?? '',
                      width: double.infinity,
                      height: 330.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                            width: double.infinity,
                            height: 330.0,
                            color: Colors.grey[300],
                            child: Icon(Icons.broken_image,
                                size: 100, color: Colors.grey),
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .secondaryBackground,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            reviewTitle ?? '',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium,
                          ),
                          Text(
                            productType ?? '',
                            style: FlutterFlowTheme.of(context)
                                .labelSmall,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0),
                            child: RatingBar.builder(
                              onRatingUpdate: (newValue) => {},
                              itemBuilder: (context, index) => Icon(
                                Icons.star_rounded,
                                color: FlutterFlowTheme.of(context)
                                    .warning,
                              ),
                              direction: Axis.horizontal,
                              initialRating:
                              _model.ratingBarValue ??=
                                  reviewRating ?? 0.0,
                              allowHalfRating: true,
                              ignoreGestures: true,
                              unratedColor:
                              FlutterFlowTheme.of(context)
                                  .alternate,
                              itemCount: 5,
                              itemSize: 24.0,
                              glowColor:
                              FlutterFlowTheme.of(context)
                                  .warning,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor:
                                      Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return Padding(
                                          padding:
                                          MediaQuery.viewInsetsOf(
                                              context),
                                          child:
                                          CommentsThreadWidget(),
                                        );
                                      },
                                    ).then((value) =>
                                        safeSetState(() {}));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.comment,
                                        color:
                                        FlutterFlowTheme.of(
                                            context)
                                            .primaryText,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Comments',
                                        style:
                                        FlutterFlowTheme.of(
                                            context)
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Description',
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              reviewText ?? '',
                              textAlign: TextAlign.justify,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Specifications',
                            style: FlutterFlowTheme.of(context)
                                .bodySmall
                                .copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          if (processor != null && processor!.isNotEmpty)
                            specRow('Processor', processor!, processorDesc),
                          if (ram != null && ram!.isNotEmpty)
                            specRow('RAM', ram!, ramDesc),
                          if (storage != null && storage!.isNotEmpty)
                            specRow('Storage', storage!, storageDesc),
                          if (display != null && display!.isNotEmpty)
                            specRow('Display', display!, displayDesc),
                          if (battery != null && battery!.isNotEmpty)
                            specRow('Battery', battery!, batteryDesc),
                          if (camera != null && camera!.isNotEmpty)
                            specRow('Camera', camera!, cameraDesc),
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                context.pushNamed(
                                    ComparePageWidget.routeName);
                              },
                              text: 'Compare Products',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 40.0,
                                color:
                                FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                textStyle:
                                FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .copyWith(
                                  color:
                                  FlutterFlowTheme.of(
                                      context)
                                      .primaryText,
                                ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color:
                                  FlutterFlowTheme.of(context)
                                      .primaryText,
                                ),
                                borderRadius:
                                BorderRadius.circular(8.0),
                              ),
                            ),
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
      ),
    );
  }
}
