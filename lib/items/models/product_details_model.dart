class ProductDetails {
  final String id;
  final String imgLink;
  final String name;
  final String energyConsumption;
  List<String> colors;
  List<String> size;
  List<String> extra;
  final String description;
  final String price;
  final String productCode;
  final String brand;
  List<String> category;
  final String durationDate;
  final String insurenceDate;
  List<String> business;
  String? vendor;

  ProductDetails({
    required this.id,
    required this.imgLink,
    required this.name,
    required this.energyConsumption,
    required this.colors,
    required this.size,
    required this.extra,
    required this.description,
    required this.price,
    required this.productCode,
    required this.brand,
    required this.category,
    required this.durationDate,
    required this.insurenceDate,
    required this.business,
    this.vendor,
  });
}
