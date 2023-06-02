import 'package:rental_user/home/models/brand_model.dart';
import 'package:rental_user/home/models/categories_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';
import 'package:rental_user/user/model/user_model.dart';

final dio = Dio();

class BrandController {
  List<Brands> brands = [];

  Future<List<Brands>> requestBrands({required BuildContext context}) async {
    ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
    final UserModel user = modelUser.user;
    final String token = user.token;

    final response = await dio.get(
      '$mainUrl/brands',
      data: modelUser.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final data = response.data as Map<String, dynamic>;
    final brandsData = data['data'];

    if (brandsData != null && brandsData is List<dynamic>) {
      List<Brands> brandList = brandsData.map((item) {
        return Brands(
          id: item['_id'],
          imgLink: item['media']['media_link'],
          brandName: item['name'],
          productCount: item['product_count'],
        );
      }).toList();
      brands = brandList;
    } else {
      brands = []; // Return an empty list if the data is null or not a list
    }
    return brands;
  }
}
