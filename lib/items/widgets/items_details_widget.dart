import 'package:flutter/material.dart';
import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:marquee/marquee.dart';
import 'package:rental_user/items/models/product_details_model.dart';
import 'package:rental_user/items/widgets/item_appbar.dart';
import 'package:rental_user/global_variables.dart';

class ItemDetails extends StatefulWidget {
  final String productId, productName;
  final ProductDetails productDetails;

  const ItemDetails(
      {super.key,
      required this.productId,
      required this.productName,
      required this.productDetails});

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int quantity = 1;
  String size = "medium";
  ValueNotifier<int?> priorityIndex = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.red,
      Colors.blue,
    ];

    return widget.productDetails != null
        ? ListView(
            children: [
              const ItemAppBar(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Image.network(
                  widget.productDetails.imgLink,
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
                          padding: const EdgeInsets.only(top: 48, bottom: 15),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 32,
                                width: 350,
                                child: widget.productDetails.name
                                            .toString()
                                            .length >
                                        20
                                    ? Marquee(
                                        text: widget.productDetails
                                            .name, // Here is Product Name
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
                                        accelerationCurve: Curves.linear,
                                        decelerationDuration:
                                            const Duration(milliseconds: 500),
                                        decelerationCurve: Curves.easeOut,
                                      )
                                    : Text(
                                        widget.productDetails.name,
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
                          padding: const EdgeInsets.only(top: 5, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // RatingBar.builder(
                              //   initialRating: 4,
                              //   minRating: 1,
                              //   direction: Axis.horizontal,
                              //   itemCount: 5,
                              //   itemSize: 25,
                              //   itemPadding: const EdgeInsets.symmetric(
                              //       horizontal: 4),
                              //   itemBuilder: (context, _) => const Icon(
                              //     Icons.star,
                              //     color: mainColor,
                              //   ),
                              //   onRatingUpdate: (index) {},
                              // ),

                              Text(
                                "Energy Consumption : ${widget.productDetails.energyConsumption}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),

                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
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
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Text(
                                "Brand : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.productDetails.brand,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Text(
                                "Category : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              for (final category
                                  in widget.productDetails.category)
                                Text(
                                  category,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              const Text(
                                "Size : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                children: List.generate(
                                  widget.productDetails.size.length,
                                  (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: ValueListenableBuilder(
                                          valueListenable: priorityIndex,
                                          builder: (context, priority, _) {
                                            return GestureDetector(
                                              onTap: () {
                                                priorityIndex.value = index;
                                                size = widget
                                                    .productDetails.size[index];
                                                print(size);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: priority == index
                                                      ? Colors.amberAccent
                                                      : Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 2,
                                                      blurRadius: 8,
                                                    ),
                                                  ],
                                                ),
                                                width: 100,
                                                height: 30,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  widget.productDetails
                                                      .size[index],
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: mainColor,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Text(
                                "Product Code : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.productDetails.productCode,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Text(
                                "Duration Date : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${widget.productDetails.durationDate.toString()} Months",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Text(
                                "Insurence Date : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                "${widget.productDetails.insurenceDate.toString()} Months",
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Text(
                                "Business : ",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              for (final business
                                  in widget.productDetails.business)
                                Text(
                                  business,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                            ],
                          ),
                        ),
                        widget.productDetails.vendor != null
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Vendor : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: mainColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      widget.productDetails.vendor.toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: mainColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(
                                height: 1,
                              ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Text(
                                "Extra devices : ",
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
                                  for (int i = 0;
                                      i < widget.productDetails.extra.length;
                                      i++)
                                    Container(
                                      height: 30,
                                      width: 100,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 8,
                                            ),
                                          ]),
                                      child: Text(
                                        widget.productDetails.extra[i]
                                            .toString(),
                                        style: const TextStyle(
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
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Text(
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
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                          color: colors.elementAt(i),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(
                            widget.productDetails.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 17,
                              color: mainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Text('Here is testing'),
            ],
          )
        : const Text("No Data");
  }
}
