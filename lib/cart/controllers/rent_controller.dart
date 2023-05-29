import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';
import 'package:rental_user/user/model/user_model.dart';

final dio = Dio();

Future<List<Map<String, dynamic>>> requestRentItemList(
    {required BuildContext context}) async {
  ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
  final UserModel user = modelUser.user;
  final String token = user.token;

  final response = await dio.get(
    '$mainUrl/rent/lists',
    data: modelUser.toJson(),
    options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ),
  );

  final data = response.data as Map<String, dynamic>;
  final items = data['data'];
  debugPrint("####### Rent Item List : $items #######");

  if (items != null && items is List<dynamic>) {
    return items.cast<Map<String, dynamic>>().toList();
  } else {
    return []; // Return an empty list if the data is null or not a list
  }
}
