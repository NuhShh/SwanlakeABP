import '/flutter_flow/flutter_flow_util.dart';
import 'top_rated_page_widget.dart' show TopRatedPageWidget;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReviewItem {
  final int reviewID;
  final String reviewTitle;
  final String imageName;
  final String cardDesc;
  final double rating;

  ReviewItem({
    required this.reviewID,
    required this.reviewTitle,
    required this.imageName,
    required this.cardDesc,
    required this.rating,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      reviewID: json['reviewID'],
      reviewTitle: json['reviewTitle'] ?? '',
      imageName: json['imageName'] ?? '',
      cardDesc: json['cardDesc'] ?? '',
      rating: (json['rating'] as num).toDouble(),
    );
  }
}

class TopRatedPageModel extends FlutterFlowModel<TopRatedPageWidget> with ChangeNotifier {
  List<ReviewItem> reviews = [];
  bool isLoading = false;
  String? error;

  Future<void> fetchTopRatedReviews() async {
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
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['reviews'] ?? [];

        reviews = data
            .map((item) => ReviewItem.fromJson(item))
            .where((r) => r.rating >= 4.5)
            .toList()
          ..sort((a, b) => b.rating.compareTo(a.rating));

      } else {
        error = 'Gagal mengambil data: ${response.statusCode}';
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
    fetchTopRatedReviews();
  }

  @override
  void dispose() {}
}