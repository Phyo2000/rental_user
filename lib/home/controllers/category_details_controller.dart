import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';
import 'package:rental_user/home/models/item_model.dart';
import 'package:rental_user/user/model/user_model.dart';

final dio = Dio();

class CategoryDetailController {
  List<ItemDetail> categoryDetails = [];

  Future<List<ItemDetail>> requestCategoryDetails(
      {required BuildContext context, required String categoryId}) async {
    ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
    final UserModel user = modelUser.user;
    final String token = user.token;

    final response = await dio.get(
      '$mainUrl/categories/$categoryId',
      data: modelUser.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final data = response.data as Map<String, dynamic>;
    final categoriesData = data['data'];

    if (categoriesData != null && categoriesData is List<dynamic>) {
      List<ItemDetail> categoryDetail = categoriesData.map((item) {
        return ItemDetail(
            id: item['_id'],
            name: item['name'],
            imgLink: item['main_thambnail']['media_link'],
            brand: item['brand']['name'],
            price: item['price'].toString());
      }).toList();
      categoryDetails = categoryDetail;
    } else {
      categoryDetails =
          []; // Return an empty list if the data is null or not a list
    }
    return categoryDetails;
  }
}
