import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/models/categories_model.dart';
import 'package:rental_user/home/views/category_details_screen.dart';

class CategoriesWidget extends StatelessWidget {
  final List<Categories> categories;
  const CategoriesWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final category in categories)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: InkWell(
                onTap: () {
                  String categoryId = category.id;
                  String categoryName = category.category;
                  Map<String, dynamic> arguments = {
                    'categoryId': categoryId,
                    'categoryName': categoryName,
                  };
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryDetails(
                        id: categoryId,
                      ),
                      settings: RouteSettings(arguments: arguments),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      category.imgLink,
                      width: 40,
                      height: 40,
                    ),
                    Text(
                      category.category,
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
  }
}
