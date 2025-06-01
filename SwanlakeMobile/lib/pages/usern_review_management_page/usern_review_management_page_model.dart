import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Model data UserItem
class UserItem {
  final int accountID;
  final String name;
  final String email;
  final String role;

  UserItem({
    required this.accountID,
    required this.name,
    required this.email,
    required this.role,
  });

  factory UserItem.fromJson(Map<String, dynamic> json) {
    return UserItem(
      accountID: json['accountID'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }
}

class ReviewItem {
  final int reviewID;
  final String reviewTitle;
  final String imageName;
  final String cardDesc;
  final DateTime created_at;
  final double rating;

  ReviewItem({
    required this.reviewID,
    required this.reviewTitle,
    required this.imageName,
    required this.cardDesc,
    required this.created_at,
    required this.rating,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      reviewID: json['reviewID'],
      reviewTitle: json['reviewTitle'] ?? '',
      imageName: json['imageName'] ?? '',
      cardDesc: json['cardDesc'] ?? '',
      created_at: json['created_at'] != null ? DateTime.parse(json['created_at']) : DateTime.now(),
      rating: json['rating'] != null ? (json['rating'] as num).toDouble() : 0.0,
    );
  }
}

class UsernReviewManagementPageModel extends ChangeNotifier {
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue => choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) => choiceChipsValueController?.value = val != null ? [val] : [];

  List<UserItem> users = [];
  List<ReviewItem> reviews = [];

  bool isLoading = false;
  String? error;

  Future<void> fetchUsers() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token') ?? '';

      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/api/get/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> usersJson = jsonResponse['users'] ?? [];
        users = usersJson.map((u) => UserItem.fromJson(u)).toList();

        print('Full JSON response: $jsonResponse');
      } else {
        error = 'Failed to load users: ${response.statusCode}';
      }
    } catch (e) {
      error = 'Error fetching users: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchReviews() async {
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
        final List<dynamic> reviewsJson = jsonResponse['reviews'] ?? [];
        reviews = reviewsJson.map((r) => ReviewItem.fromJson(r)).toList();

        print('Full JSON response: $jsonResponse');
      } else {
        error = 'Failed to load reviews: ${response.statusCode}';
      }
    } catch (e) {
      error = 'Error fetching reviews: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadData() async {
    if (choiceChipsValue == 'Users') {
      await fetchUsers();
    } else if (choiceChipsValue == 'Reviews') {
      await fetchReviews();
    }
  }

  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
    super.dispose();
  }
}