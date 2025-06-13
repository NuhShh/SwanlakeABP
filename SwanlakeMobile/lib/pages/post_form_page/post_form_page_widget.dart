import 'package:shared_preferences/shared_preferences.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostFormPageWidget extends StatefulWidget {
  const PostFormPageWidget({super.key});

  static String routeName = 'PostFormPage';
  static String routePath = '/postFormPage';

  @override
  State<PostFormPageWidget> createState() => _PostFormPageWidgetState();
}

class _PostFormPageWidgetState extends State<PostFormPageWidget> {
  late TextEditingController productNameController;
  late TextEditingController productTypeController;
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

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  String? selectedProductType = 'Smartphone';

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController();
    productTypeController = TextEditingController();
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
  }

  Future<void> postReview() async {
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

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/api/post/review'),
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Review posted successfully")),
        );
        Navigator.pop(context); // Go back to the previous screen
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to post review: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    productTypeController.dispose();
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Review Form',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                  font: GoogleFonts.interTight(
                    fontWeight: FlutterFlowTheme.of(context)
                        .headlineMedium
                        .fontWeight,
                    fontStyle: FlutterFlowTheme.of(context)
                        .headlineMedium
                        .fontStyle,
                  ),
                  letterSpacing: 0.0,
                  fontWeight: FlutterFlowTheme.of(context)
                      .headlineMedium
                      .fontWeight,
                  fontStyle:
                  FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 12.0, 8.0),
              child: FlutterFlowIconButton(
                borderColor: FlutterFlowTheme.of(context).alternate,
                borderRadius: 12.0,
                borderWidth: 1.0,
                buttonSize: 40.0,
                fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                icon: Icon(
                  Icons.close_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () {
                  Navigator.pop(context); // Close the form
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Form(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextFormField(
                                controller: productNameController,
                                decoration: InputDecoration(labelText: 'Product Name'),
                              ),
                              SizedBox(height: 20),
                              DropdownButton<String>(
                                value: selectedProductType,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedProductType = newValue;
                                  });
                                },
                                items: <String>['Smartphone', 'Desktop & Laptop', 'Accessories', 'Console']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: reviewTitleController,
                                decoration: InputDecoration(labelText: 'Review Title'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: cardDescController,
                                decoration: InputDecoration(labelText: 'Card Description'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: processorController,
                                decoration: InputDecoration(labelText: 'Processor'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: processorDescController,
                                decoration: InputDecoration(labelText: 'Processor Description'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: ramController,
                                decoration: InputDecoration(labelText: 'RAM'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: ramDescController,
                                decoration: InputDecoration(labelText: 'RAM Description'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: storageController,
                                decoration: InputDecoration(labelText: 'Storage'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: storageDescController,
                                decoration: InputDecoration(labelText: 'Storage Description'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: displayController,
                                decoration: InputDecoration(labelText: 'Display'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: displayDescController,
                                decoration: InputDecoration(labelText: 'Display Description'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: batteryController,
                                decoration: InputDecoration(labelText: 'Battery'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: batteryDescController,
                                decoration: InputDecoration(labelText: 'Battery Description'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: cameraController,
                                decoration: InputDecoration(labelText: 'Camera'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: cameraDescController,
                                decoration: InputDecoration(labelText: 'Camera Description'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: priceController,
                                decoration: InputDecoration(labelText: 'Price'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: reviewTextController,
                                decoration: InputDecoration(labelText: 'Review Text'),
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: imageNameController,
                                decoration: InputDecoration(labelText: 'Image Name'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: keyFeaturesController,
                                decoration: InputDecoration(labelText: 'Key Features'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: performanceController,
                                decoration: InputDecoration(labelText: 'Performance'),
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: ratingController,
                                decoration: InputDecoration(labelText: 'Rating (0 to 5)'),
                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')), // Accept decimal numbers
                                ],
                              ),
                              SizedBox(height: 20),
                              FFButtonWidget(
                                onPressed: postReview,
                                text: isLoading ? 'Posting...' : 'Post Review',
                                options: FFButtonOptions(
                                  width: 170.0,
                                  height: 40.0,
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  elevation: 0,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}