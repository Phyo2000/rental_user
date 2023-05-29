import 'package:flutter/material.dart';
import 'package:rental_user/items/controllers/items_controller.dart';
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
  Map<String, dynamic>? productDetails;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    productId = arguments['productId'];
    productName = arguments['productName'];
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, dynamic> arguments =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // final String productId = arguments['productId'];
    // final String productName = arguments['productName'];
    // Map<String, dynamic>? productDetails;

    return Scaffold(
      backgroundColor: const Color(0xFFEDECF2),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: requestItemDetails(context: context, productId: productId),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading indicator while waiting for the data
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Handle the error state
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Token expired! You need to login again."),
                  duration: Duration(seconds: 10),
                ),
              );
              // Go to login if there's an error
              Navigator.pushReplacementNamed(context, '/login');
            });

            return const SizedBox();
          } else if (snapshot.hasData) {
            final details = snapshot.data!;
            for (final detail in details) {
              if (detail['_id'] == productId) {
                productDetails = detail;
                break;
              }
            }

            return productDetails != null
                ? Column(
                    children: [
                      Expanded(
                        child: ItemDetails(
                            productId: productId,
                            productName: productName,
                            productDetails: productDetails),
                      ),
                      ItemBottomNavBar(productDetails: productDetails),
                    ],
                  )
                : const Text('No Data available.');
          } else {
            // Handle the empty state
            return const SizedBox(
              child: Text("There is no data."),
            );
          }
        },
      ),
      //bottomNavigationBar: ItemBottomNavBar(productDetails: productDetails),
    );
  }
}
