import 'package:flutter/material.dart';
import 'package:rental_user/cart/controllers/rent_controller.dart';
import 'package:rental_user/cart/widgets/cart_appbar.dart';
import 'package:rental_user/cart/widgets/cart_bottom_nav.dart';
import 'package:rental_user/cart/widgets/cart_items.dart';
import 'package:rental_user/global_variables.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
          future: requestRentItemList(context: context),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading indicator while waiting for the data
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // Handle the error state

              return const SizedBox();
            } else if (snapshot.hasData) {
              final items = snapshot.data!;

              return ListView(
                //shrinkWrap: true,
                children: [
                  const CartAppBar(),
                  Container(
                    height: 680,
                    padding: const EdgeInsets.only(top: 15),
                    decoration: const BoxDecoration(
                      color: Color(0xFFEDECF2),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    child: CartItems(
                      items: items,
                    ),
                  ),
                ],
              );
            } else {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: const Text(
                  "There is no Rented Product.",
                  style: TextStyle(
                      fontSize: 18,
                      color: mainColor,
                      fontWeight: FontWeight.bold),
                ),
              );
            }
          }),
      bottomNavigationBar: CartBottomNavBar(),
    );
  }
}
