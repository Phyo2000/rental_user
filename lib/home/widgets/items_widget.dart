import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ItemsWidget extends StatefulWidget {
  final bool isDetail;
  bool? isBrand;
  bool? isSearch;
  String? id;
  ItemsWidget(
      {super.key,
      required this.isDetail,
      this.id,
      this.isBrand,
      this.isSearch});

  @override
  State<ItemsWidget> createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  void showTokenExpiredSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Token expired! You need to login again."),
        duration: Duration(seconds: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: widget.isDetail
          ? widget.isBrand ?? false
              ? requestBrand(context: context, brandId: widget.id)
              : requestCategories(context: context, categoryId: widget.id)
          : widget.isSearch ?? false
              ? requestItems(context: context)
              : requestItems(context: context),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the data
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // return to Login if there's an error
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();

            await prefs.remove('credentials');
            Navigator.pushReplacementNamed(context, '/login');
          });
          showTokenExpiredSnackBar(context);

          return const SizedBox();
          //return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final items = snapshot.data!;
          var product;
          int count = 0;
          for (final detail in items) {
            if (detail['_id'] == widget.id) {
              product = detail;
              count++;
            }
          }
          debugPrint("### Here are items : $items ###");
          debugPrint("### Here are Product : $product ###");

          debugPrint("### Here is Id : ${widget.id} ###");

          if (items.isNotEmpty) {
            return widget.isSearch ?? false
                ? GridView.count(
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
                      for (int i = 0; i < count; i++)
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  SizedBox(),
                                  Icon(
                                    Icons.favorite_border,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  String productId = product['_id'];
                                  String productName = product['name'];
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
                                    product['main_thambnail'] is String
                                        ? product['main_thambnail']
                                        : product['main_thambnail'] != null
                                            ? product['main_thambnail']
                                                    ['media_link'] ??
                                                ''
                                            : '',
                                    height: 140,
                                    width: 120,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  (product['name'] != null &&
                                          product['name'].toString().length >
                                              15)
                                      ? product['name']
                                          .toString()
                                          .substring(0, 15)
                                      : product['name']?.toString() ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      (product['brand']?['name'] != null &&
                                              product['brand']['name']
                                                      .toString()
                                                      .length >
                                                  15)
                                          ? product['brand']['name']
                                              .toString()
                                              .substring(0, 15)
                                          : product['brand']['name']
                                                  ?.toString() ??
                                              '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: mainColor),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      product['price'] != null
                                          ? "\$ ${product['price']}"
                                          : '',
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
                  )
                : GridView.count(
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
                      for (final item in items)
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, top: 10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  String productId = item['_id'];
                                  String productName = item['name'];
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
                                    item['main_thambnail'] is String
                                        ? item['main_thambnail']
                                        : item['main_thambnail'] != null
                                            ? item['main_thambnail']
                                                    ['media_link'] ??
                                                ''
                                            : '',
                                    height: 140,
                                    width: 120,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 8),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  (item['name'] != null &&
                                          item['name'].toString().length > 15)
                                      ? item['name'].toString().substring(0, 15)
                                      : item['name']?.toString() ?? '',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      (item['brand']?['name'] != null &&
                                              item['brand']['name']
                                                      .toString()
                                                      .length >
                                                  15)
                                          ? item['brand']['name']
                                              .toString()
                                              .substring(0, 15)
                                          : item['brand']['name']?.toString() ??
                                              '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: mainColor),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item['price'] != null
                                          ? "\$ ${item['price']}"
                                          : '',
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
          } else {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: const Text(
                "There is no Product.",
                style: TextStyle(
                    fontSize: 18,
                    color: mainColor,
                    fontWeight: FontWeight.bold),
              ),
            );
          }
        } else {
          // Handle the case where no data is available
          return const Text('No data available');
        }
      },
    );
  }
}
