import 'package:flutter/material.dart';
import 'package:rental_user/global_variables.dart';
import 'package:rental_user/home/controllers/brand_details_controller.dart';
import 'package:rental_user/home/models/item_model.dart';
import 'package:rental_user/home/widgets/item_widget.dart';

class BrandDetails extends StatefulWidget {
  final String id;

  const BrandDetails({super.key, required this.id});

  @override
  State<BrandDetails> createState() => _BrandDetailsState();
}

class _BrandDetailsState extends State<BrandDetails> {
  final BrandDetailController _brandDetailController = BrandDetailController();
  List<ItemDetail> _brandDetails = [];

  @override
  void initState() {
    super.initState();
    fetchBrandDetails();
  }

  Future<void> fetchBrandDetails() async {
    try {
      List<ItemDetail> fetchedCategoryDetails = await _brandDetailController
          .requestBrandDetails(context: context, brandId: widget.id);

      setState(() {
        _brandDetails = fetchedCategoryDetails;
      });
    } catch (e) {
      const Text("Error Fetching Category.");
    }
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
                    "Brand Details",
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
                          decoration: const InputDecoration(
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

                // Items

                Container(
                  alignment: Alignment.centerLeft,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Text(
                    "Products of ${arguments['brandName']}",
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                    ),
                  ),
                ),

                // Items Widget
                ItemDetailWidget(
                  itemDetails: _brandDetails,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
