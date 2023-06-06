import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/authentication/custom_config/utils.dart';
import 'package:rental_user/items/models/product_details_model.dart';
import 'package:rental_user/items/models/rent_products_model.dart';
import 'package:rental_user/user/model/user_model.dart';

final dio = Dio();

class ItemDetailsController {
  ProductDetails? _productDetails;
  Future<ProductDetails?> requestItemDetails(
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
    final itemList = data['data'];
    debugPrint("####### Item from PDT : $itemList #######");

    if (itemList != null) {
      final item = itemList[0];
      final id = item['_id'] as String?; // Perform typecast to String?
      final imgLink = item['main_thambnail']['media_link'] as String?;
      final name = item['name'] as String?;
      final energyConsumption = item['energy_comsumption'] as String?;
      final colors = List<String>.from(item['color']);
      final size = List<String>.from(item['size']);
      final extra = List<String>.from(item['extra_device']);
      final description = item['description'] as String?;
      final price = item['price'].toString();
      final productCode = item['product_code'] as String?;
      final brand = item['brand']['name'] as String?;
      final category = List<String>.from(
          item['category'].map((category) => category['name']));
      final durationDate = item['duration_date'].toString();
      final insurenceDate = item['insurence_date'].toString();
      final business = List<String>.from(
          item['business'].map((business) => business['name']));
      final vendor = item['vendor'] as String?;

      _productDetails = ProductDetails(
        id: id ?? '', // Use null-coalescing operator to provide a default value
        imgLink: imgLink ?? '',
        name: name ?? '',
        energyConsumption: energyConsumption ?? '',
        colors: colors,
        size: size,
        extra: extra,
        description: description ?? '',
        price: price,
        productCode: productCode ?? '',
        brand: brand ?? '',
        category: category,
        durationDate: durationDate,
        insurenceDate: insurenceDate,
        business: business,
        vendor: vendor,
      );
    } else {
      // Return a default or null ProductDetails object if the data is invalid
      _productDetails = ProductDetails(
        id: '',
        imgLink: '',
        name: '',
        energyConsumption: '',
        colors: [],
        size: [],
        extra: [],
        description: '',
        price: '0',
        productCode: '',
        brand: '',
        category: [],
        durationDate: '0',
        insurenceDate: '0',
        business: [],
        vendor: '',
      );
    }

    // debugPrint("##### PDTail is $_productDetails");
    return _productDetails;
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
