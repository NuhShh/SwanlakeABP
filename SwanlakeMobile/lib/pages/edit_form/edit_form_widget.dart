import 'package:shared_preferences/shared_preferences.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EditFormWidget extends StatefulWidget {
  final int? reviewID;

  const EditFormWidget({Key? key, this.reviewID}) : super(key: key);

  static String routeName = 'EditForm';
  static String routePath = '/editForm';

  @override
  State<EditFormWidget> createState() => _EditFormWidgetState();
}

class _EditFormWidgetState extends State<EditFormWidget> {
  late TextEditingController productNameController;
  late TextEditingController reviewTitleController;
  late TextEditingController cardDescController;
  late TextEditingController processorController;
  late TextEditingController processorDescController;
  late TextEditingController ramController;
  late TextEditingController ramDescController;
  late TextEditingController storageController;
  late TextEditingController storageDescController;
  late TextEditingController displayController;
  late TextEditingController displayDescController;
  late TextEditingController batteryController;
  late TextEditingController batteryDescController;
  late TextEditingController cameraController;
  late TextEditingController cameraDescController;
  late TextEditingController priceController;
  late TextEditingController reviewTextController;
  late TextEditingController imageNameController;
  late TextEditingController keyFeaturesController;
  late TextEditingController performanceController;
  late TextEditingController ratingController;

  String? error;
  bool isLoading = false;
  late int reviewID;
  String selectedProductType = 'Smartphone';  // Set default value

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController();
    reviewTitleController = TextEditingController();
    cardDescController = TextEditingController();
    processorController = TextEditingController();
    processorDescController = TextEditingController();
    ramController = TextEditingController();
    ramDescController = TextEditingController();
    storageController = TextEditingController();
    storageDescController = TextEditingController();
    displayController = TextEditingController();
    displayDescController = TextEditingController();
    batteryController = TextEditingController();
    batteryDescController = TextEditingController();
    cameraController = TextEditingController();
    cameraDescController = TextEditingController();
    priceController = TextEditingController();
    reviewTextController = TextEditingController();
    imageNameController = TextEditingController();
    keyFeaturesController = TextEditingController();
    performanceController = TextEditingController();
    ratingController = TextEditingController();

