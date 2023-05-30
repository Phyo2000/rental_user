import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/items/controllers/items_controller.dart';
import 'dart:convert';

import 'package:rental_user/items/models/rent_products_model.dart';
import 'package:rental_user/user/model/user_model.dart';

class ItemBottomNavBar extends StatefulWidget {
  Map<String, dynamic>? productDetails;

  ItemBottomNavBar({super.key, required this.productDetails});

  @override
  State<ItemBottomNavBar> createState() => _ItemBottomNavBarState();
}

class _ItemBottomNavBarState extends State<ItemBottomNavBar> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    ModelUser modelUser = Provider.of<ModelUser>(context, listen: false);
    final UserModel user = modelUser.user;
    final String token = user.token;

    RentalRequest rentalRequest = RentalRequest(
      products: [
        Product(
          productId: widget.productDetails!['_id'],
          rentDuration: widget.productDetails!['duration_date'],
          size: 'medium',
          color: 'white',
          qty: '1',
        ),
      ],
      phone: user.phone,
      name: user.name,
      address: 'Yangon',
      notes: 'Hold on I still want you.',
    );

    return Container(
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
            "\$ ${widget.productDetails?['price'].toString() ?? ''}",
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: mainColor,
            ),
          ),
          ElevatedButton.icon(
            onPressed: _isLoading
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    await rentItems(context, rentalRequest);
                    setState(() {
                      _isLoading = false;
                    });
                  },
            icon: const Icon(CupertinoIcons.cart_badge_plus),
            label: _isLoading
                ? const CircularProgressIndicator()
                : const Text(
                    "Add To Rent",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(mainColor),
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
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
    );
  }
}
