import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rental_user/authentication/models/user_model.dart';

class LoginController {
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
}

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  Dio _dio = Dio();

  UserModel? get user => _user;

  Future<String> login(String phoneNumber, String password) async {
    String res = "An error occoured.";
    try {
      if (phoneNumber.isNotEmpty || password.isNotEmpty) {
        // Log in process
        Response response = await _dio.post(
          'http://192.168.100.8:8003/api/user/login',
          data: {'phoneNumber': phoneNumber, 'password': password},
        );

        if (response.statusCode == 200) {
          _user = UserModel(phone: phoneNumber, password: password);
          notifyListeners();
        } else {
          res = "Network error.";
        }
      } else {
        res = "Please enter all the fields.";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
