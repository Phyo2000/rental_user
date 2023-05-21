import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/controllers/home_controller.dart';

class ItemsWidget extends StatelessWidget {
  final bool isDetail;
  String? id;
  ItemsWidget({super.key, required this.isDetail, this.id});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: isDetail
          ? requestBrand(context: context, brandId: id)
          : requestItems(context),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the data
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // return to Login if there's an error
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, '/login');
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Token expired! You need to login again."),
              duration: Duration(seconds: 10),
            ),
          );

          return const SizedBox();
          //return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final items = snapshot.data!;

          return GridView.count(
            childAspectRatio: 0.5,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              for (final item in items)
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                          Navigator.pushNamed(context, "/item");
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/images/2.png",
                            height: 140,
                            width: 120,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item['name'].toString().length > 15
                              ? item['name'].toString().substring(0, 15)
                              : item['name'].toString(),
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
                              item['brand']['name'].toString().length > 15
                                  ? item['brand']['name']
                                      .toString()
                                      .substring(0, 15)
                                  : item['brand']['name'].toString(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: mainColor),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          item['description'].toString().length > 50
                              ? item['description'].toString().substring(0, 50)
                              : item['description'].toString(),
                          style: const TextStyle(
                            fontSize: 15,
                            color: mainColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$ ${item['price']}",
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
          // Handle the case where no data is available
          return const Text('No data available');
        }
      },
    );
  }
}
