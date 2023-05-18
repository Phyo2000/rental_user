import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';
import 'package:rental_user/user/model/user_model.dart';

final dio = Dio();

void logOut(BuildContext context) async {
  ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
  UserModel? user = modelUser.user;

  String token = user.token;
  try {
    final response = await dio.post(
      '$mainUrl/logout',
      data: modelUser.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    debugPrint("######### ${response.data['error'].toString()} #############");
    if (response.statusCode == 200 &&
        response.data["error"].toString() != "true") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Successfully Logout"),
          duration: Duration(milliseconds: 600),
        ),
      );

      Navigator.pushReplacementNamed(context, '/');
    }
  } on DioError catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Network Connection Failed!"),
      ),
    );
  }
}
