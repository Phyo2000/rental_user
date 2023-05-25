import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rental_user/items/widgets/item_bottom_navbar.dart';
import 'package:rental_user/items/widgets/items_details_widget.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String productId = arguments['productId'];
    final String productName = arguments['productName'];
    return Scaffold(
      backgroundColor: const Color(0xFFEDECF2),
      body: ItemDetails(
        productId: productId,
        productName: productName,
      ),
      bottomNavigationBar: const ItemBottomNavBar(),
    );
  }
}
