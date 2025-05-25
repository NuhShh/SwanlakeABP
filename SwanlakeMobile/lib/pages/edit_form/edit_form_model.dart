import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_form_widget.dart' show EditFormWidget;
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditFormModel extends FlutterFlowModel<EditFormWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for fullName widget.
  FocusNode? fullNameFocusNode;
  TextEditingController? fullNameTextController;
  String? Function(BuildContext, String?)? fullNameTextControllerValidator;
  String? _fullNameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the patients full name.';
    }

    return null;
  }

  // State field(s) for ChoiceChips widget.
  FormFieldController<List<String>>? choiceChipsValueController;
  String? get choiceChipsValue =>
      choiceChipsValueController?.value?.firstOrNull;
  set choiceChipsValue(String? val) =>
      choiceChipsValueController?.value = val != null ? [val] : [];
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode1;
  TextEditingController? descriptionTextController1;
  String? Function(BuildContext, String?)? descriptionTextController1Validator;
  // State field(s) for age widget.
  FocusNode? ageFocusNode;
  TextEditingController? ageTextController;
  String? Function(BuildContext, String?)? ageTextControllerValidator;
  String? _ageTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter an age for the patient.';
    }

    return null;
  }

  // State field(s) for phoneNumber widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode1;
  TextEditingController? dateOfBirthTextController1;
  final dateOfBirthMask1 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController1Validator;
  String? _dateOfBirthTextController1Validator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter the date of birth of the patient.';
    }

    return null;
  }

  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode2;
  TextEditingController? dateOfBirthTextController2;
  final dateOfBirthMask2 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController2Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode3;
  TextEditingController? dateOfBirthTextController3;
  final dateOfBirthMask3 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController3Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode4;
  TextEditingController? dateOfBirthTextController4;
  final dateOfBirthMask4 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController4Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode5;
  TextEditingController? dateOfBirthTextController5;
  final dateOfBirthMask5 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController5Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode6;
  TextEditingController? dateOfBirthTextController6;
  final dateOfBirthMask6 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController6Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode7;
  TextEditingController? dateOfBirthTextController7;
  final dateOfBirthMask7 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController7Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode8;
  TextEditingController? dateOfBirthTextController8;
  final dateOfBirthMask8 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController8Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode9;
  TextEditingController? dateOfBirthTextController9;
  final dateOfBirthMask9 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController9Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode10;
  TextEditingController? dateOfBirthTextController10;
  final dateOfBirthMask10 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController10Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode11;
  TextEditingController? dateOfBirthTextController11;
  final dateOfBirthMask11 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController11Validator;
  // State field(s) for description widget.
  FocusNode? descriptionFocusNode2;
  TextEditingController? descriptionTextController2;
  String? Function(BuildContext, String?)? descriptionTextController2Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode12;
  TextEditingController? dateOfBirthTextController12;
  final dateOfBirthMask12 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController12Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode13;
  TextEditingController? dateOfBirthTextController13;
  final dateOfBirthMask13 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController13Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode14;
  TextEditingController? dateOfBirthTextController14;
  final dateOfBirthMask14 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController14Validator;
  // State field(s) for dateOfBirth widget.
  FocusNode? dateOfBirthFocusNode15;
  TextEditingController? dateOfBirthTextController15;
  final dateOfBirthMask15 = MaskTextInputFormatter(mask: '##/##/####');
  String? Function(BuildContext, String?)? dateOfBirthTextController15Validator;

  @override
  void initState(BuildContext context) {
    fullNameTextControllerValidator = _fullNameTextControllerValidator;
    ageTextControllerValidator = _ageTextControllerValidator;
    dateOfBirthTextController1Validator = _dateOfBirthTextController1Validator;
  }

  @override
  void dispose() {
    fullNameFocusNode?.dispose();
    fullNameTextController?.dispose();

    descriptionFocusNode1?.dispose();
    descriptionTextController1?.dispose();

    ageFocusNode?.dispose();
    ageTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    dateOfBirthFocusNode1?.dispose();
    dateOfBirthTextController1?.dispose();

    dateOfBirthFocusNode2?.dispose();
    dateOfBirthTextController2?.dispose();

    dateOfBirthFocusNode3?.dispose();
    dateOfBirthTextController3?.dispose();

    dateOfBirthFocusNode4?.dispose();
    dateOfBirthTextController4?.dispose();

    dateOfBirthFocusNode5?.dispose();
    dateOfBirthTextController5?.dispose();

    dateOfBirthFocusNode6?.dispose();
    dateOfBirthTextController6?.dispose();

    dateOfBirthFocusNode7?.dispose();
    dateOfBirthTextController7?.dispose();

    dateOfBirthFocusNode8?.dispose();
    dateOfBirthTextController8?.dispose();

    dateOfBirthFocusNode9?.dispose();
    dateOfBirthTextController9?.dispose();

    dateOfBirthFocusNode10?.dispose();
    dateOfBirthTextController10?.dispose();

    dateOfBirthFocusNode11?.dispose();
    dateOfBirthTextController11?.dispose();

    descriptionFocusNode2?.dispose();
    descriptionTextController2?.dispose();

    dateOfBirthFocusNode12?.dispose();
    dateOfBirthTextController12?.dispose();

    dateOfBirthFocusNode13?.dispose();
    dateOfBirthTextController13?.dispose();

    dateOfBirthFocusNode14?.dispose();
    dateOfBirthTextController14?.dispose();

    dateOfBirthFocusNode15?.dispose();
    dateOfBirthTextController15?.dispose();
  }
}
