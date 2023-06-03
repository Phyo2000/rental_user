import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';
import 'package:rental_user/home/models/item_model.dart';
import 'package:rental_user/user/model/user_model.dart';

final dio = Dio();

class BrandDetailController {
  List<ItemDetail> brandDetails = [];

  Future<List<ItemDetail>> requestBrandDetails(
      {required BuildContext context, required String brandId}) async {
    ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
    final UserModel user = modelUser.user;
    final String token = user.token;

    final response = await dio.get(
      '$mainUrl/brands/$brandId',
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
      List<ItemDetail> brandDetail = brandsData.map((item) {
        return ItemDetail(
            id: item['_id'],
            name: item['name'],
            imgLink: item['main_thambnail']['media_link'],
            brand: item['brand']['name'],
            price: item['price'].toString());
      }).toList();
      brandDetails = brandDetail;
    } else {
      brandDetails =
          []; // Return an empty list if the data is null or not a list
    }
    return brandDetails;
  }
}
