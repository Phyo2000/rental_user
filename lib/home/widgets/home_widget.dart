import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/controllers/home_controller.dart';
import 'package:rental_user/home/widgets/brand_list_widget.dart';
import 'package:rental_user/home/widgets/categories_widget.dart';
import 'package:rental_user/home/widgets/home_appbar.dart';
import 'package:rental_user/home/widgets/items_widget.dart';

class Home extends StatefulWidget {
  const Home({
    super.key,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool theFlash = false;
  bool _isLoading = false;
  String? searchName;

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    var items;

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
                        controller: _searchController,
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search here..."),
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          theFlash = true;
                          _isLoading = true;
                        });
                        searchName = _searchController.text;
                        // items = await searchItems(context, searchName ?? '');

                        setState(() {
                          _isLoading = false;
                        });
                        debugPrint("@@@ Search Item is $items");
                      },
                      child: _isLoading
                          ? const SizedBox(
                              height: 23,
                              width: 23,
                              child: CircularProgressIndicator(),
                            )
                          : const Icon(
                              Icons.search_sharp,
                              size: 27,
                              color: mainColor,
                            ),
                    ),
                  ],
                ),
              ),

              // Categories
              theFlash
                  ? FutureBuilder<List<dynamic>>(
                      future: searchItems(context, searchName ?? ''),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasData) {
                          final detail = snapshot.data!;
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Search Key : \"$searchName\"",
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: mainColor),
                                ),
                              ),
                              for (final i in detail)
                                ItemsWidget(
                                  isDetail: false,
                                  isSearch: true,
                                  id: i['_id'],
                                ),
                            ],
                          );
                        } else {
                          return const Text('No items found.');
                        }
                      },
                    )
                  : Column(
                      children: [
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

                        // Brand

                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: const Text(
                            "Brand Lists",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: mainColor,
                            ),
                          ),
                        ),

                        const BrandWidget(),

                        // Items

                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: const Text(
                            "Rental Items",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: mainColor,
                            ),
                          ),
                        ),

                        //Items Widget
                        ItemsWidget(
                          isDetail: false,
                        ),
                      ],
                    ), //const ItemList(),
            ],
          ),
        ),
      ],
    );
  }
}
