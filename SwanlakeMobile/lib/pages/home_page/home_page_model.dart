import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ReviewItem {
  final String reviewTitle;
  final String imageName;
  final String cardDesc;

  ReviewItem({required this.reviewTitle, required this.imageName, required this.cardDesc,});

  factory ReviewItem.fromJson(Map<String, dynamic> json) {
    return ReviewItem(
      reviewTitle: json['reviewTitle'] ?? '',
      imageName: json['imageName'] ?? '',
      cardDesc: json['cardDesc'] ?? '',
    );
  }
}

class HomePageModel extends FlutterFlowModel<HomePageWidget> with ChangeNotifier {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Carousel widget.
  CarouselSliderController? carouselController;
  int carouselCurrentIndex = 1;

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];

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

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> reviewsJson = jsonResponse['reviews'] ?? [];

        reviews = reviewsJson
            .map((item) => ReviewItem.fromJson(item))
            .toList();

        //Print json di console
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
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
    super.dispose();
  }
}
