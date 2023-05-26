import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/items/controllers/items_controller.dart';

class ItemBottomNavBar extends StatelessWidget {
  String productId;
  ItemBottomNavBar({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? productDetails;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: requestItemDetails(context: context, productId: productId),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the data
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return const SizedBox();
        } else if (snapshot.hasData) {
          final details = snapshot.data!;
          for (final detail in details) {
            if (detail['_id'] == productId) {
              productDetails = detail;
              break;
            }
          }
          return BottomAppBar(
            child: Container(
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$ ${productDetails?['price'].toString() ?? ''}",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.cart_badge_plus),
                    label: const Text(
                      "Add To Rent",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(mainColor),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 15),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