    if (widget.reviewID != null) {
      reviewID = widget.reviewID!;
      fetchReviewDetail();
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
      if (token == null) {
        throw Exception('Token not found');
      }

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
          productNameController.text = review['productName'] ?? '';
          selectedProductType = review['productType'] ?? 'Smartphone'; // Set default
          reviewTitleController.text = review['reviewTitle'] ?? '';
          cardDescController.text = review['cardDesc'] ?? '';
          processorController.text = review['processor'] ?? '';
          processorDescController.text = review['processorDesc'] ?? '';
          ramController.text = review['ram'] ?? '';
          ramDescController.text = review['ramDesc'] ?? '';
          storageController.text = review['storage'] ?? '';
          storageDescController.text = review['storageDesc'] ?? '';
          displayController.text = review['display'] ?? '';
          displayDescController.text = review['displayDesc'] ?? '';
          batteryController.text = review['battery'] ?? '';
          batteryDescController.text = review['batteryDesc'] ?? '';
          cameraController.text = review['camera'] ?? '';
          cameraDescController.text = review['cameraDesc'] ?? '';
          priceController.text = review['price'].toString() ?? '';
          reviewTextController.text = review['reviewText'] ?? '';
          imageNameController.text = review['imageName'] ?? '';
          keyFeaturesController.text = review['keyFeatures'] ?? '';
          performanceController.text = review['performance'] ?? '';
          ratingController.text = review['rating']?.toString() ?? '';
        });
      } else {
        throw Exception('Failed to load review data');
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

  List<String> productTypes = ['Smartphone', 'Desktop & Laptop', 'Accessories', 'Console'];

  Future<void> updateReview() async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        throw Exception('Token not found');
      }

      double? parsedRating;
      if (ratingController.text.isNotEmpty) {
        parsedRating = double.tryParse(ratingController.text);
        if (parsedRating == null) {
          throw Exception('Invalid rating entered. Rating must be a valid number.');
        }
      }

      int? parsedPrice;
      if (priceController.text.isNotEmpty) {
        parsedPrice = int.tryParse(priceController.text);
        if (parsedPrice == null) {
          throw Exception('Invalid price entered. Price must be a valid integer.');
        }
      }

      final response = await http.put(
        Uri.parse('http://10.0.2.2:8000/api/update/review/$reviewID'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        body: {
          'productName': productNameController.text,
          'productType': selectedProductType ?? 'Smartphone',
          'reviewTitle': reviewTitleController.text,
          'cardDesc': cardDescController.text,
          'processor': processorController.text,
          'processorDesc': processorDescController.text,
          'ram': ramController.text,
          'ramDesc': ramDescController.text,
          'storage': storageController.text,
          'storageDesc': storageDescController.text,
          'display': displayController.text,
          'displayDesc': displayDescController.text,
          'battery': batteryController.text,
          'batteryDesc': batteryDescController.text,
          'camera': cameraController.text,
          'cameraDesc': cameraDescController.text,
          'price': priceController.text,
          'reviewText': reviewTextController.text,
          'imageName': imageNameController.text,
          'keyFeatures': keyFeaturesController.text,
          'performance': performanceController.text,
          'rating': parsedRating?.toString() ?? '',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Review updated successfully")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed to update review: ${response.body}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteReview() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token == null) {
      throw Exception('Token not found');
    }

    try {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/api/delete/review/$reviewID'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Review deleted successfully")));
        Navigator.pop(context); // Go back to the previous screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failed to delete review: ${response.body}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: $e")));
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    reviewTitleController.dispose();
    cardDescController.dispose();
    processorController.dispose();
    processorDescController.dispose();
    ramController.dispose();
    ramDescController.dispose();
    storageController.dispose();
    storageDescController.dispose();
    displayController.dispose();
    displayDescController.dispose();
    batteryController.dispose();
    batteryDescController.dispose();
    cameraController.dispose();
    cameraDescController.dispose();
    priceController.dispose();
    reviewTextController.dispose();
    imageNameController.dispose();
    keyFeaturesController.dispose();
    performanceController.dispose();
    ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Review With Id = $reviewID")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: productNameController,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              DropdownButtonFormField<String>(
                value: selectedProductType,
                decoration: InputDecoration(labelText: 'Product Type'),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedProductType = newValue!;
                  });
                },
                items: productTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                controller: reviewTitleController,
                decoration: InputDecoration(labelText: 'Review Title'),
              ),
              TextFormField(
                controller: cardDescController,
                decoration: InputDecoration(labelText: 'Card Description'),
              ),
              TextFormField(
                controller: processorController,
                decoration: InputDecoration(labelText: 'Processor'),
              ),
              TextFormField(
                controller: processorDescController,
                decoration: InputDecoration(labelText: 'Processor Description'),
              ),
              TextFormField(
                controller: ramController,
                decoration: InputDecoration(labelText: 'RAM'),
              ),
              TextFormField(
                controller: ramDescController,
                decoration: InputDecoration(labelText: 'RAM Description'),
              ),
              TextFormField(
                controller: storageController,
                decoration: InputDecoration(labelText: 'Storage'),
              ),
              TextFormField(
                controller: storageDescController,
                decoration: InputDecoration(labelText: 'Storage Description'),
              ),
              TextFormField(
                controller: displayController,
                decoration: InputDecoration(labelText: 'Display'),
              ),
              TextFormField(
                controller: displayDescController,
                decoration: InputDecoration(labelText: 'Display Description'),
              ),
              TextFormField(
                controller: batteryController,
                decoration: InputDecoration(labelText: 'Battery'),
              ),
              TextFormField(
                controller: batteryDescController,
                decoration: InputDecoration(labelText: 'Battery Description'),
              ),
              TextFormField(
                controller: cameraController,
                decoration: InputDecoration(labelText: 'Camera'),
              ),
              TextFormField(
                controller: cameraDescController,
                decoration: InputDecoration(labelText: 'Camera Description'),
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Price'),
              ),
              TextFormField(
                controller: reviewTextController,
                decoration: InputDecoration(labelText: 'Review Text'),
                maxLines: 5, // Set larger size for this field
                keyboardType: TextInputType.multiline,
              ),
              TextFormField(
                controller: imageNameController,
                decoration: InputDecoration(labelText: 'Image Name'),
              ),
              TextFormField(
                controller: keyFeaturesController,
                decoration: InputDecoration(labelText: 'Key Features'),
              ),
              TextFormField(
                controller: performanceController,
                decoration: InputDecoration(labelText: 'Performance'),
              ),
              TextFormField(
                controller: ratingController,
                decoration: InputDecoration(labelText: 'Rating (0 to 5)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                ],
              ),
              FFButtonWidget(
                onPressed: updateReview,
                text: 'Update Review',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 48.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context)
                      .titleSmall
                      .override(fontWeight: FontWeight.w600, fontSize: 16),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              FFButtonWidget(
                onPressed: deleteReview,
                text: 'Delete Review',
                options: FFButtonOptions(
                  width: double.infinity,
                  height: 48.0,
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: Colors.red,
                  textStyle: FlutterFlowTheme.of(context)
                      .titleSmall
                      .override(fontWeight: FontWeight.w600, fontSize: 16),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
