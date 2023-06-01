import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';
import 'package:rental_user/user/model/user_model.dart';

final dio = Dio();

Future<List<Map<String, dynamic>>> requestCategories(
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
  final categories = data['data'];

  if (categories != null && categories is List<dynamic>) {
    return categories.cast<Map<String, dynamic>>().toList();
  } else {
    return []; // Return an empty list if the data is null or not a list
  }
}

Future<List<Map<String, dynamic>>> requestBrand(
    {required BuildContext context, String? brandId}) async {
  ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
  final UserModel user = modelUser.user;
  final String token = user.token;

  final response = await dio.get(
    brandId != null && brandId.isNotEmpty
        ? '$mainUrl/brands/$brandId'
        : '$mainUrl/brands',
    data: modelUser.toJson(),
    options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ),
  );

  final data = response.data as Map<String, dynamic>;
  final brands = data['data'];

  debugPrint("####### Brand List :  $brands #######");

  if (brands != null && brands is List<dynamic>) {
    return brands.cast<Map<String, dynamic>>().toList();
  } else {
    return []; // Return an empty list if the data is null or not a list
  }
}

Future<List<Map<String, dynamic>>> requestItems(
    {required BuildContext context}) async {
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
  final items = data['data'];
  debugPrint("####### Item List from RI : $items #######");

  if (items != null && items is List<dynamic>) {
    return items.cast<Map<String, dynamic>>().toList();
  } else {
    return []; // Return an empty list if the data is null or not a list
  }

  // final data = response.data['data'];
  // debugPrint("####### ${response.data} #######");

  // debugPrint("####### $data #######");
  // if (data != null && data is List<dynamic>) {
  //   return List<Map<String, dynamic>>.from(data);
  // } else {
  //   return []; // Return an empty list if the data is null or not a list
  // }
}

Future<List<Map<String, dynamic>>> searchItems(
    BuildContext context, String filterName) async {
  ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
  final UserModel user = modelUser.user;
  final String token = user.token;

  final response = await dio.get(
    '$mainUrl/products/search',
    data: {'user_id': user.id, 'filter_name': filterName},
    options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ),
  );

  final data = response.data as Map<String, dynamic>;
  final items = data['data'];
  debugPrint("####### Item List from Search : $items #######");

  if (items != null && items is List<dynamic>) {
    return items.cast<Map<String, dynamic>>().toList();
  } else {
    return []; // Return an empty list if the data is null or not a list
  }
}
