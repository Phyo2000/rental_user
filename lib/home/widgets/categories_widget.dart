import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: requestCategories(context: context),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the data
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Return to Login if there has error
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
          // Render the categories when the data is available
          final categories = snapshot.data!;
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final category in categories)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        String categoryId = category['_id'];
                        String categoryName = category['name'];
                        Map<String, dynamic> arguments = {
                          'categoryId': categoryId,
                          'categoryName': categoryName,
                        };
                        Navigator.pushNamed(
                          context,
                          "/categoryDetails",
                          arguments: arguments,
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            category['media']?['media_link'] ?? '',
                            width: 40,
                            height: 40,
                          ),
                          Text(
                            category['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        } else {
          // Handle the case where no data is available
          return const Text('No data available');
        }
      },
    );
  }
}
