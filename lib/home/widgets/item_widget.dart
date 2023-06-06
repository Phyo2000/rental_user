import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/models/item_model.dart';

class ItemDetailWidget extends StatelessWidget {
  final List<ItemDetail> itemDetails;
  const ItemDetailWidget({super.key, required this.itemDetails});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.6,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      shrinkWrap: true,
      // children: [
      //   for (final item in items)
      //     Text(
      //       item['name'].toString(),
      //     ),
      //     Text(
      //       item['name'].toString(),
      //     ),
      // ],
      children: [
        for (final item in itemDetails)
          Container(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SizedBox(),
                    // Container(
                    //   padding: const EdgeInsets.all(5),
                    //   decoration: BoxDecoration(
                    //     color: Color(0xFF4C53A5),
                    //     borderRadius: BorderRadius.circular(20),
                    //   ),
                    //   child: Text(
                    //     "-50%",
                    //     style: TextStyle(
                    //       fontSize: 14,
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                    Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    String productId = item.id;
                    String productName = item.name;
                    Map<String, dynamic> arguments = {
                      'productId': productId,
                      'productName': productName,
                    };

                    Navigator.pushNamed(
                      context,
                      "/item",
                      arguments: arguments,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Image.network(
                      item.imgLink,
                      // item['main_thambnail'] is String
                      //     ? item['main_thambnail']
                      //     : item['main_thambnail'] != null
                      //         ? item['main_thambnail']['media_link'] ?? ''
                      //         : '',
                      height: 140,
                      width: 120,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    (item.name.length > 15)
                        ? item.name.substring(0, 15)
                        : item.name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: mainColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (item.brand.length > 15)
                            ? item.brand.substring(0, 15)
                            : item.brand,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: mainColor),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$ ${item.price.toString()}",
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
