import 'package:flutter/material.dart';
import 'package:rental_user/items/controllers/items_controller.dart';
import 'package:rental_user/items/models/product_details_model.dart';
import 'package:rental_user/items/widgets/item_bottom_navbar.dart';
import 'package:rental_user/items/widgets/items_details_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  String productId = '';
  String productName = '';
  ProductDetails? productDetails;
  final ItemDetailsController _itemDetailsController = ItemDetailsController();

  Future<void> fetchItemDetails(String id) async {
    ProductDetails? fetchedDetails = await _itemDetailsController
        .requestItemDetails(context: context, productId: id);

    setState(() {
      productDetails = fetchedDetails;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    productId = arguments['productId'];
    productName = arguments['productName'];
    fetchItemDetails(productId);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("$productDetails");
    return Scaffold(
      body: productDetails != null
          ? Stack(
              children: [
                ItemDetails(
                    productId: productId,
                    productName: productName,
                    productDetails: productDetails!),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ItemBottomNavBar(productDetails: productDetails!),
                ),
              ],
            )
          : const Text('No Data available.'),
    );
  }
}
