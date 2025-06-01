import '/flutter_flow/flutter_flow_util.dart';
import 'latest_release_page_widget.dart' show LatestReleasePageWidget;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReviewItem {
  final int reviewID;
  final String reviewTitle;
  final String imageName;
  final String cardDesc;
  final String createdAt;

  ReviewItem({
    required this.reviewID,
    required this.reviewTitle,
    required this.imageName,
    required this.cardDesc,
    required this.createdAt,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      reviewID: json['reviewID'],
      reviewTitle: json['reviewTitle'] ?? '',
      imageName: json['imageName'] ?? '',
      cardDesc: json['cardDesc'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class LatestReleasePageModel extends FlutterFlowModel<LatestReleasePageWidget> with ChangeNotifier {
  List<ReviewItem> reviews = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchLatestReviews() async {
    isLoading = true;
    error = null;
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

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['reviews'] ?? [];

        reviews = data.map((item) => ReviewItem.fromJson(item)).toList();

        reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else {
        error = 'Gagal load data: ${response.statusCode}';
      }
    } catch (e) {
      error = 'Terjadi kesalahan: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void initState(BuildContext context) {
    fetchLatestReviews();
  }

  @override
  void dispose() {
    super.dispose();
  }
}