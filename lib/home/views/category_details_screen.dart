import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/controllers/category_details_controller.dart';
import 'package:rental_user/home/models/item_model.dart';
import 'package:rental_user/home/widgets/item_widget.dart';

class CategoryDetails extends StatefulWidget {
  final String id;
  const CategoryDetails({super.key, required this.id});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  final CategoryDetailController _categoryDetailController =
      CategoryDetailController();
  List<ItemDetail> _categoryDetails = [];

  @override
  void initState() {
    super.initState();
    fetchCategoryDetails();
  }

  Future<void> fetchCategoryDetails() async {
    List<ItemDetail> fetchedCategoryDetails = await _categoryDetailController
        .requestCategoryDetails(context: context, categoryId: widget.id);

    setState(() {
      _categoryDetails = fetchedCategoryDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: mainColor,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Category Details",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                // Container(
                //   margin: const EdgeInsets.symmetric(horizontal: 15),
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   height: 50,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(30),
                //   ),
                //   // child: Row(
                //   children: [
                //     Container(
                //       margin: const EdgeInsets.only(left: 5),
                //       height: 50,
                //       width: 300,
                //       child: TextFormField(
                //         decoration: const InputDecoration(
                //             border: InputBorder.none,
                //             hintText: "Search here..."),
                //       ),
                //     ),
                //     const Spacer(),
                //     const Icon(
                //       Icons.search_sharp,
                //       size: 27,
                //       color: mainColor,
                //     ),
                //   ],
                // ),
                //),

                // Items

                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    "Products of ${arguments['categoryName']}",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),

                ItemDetailWidget(
                  itemDetails: _categoryDetails,
                ),
                // Items Widget
                // ItemsWidget(
                //   isDetail: true,
                //   isBrand: false,
                //   id: arguments['categoryId'],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
