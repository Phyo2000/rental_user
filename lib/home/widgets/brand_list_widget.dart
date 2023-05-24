import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrandWidget extends StatelessWidget {
  const BrandWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: requestBrand(context: context),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the data
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Go to login if there's an error
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();

            await prefs.remove('credentials');
            //Navigator.pushReplacementNamed(context, '/login');
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Token expired! You need to login again."),
              duration: Duration(seconds: 10),
            ),
          );

          return const SizedBox();
        } else if (snapshot.hasData) {
          final brands = snapshot.data!;

          return GridView.count(
            childAspectRatio: 0.73,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              for (final brand in brands)
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
                      InkWell(
                        onTap: () {
                          String brandId = brand['_id'];
                          String brandName = brand['name'];
                          Map<String, dynamic> arguments = {
                            'brandId': brandId,
                            'brandName': brandName,
                          };
                          Navigator.pushNamed(
                            context,
                            "/brandDetails",
                            arguments: arguments,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Image.network(
                            brand['media']['media_link'],
                            height: 140,
                            width: 120,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          brand['name'],
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
                              "Products : ${brand['product_count']}",
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
