import 'package:shared_preferences/shared_preferences.dart';

import '/flutter_flow/flutter_flow_util.dart';
import 'compare_page_widget.dart' show ComparePageWidget;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReviewItem {
  final int reviewID;
  final String reviewTitle;
  final String productName;
  final String productType;
  final String imageName;
  final String cardDesc;
  final String? processor;
  final String? processorDesc;
  final String? ram;
  final String? ramDesc;
  final String? storage;
  final String? storageDesc;
  final String? display;
  final String? displayDesc;
  final String? battery;
  final String? batteryDesc;
  final String? camera;
  final String? cameraDesc;

  ReviewItem({
    required this.reviewID,
    required this.reviewTitle,
    required this.productName,
    required this.productType,
    required this.imageName,
    required this.cardDesc,
    required this.processor,
    required this.processorDesc,
    required this.ram,
    required this.ramDesc,
    required this.storage,
    required this.storageDesc,
    required this.display,
    required this.displayDesc,
    required this.battery,
    required this.batteryDesc,
    required this.camera,
    required this.cameraDesc,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      reviewID: json['reviewID'],
      reviewTitle: json['reviewTitle'] ?? '',
      productName: json['productName'] ?? '',
      productType: json['productType'] ?? '',
      imageName: json['imageName'] ?? '',
      cardDesc: json['cardDesc'] ?? '',
      processor: json['processor'],
      processorDesc: json['processorDesc'],
      ram: json['ram'],
      ramDesc: json['ramDesc'],
      storage: json['storage'],
      storageDesc: json['storageDesc'],
      display: json['display'],
      displayDesc: json['displayDesc'],
      battery: json['battery'],
      batteryDesc: json['batteryDesc'],
      camera: json['camera'],
      cameraDesc: json['cameraDesc'],
    );
  }
}

class ComparePageModel extends FlutterFlowModel<ComparePageWidget> with ChangeNotifier{
  List<ReviewItem> reviews = [];
  bool isLoadingReviews = false;
  String? reviewsError;

  Future<void> fetchReviews() async {
    isLoadingReviews = true;
    reviewsError = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/get/review'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> reviewsJson = jsonResponse['reviews'] ?? [];

        reviews = reviewsJson
            .map((item) => ReviewItem.fromJson(item))
            .toList();

        print('Full JSON response: $jsonResponse');

      } else {
        reviewsError = 'Gagal load data: ${response.statusCode}';
      }
    } catch (e) {
      reviewsError = 'Terjadi kesalahan: $e';
    } finally {
      isLoadingReviews = false;
      notifyListeners();
    }
    print('Fetched reviews count: ${reviews.length}');
  }


  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    super.dispose();
  }
}
