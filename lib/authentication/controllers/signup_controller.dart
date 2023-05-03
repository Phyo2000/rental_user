import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rental_user/authentication/models/register_model.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';

class SignUpController {
  final signUpFormKey = GlobalKey<FormState>();
  final registerModel = RegisterModel();
  final dio = Dio();

  String? validatePhoneNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    } else if (value.length != 11) {
      return 'Please enter a valid 11-digits phone number.';
    }
    return null;
  }

  void setPhone(String value) {
    registerModel.phone = value;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Name.';
    } else if (value.length < 6) {
      return 'Name must be at least 5 characters long.';
    }
    return null;
  }

  void setName(String value) {
    registerModel.name = value;
  }

  bool _isValid() {
    return signUpFormKey.currentState?.validate() ?? false;
  }

  void submit() async {
    if (_isValid()) {
      final response = await dio.post(
        '$mainUrl/register',
        data: registerModel.toJson(),
      );

      if (response.statusCode == 200) {
        debugPrint(
            "################## SUCCESSFULLY REGISTERED ####################");
      }
    }
  }
}
