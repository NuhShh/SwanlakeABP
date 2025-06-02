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
  const ComparePageWidget({Key? key}) : super(key: key);

  static String routeName = 'ComparePage';
  static String routePath = '/comparePage';

  @override
  State<ComparePageWidget> createState() => _ComparePageWidgetState();
}

class _ComparePageWidgetState extends State<ComparePageWidget> {
  late ComparePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> comparedReviews = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ComparePageModel());
    fetchComparedReviews();
  }

  Future<void> fetchComparedReviews() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList('compare_ids') ?? [];

    List<Map<String, dynamic>> results = [];

    for (final id in ids) {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/get/review/$id'),
        headers: {
          'Authorization': 'Bearer ${prefs.getString('auth_token')}',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        results.add(json['review']);
      }
    }

    setState(() {
      comparedReviews = results;
      isLoading = false;
    });
  }

  Widget compareItem(Map<String, dynamic> review) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(review['productName'] ?? '',
              style: FlutterFlowTheme.of(context).titleMedium),
          SizedBox(height: 6),
          Text('Processor: ${review['processor'] ?? ''}',
              style: FlutterFlowTheme.of(context).bodyMedium),
          if ((review['processorDesc'] ?? '').toString().isNotEmpty)
            Text(review['processorDesc'],
                style: FlutterFlowTheme.of(context).bodySmall),
          SizedBox(height: 6),
          Text('RAM: ${review['ram'] ?? ''}',
              style: FlutterFlowTheme.of(context).bodyMedium),
          if ((review['ramDesc'] ?? '').toString().isNotEmpty)
            Text(review['ramDesc'],
                style: FlutterFlowTheme.of(context).bodySmall),
          SizedBox(height: 6),
          Text('Storage: ${review['storage'] ?? ''}',
              style: FlutterFlowTheme.of(context).bodyMedium),
          if ((review['storageDesc'] ?? '').toString().isNotEmpty)
            Text(review['storageDesc'],
                style: FlutterFlowTheme.of(context).bodySmall),
          SizedBox(height: 6),
          Text('Display: ${review['display'] ?? ''}',
              style: FlutterFlowTheme.of(context).bodyMedium),
          if ((review['displayDesc'] ?? '').toString().isNotEmpty)
            Text(review['displayDesc'],
                style: FlutterFlowTheme.of(context).bodySmall),
          SizedBox(height: 6),
          Text('Battery: ${review['battery'] ?? ''}',
              style: FlutterFlowTheme.of(context).bodyMedium),
          if ((review['batteryDesc'] ?? '').toString().isNotEmpty)
            Text(review['batteryDesc'],
                style: FlutterFlowTheme.of(context).bodySmall),
          SizedBox(height: 6),
          Text('Camera: ${review['camera'] ?? ''}',
              style: FlutterFlowTheme.of(context).bodyMedium),
          if ((review['cameraDesc'] ?? '').toString().isNotEmpty)
            Text(review['cameraDesc'],
                style: FlutterFlowTheme.of(context).bodySmall),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          leading: FlutterFlowIconButton(
            icon: Icon(Icons.arrow_back_rounded,
                color: FlutterFlowTheme.of(context).primaryText),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Compare Products',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
              font: GoogleFonts.interTight(),
            ),
          ),
          elevation: 0.0,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : comparedReviews.isEmpty
            ? Center(child: Text('No products to compare.'))
            : ListView.builder(
          itemCount: comparedReviews.length,
          itemBuilder: (context, index) {
            return compareItem(comparedReviews[index]);
          },
        ),
      ),
    );
  }
}
