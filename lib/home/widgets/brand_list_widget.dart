import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/controllers/home_controller.dart';
import 'package:rental_user/home/models/brand_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrandWidget extends StatelessWidget {
  final List<Brands> brands;
  const BrandWidget({super.key, required this.brands});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.73,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      children: [
        for (final brand in brands)
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    String brandId = brand.id;
                    String brandName = brand.brandName;
                    Map<String, dynamic> arguments = {
                      'brandId': brandId,
                      'brandName': brandName,
                    };
                    Navigator.pushNamed(
                      context,
                      "/brandDetails",
                      arguments: arguments,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.network(
                      brand.imgLink,
                      height: 140,
                      width: 120,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    brand.brandName,
                    style: const TextStyle(
                      fontSize: 18,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Products : ${brand.productCount.toString()}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: mainColor),
                      ),
                      const Icon(
                        Icons.shopping_cart_checkout,
                        color: mainColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
