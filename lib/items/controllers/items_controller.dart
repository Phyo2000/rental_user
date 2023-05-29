import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';
import 'package:rental_user/items/models/rent_products_model.dart';
import 'package:rental_user/user/model/user_model.dart';

final dio = Dio();

Future<List<Map<String, dynamic>>> requestItemDetails(
    {required BuildContext context, required String productId}) async {
  ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
  final UserModel user = modelUser.user;
  final String token = user.token;

  final response = await dio.get(
    '$mainUrl/product/$productId',
    data: modelUser.toJson(),
    options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ),
  );

  final data = response.data as Map<String, dynamic>;
  final items = data['data'];
  debugPrint("####### Item List : $items #######");

  if (items != null && items is List<dynamic>) {
    return items.cast<Map<String, dynamic>>().toList();
  } else {
    return []; // Return an empty list if the data is null or not a list
  }
}

Future<void> rentItems(
    BuildContext context, RentalRequest rentalRequest) async {
  ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
  final UserModel user = modelUser.user;
  final String token = user.token;

  try {
    final response = await dio.post(
      "$mainUrl/rent/products",
      queryParameters: modelUser.toJson(),
      data: rentalRequest,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      ),
    );

    debugPrint("########### RESPONSE ${response.statusCode}");
    if (response.statusCode == 200) {
      debugPrint("################## STATUS 200 ####################");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response.data['message'].toString(),
          ),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  } on DioError catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          e.toString(),
        ),
      ),
    );
  }
}
