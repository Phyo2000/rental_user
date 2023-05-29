import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:rental_user/cart/controllers/rent_controller.dart';
import 'package:rental_user/global_variables.dart';

class CartItems extends StatelessWidget {
  final items;
  const CartItems({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items)
          FutureBuilder<Map<String, dynamic>>(
            future: requestRentItemDetails(
                context: context, rentId: item['_id'].toString()),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While waiting for the data to be fetched, you can show a loading indicator or placeholder
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                // If there's an error while fetching the data, you can show an error message
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                final details = snapshot.data!;
                String? name, imgLink;
                debugPrint("It is OK here. ${item['_id'].toString()}");

                name = details['product']['product_name'];
                imgLink = details['product']['image'];

                return Container(
                  height: 110,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      // Radio(
                      //   value: "",
                      //   groupValue: "",
                      //   activeColor: mainColor,
                      //   onChanged: (index) {},
                      // ),
                      Container(
                        height: 70,
                        width: 70,
                        margin: const EdgeInsets.only(right: 15),
                        child: Image.network(imgLink.toString()),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 32,
                              width: 150,
                              child: name.toString().length > 20
                                  ? Marquee(
                                      text: name
                                          .toString(), // Here is Product Name
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      scrollAxis: Axis.horizontal,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      blankSpace: 30.0,
                                      velocity: 85.0,
                                      pauseAfterRound:
                                          const Duration(seconds: 2),
                                      startPadding: 10.0,
                                      accelerationDuration:
                                          const Duration(seconds: 1),
                                      accelerationCurve: Curves.linear,
                                      decelerationDuration:
                                          const Duration(milliseconds: 500),
                                      decelerationCurve: Curves.easeOut,
                                    )
                                  : Text(
                                      name.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: mainColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                            Text(
                              "\$ ${item['total_price'].toString()}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            Text(
                              "\$ ${item['rent_date'].toString()}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Text("No data available");
              }
            },
          ),
      ],
    );
  }
}
