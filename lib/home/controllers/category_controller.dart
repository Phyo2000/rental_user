import 'package:rental_user/home/models/categories_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';
import 'package:rental_user/user/model/user_model.dart';

final dio = Dio();

class CategoryController {
  List<Categories> categories = [];

  Future<List<Categories>> requestCategories(
      {required BuildContext context, String? categoryId}) async {
    ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
    final UserModel user = modelUser.user;
    final String token = user.token;

    final response = await dio.get(
      categoryId != null && categoryId.isNotEmpty
          ? '$mainUrl/categories/$categoryId'
          : '$mainUrl/categories',
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
      List<Categories> categoriesList = categoriesData.map((item) {
        return Categories(
          id: item['_id'],
          imgLink: item['media']['media_link'],
          category: item['name'],
        );
      }).toList();
      categories = categoriesList;
    } else {
      categories = []; // Return an empty list if the data is null or not a list
    }
    return categories;
  }
}
