import 'package:flutter/material.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:marquee/marquee.dart';
import 'package:rental_user/items/widgets/item_appbar.dart';

import 'package:rental_user/global_variables.dart';
import 'package:rental_user/items/controllers/items_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemDetails extends StatefulWidget {
  final String productId, productName;
  const ItemDetails(
      {super.key, required this.productId, required this.productName});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.red,
      Colors.blue,
    ];
    Map<String, dynamic>? productDetails;

    return FutureBuilder<List<Map<String, dynamic>>>(
        future:
            requestItemDetails(context: context, productId: widget.productId),
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

              //await prefs.remove('credentials');
              //Navigator.pushReplacementNamed(context, '/login');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Token expired! You need to login again."),
                  duration: Duration(seconds: 10),
                ),
              );
            });

            return const SizedBox();
          } else if (snapshot.hasData) {
            final details = snapshot.data!;
            for (final detail in details) {
              if (detail['_id'] == widget.productId) {
                productDetails = detail;
                break;
              }
            }

            return productDetails != null
                ? ListView(
                    children: [
                      const ItemAppBar(),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Image.network(
                          productDetails?['main_thambnail']?['media_link']
                                  .toString() ??
                              '',
                          height: 300,
                        ),
                      ),
                      Arc(
                        edge: Edge.TOP,
                        arcType: ArcType.CONVEY,
                        height: 30,
                        child: Container(
                          width: double.infinity,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 48, bottom: 15),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        height: 32,
                                        width: 350,
                                        child: productDetails!['name']
                                                    .toString()
                                                    .length >
                                                23
                                            ? Marquee(
                                                text: productDetails?['name']
                                                        .toString() ??
                                                    '', // Here is Product Name
                                                style: const TextStyle(
                                                  fontSize: 28,
                                                  color: mainColor,
                                                ),
                                                scrollAxis: Axis.horizontal,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                blankSpace: 30.0,
                                                velocity: 85.0,
                                                pauseAfterRound:
                                                    const Duration(seconds: 2),
                                                startPadding: 10.0,
                                                accelerationDuration:
                                                    const Duration(seconds: 1),
                                                accelerationCurve:
                                                    Curves.linear,
                                                decelerationDuration:
                                                    const Duration(
                                                        milliseconds: 500),
                                                decelerationCurve:
                                                    Curves.easeOut,
                                              )
                                            : Text(
                                                productDetails?['name']
                                                        .toString() ??
                                                    '',
                                                style: const TextStyle(
                                                  fontSize: 28,
                                                  color: mainColor,
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RatingBar.builder(
                                        initialRating: 4,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemSize: 25,
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 4),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: mainColor,
                                        ),
                                        onRatingUpdate: (index) {},
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 3,
                                                    blurRadius: 10,
                                                    offset: const Offset(0, 3),
                                                  ),
                                                ]),
                                            child: Icon(
                                              CupertinoIcons.minus,
                                              size: 18,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Text(
                                              "01",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: mainColor,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 3,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ]),
                                            child: Icon(
                                              CupertinoIcons.plus,
                                              size: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    "This is more detailed description of the product. Here I will call the description of the product from api. Thanks.",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: mainColor,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Size : ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: mainColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          for (int i = 5; i < 10; i++)
                                            Container(
                                              height: 30,
                                              width: 30,
                                              alignment: Alignment.center,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 8,
                                                    ),
                                                  ]),
                                              child: Text(
                                                i.toString(),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: mainColor,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Color : ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: mainColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          for (int i = 0; i < 5; i++)
                                            Container(
                                              height: 30,
                                              width: 30,
                                              alignment: Alignment.center,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              decoration: BoxDecoration(
                                                  color: colors.elementAt(i),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 8,
                                                    ),
                                                  ]),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Text('No Data available.');
          } else {
            return const Text('No data available');
          }
        });
  }
}
