import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'accessories_page_widget.dart' show AccessoriesPageWidget;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReviewItem {
  final int reviewID;
  final String reviewTitle;
  final String imageName;
  final String cardDesc;

  ReviewItem({
    required this.reviewID,
    required this.reviewTitle,
    required this.imageName,
    required this.cardDesc,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      reviewID: json['reviewID'],
      reviewTitle: json['reviewTitle'] ?? '',
      imageName: json['imageName'] ?? '',
      cardDesc: json['cardDesc'] ?? '',
    );
  }
}

class AccessoriesPageModel extends FlutterFlowModel<AccessoriesPageWidget> with ChangeNotifier {
  // List data review accessories
  List<ReviewItem> reviews = [];

  // State loading & error
  bool isLoadingReviews = false;
  String? reviewsError;

  /// Fetch accessories reviews from API
  Future<void> fetchAccessoriesReviews() async {
    isLoadingReviews = true;
    reviewsError = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/get/review/accessories'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> reviewsJson = jsonResponse['reviews'] ?? [];

        reviews = reviewsJson.map((item) => ReviewItem.fromJson(item)).toList();

        print('Fetched accessories reviews count: ${reviews.length}');
      } else {
        reviewsError = 'Failed to load data: ${response.statusCode}';
        reviews = [];
      }
    } catch (e) {
      reviewsError = 'Error occurred: $e';
      reviews = [];
    } finally {
      isLoadingReviews = false;
      notifyListeners();
    }
  }

  @override
  void initState(BuildContext context) {
    // Optional: fetch reviews langsung saat model di-init
    fetchAccessoriesReviews();
  }

  @override
  void dispose() {
    super.dispose();
  }
}