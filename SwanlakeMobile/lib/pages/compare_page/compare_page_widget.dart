import '../review_page/review_page_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'compare_page_model.dart';
export 'compare_page_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ComparePageWidget extends StatefulWidget {
  final int? reviewID;

  const ComparePageWidget({Key? key, this.reviewID}) : super(key: key);

  static String routeName = 'ComparePage';
  static String routePath = '/comparePage';

  @override
  State<ComparePageWidget> createState() => _ComparePageWidgetState();
}

class _ComparePageWidgetState extends State<ComparePageWidget> {
  late ComparePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? imageName;
  String? productType;
  late int reviewID;
  String? productName;
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

  String? error;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = ComparePageModel();  // Initialize model to call fetchReviews
    print('ComparePageWidget reviewID: ${widget.reviewID}');  // Debugging

    if (widget.reviewID != null) {
      fetchReviewDetail(widget.reviewID!);  // Fetch review details based on reviewID
      _model.fetchReviews().then((_) {
        // Once fetchReviews() is complete, notify listeners and update UI
        setState(() {});
      });
    } else {
      setState(() {
        error = 'Review ID tidak tersedia';
      });
    }
  }

  Future<void> fetchReviewDetail(int reviewID) async {
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

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final review = data['review'];

        setState(() {
          // Set proper data from the API response
          productName = review['productName'] ?? '';  // Set product name here
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
    return Scaffold(
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
          'Compare Products',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
            font: GoogleFonts.interTight(
              fontWeight: FlutterFlowTheme.of(context).headlineMedium.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
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
                  child: imageName != null && imageName!.isNotEmpty
                      ? Image.network(
                    imageName!,
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
                  )
                      : Container(
                    width: double.infinity,
                    height: 330.0,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image,
                        size: 100, color: Colors.grey),
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
                          productName ?? '',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium,
                        ),
                        Text(
                          productType ?? '',
                          style: FlutterFlowTheme.of(context)
                              .labelSmall,
                        ),
                        SizedBox(height: 12.0),
                        if (processor != null && processor!.isNotEmpty)
                          Text('Processor: $processor'),
                        if (ram != null && ram!.isNotEmpty)
                          Text('RAM: $ram'),
                        if (storage != null && storage!.isNotEmpty)
                          Text('Storage: $storage'),
                        if (display != null && display!.isNotEmpty)
                          Text('Display: $display'),
                        if (battery != null && battery!.isNotEmpty)
                          Text('Battery: $battery'),
                        if (camera != null && camera!.isNotEmpty)
                          Text('Camera: $camera'),
                      ],
                    ),
                  ),
                ),
              ),
              // ListView for products with the same type but different name
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                          'Other Products',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium,
                        ),
                        SizedBox(height: 8.0),
                        _model.reviews.isNotEmpty
                            ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: _model.reviews.length,
                          itemBuilder: (context, index) {
                            final review = _model.reviews[index];

                            // Debugging
                            print('Review ProductName: ${review.productName}');
                            print('Review ProductType: ${review.productType}');
                            print('Current ProductName: $productName');
                            print('Current ProductType: $productType');

                            if (review.productName != productName && review.productType == productType) {
                              return Card(
                                elevation: 4.0,
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: ListTile(
                                  contentPadding: EdgeInsets.all(8.0),
                                  leading: Image.network(
                                    review.imageName,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(review.productName),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (review.processor != null && review.processor!.isNotEmpty)
                                        Text('Processor: ${review.processor}'),
                                      if (review.ram != null && review.ram!.isNotEmpty)
                                        Text('RAM: ${review.ram}'),
                                      if (review.storage != null && review.storage!.isNotEmpty)
                                        Text('Storage: ${review.storage}'),
                                      if (review.display != null && review.display!.isNotEmpty)
                                        Text('Display: ${review.display}'),
                                      if (review.battery != null && review.battery!.isNotEmpty)
                                        Text('Battery: ${review.battery}'),
                                      if (review.camera != null && review.camera!.isNotEmpty)
                                        Text('Camera: ${review.camera}'),
                                    ],
                                  ),
                                  onTap: () {
                                    // Navigate to ReviewPageWidget with the corresponding reviewID
                                    context.pushNamed(
                                      ReviewPageWidget.routeName,
                                      extra: {'reviewID': review.reviewID},
                                    );
                                  },
                                ),
                              );
                            } else {
                              return SizedBox.shrink(); // If not matching, return empty widget
                            }
                          },
                        )
                            : Center(child: Text('No other products available')),
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
