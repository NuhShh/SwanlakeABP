import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'consoles_page_widget.dart' show ConsolesPageWidget;
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

class ConsolesPageModel extends FlutterFlowModel<ConsolesPageWidget> with ChangeNotifier {
  List<ReviewItem> reviews = [];
  bool isLoadingReviews = false;
  String? reviewsError;

  Future<void> fetchConsoleReviews() async {
    isLoadingReviews = true;
    reviewsError = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/get/review/console'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> reviewsJson = jsonResponse['reviews'] ?? [];

        reviews = reviewsJson.map((item) => ReviewItem.fromJson(item)).toList();

        print('Fetched console reviews count: ${reviews.length}');
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
    // Optional: langsung fetch data saat init
    fetchConsoleReviews();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
