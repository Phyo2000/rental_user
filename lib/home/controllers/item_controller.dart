import 'package:rental_user/home/models/brand_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';
import 'package:rental_user/home/models/item_model.dart';
import 'package:rental_user/user/model/user_model.dart';

final dio = Dio();

class ItemController {
  List<ItemDetail> items = [];

  Future<List<ItemDetail>> requestItems({required BuildContext context}) async {
    ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
    final UserModel user = modelUser.user;
    final String token = user.token;

    final response = await dio.get(
      '$mainUrl/products',
      data: modelUser.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    final data = response.data as Map<String, dynamic>;
    final itemsData = data['data'];

    if (itemsData != null && itemsData is List<dynamic>) {
      List<ItemDetail> itemsList = itemsData.map((item) {
        return ItemDetail(
            id: item['_id'],
            name: item['name'],
            imgLink: item['main_thambnail'],
            brand: item['brand']['name'],
            price: item['price'].toString());
      }).toList();
      items = itemsList;
    } else {
      items = []; // Return an empty list if the data is null or not a list
    }
    return items;
  }
}
