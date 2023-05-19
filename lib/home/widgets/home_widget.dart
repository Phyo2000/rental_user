import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/widgets/categories_widget.dart';
import 'package:rental_user/home/widgets/home_appbar.dart';
import 'package:rental_user/home/widgets/items_widget.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const HomeAppBar(),

        // Search

        Container(
          padding: const EdgeInsets.only(top: 15),
          decoration: const BoxDecoration(
            color: Color(0xFFEDECF2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5),
                      height: 50,
                      width: 300,
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search here..."),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.search_sharp,
                      size: 27,
                      color: mainColor,
                    ),
                  ],
                ),
              ),

              // Categories

              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: const Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
              ),

              // Categories Widget

              const CategoriesWidget(),

              // Items

              Container(
                alignment: Alignment.centerLeft,
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: const Text(
                  "Popular items",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: mainColor,
                  ),
                ),
              ),

              // Items Widget
              const ItemsWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
