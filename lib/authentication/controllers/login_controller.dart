import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rental_user/authentication/models/login_model.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';

class LoginController {
  final signUpFormsKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();
  final model = LoginModel();
  final dio = Dio();

  List<String> otp = ['0', '0', '0', '0', '0', '0'];

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a Name.';
    } else if (value.length < 5) {
      return 'Name must be at least 4 characters long.';
    }
    return null;
  }

  String? validatePhoneNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    } else if (value.length > 11 || value.length < 8) {
      return 'Please enter a valid 8-11 digits phone number.';
    }
    return null;
  }

  void setName(String value) {
    model.name = value;
  }

  void setPhone(String value) {
    model.phone = value;
  }

  String? validateOtpField(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter valid OTP.';
    }
    return null;
  }

  // void setPassword(String? value) {
  //   model.password = value;
  // }

  bool _isValid() {
    return loginFormKey.currentState?.validate() ?? false;
  }

  bool _isValidRegister() {
    return signUpFormsKey.currentState?.validate() ?? false;
  }

  void submitRegister(BuildContext context) async {
    if (_isValidRegister()) {
      final response = await dio.post(
        '$mainUrl/register',
        data: model.toJsonRegister(),
      );

      if (response.statusCode == 200 ||
          response.data['error'].toString() != "true") {
        debugPrint(
            "################## SUCCESSFULLY REGISTERED ####################");

        debugPrint(response.data['otp'].toString());

        if (response.data['error'].toString() == "true" ||
            response.data['too-many'].toString() == 'true') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.data['message'].toString()),
            ),
          );
          Navigator.pushReplacementNamed(context, '/register');
        } else {
          Navigator.pushReplacementNamed(context, '/otp');
        }
      }
    }
  }

  void submit(BuildContext context) async {
    if (_isValid()) {
      //Navigator.pushReplacementNamed(context, '/otp');

      final response = await dio.post(
        '$mainUrl/login',
        data: model.toJson(),
      );

      if (response.statusCode == 200 ||
          response.data['error'].toString() != "true") {
        debugPrint(
            "################## SUCCESSFULLY LOGIN ####################");

        debugPrint(response.data['otp'].toString());

        if (response.data['error'].toString() == "true" ||
            response.data['too-many'].toString() == 'true') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.data['message'].toString()),
            ),
          );
          Navigator.pushReplacementNamed(context, '/register');
        } else {
          Navigator.pushReplacementNamed(context, '/otp');
        }
      }
    }
  }

  void otp_submit(BuildContext context) async {
    if (otpFormKey.currentState?.validate() ?? false) {
      String ans = "";
      for (String i in otp) {
        ans += i;
      }
      debugPrint(
          "Your phone is ${model.phone.toString()} and your answer is $ans");
      Map<String, dynamic> toJson() =>
          {'phone': model.phone.toString(), 'otp': ans};

      final response = await dio.post(
        '$mainUrl/check/otp',
        data: {...toJson()},
      );

      if (response.statusCode == 200 &&
          response.data['error'].toString() != "true") {
        debugPrint("########## OTP CHECK SUCCESSFULLY #############");
        debugPrint("################ ${response.data.toString()} #########");
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              response.data['message'].toString(),
            ),
          ),
        );
        debugPrint("################ ${response.data.toString()} #########");
      }
    }
  }
}

// class LoginController {
//   final loginFormKey = GlobalKey<FormState>();
//   final TextEditingController phoneController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
// }

// class AuthProvider with ChangeNotifier {
//   UserModel? _user;
//   Dio _dio = Dio();

//   UserModel? get user => _user;

//   Future<String> login(String phoneNumber, String password) async {
//     String res = "An error occoured.";
//     try {
//       if (phoneNumber.isNotEmpty || password.isNotEmpty) {
//         // Log in process
//         Response response = await _dio.post(
//           'http://192.168.100.8:8003/api/user/login',
//           data: {'phoneNumber': phoneNumber, 'password': password},
//         );

//         if (response.statusCode == 200) {
//           _user = UserModel(phone: phoneNumber, password: password);
//           notifyListeners();
//           res = "success";
//         } else {
//           res = "Network error.";
//         }
//       } else {
//         res = "Please enter all the fields.";
//       }
//     } catch (err) {
//       res = err.toString();
//     }
//     return res;
//   }

//   void loginUser(BuildContext context) async {
//     String result = await login(LoginController().phoneController.text,
//         LoginController().passwordController.text);

//     if (result == "success") {
//       //
//     } else {
//       showSnackBar(result, context);
//     }
//   }
// }
