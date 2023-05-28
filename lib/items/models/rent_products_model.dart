class Product {
  String productId;
  String rentDuration;
  String size;
  String color;
  String qty;

  Product({
    required this.productId,
    required this.rentDuration,
    required this.size,
    required this.color,
    required this.qty,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['product_id'],
      rentDuration: json['rent_duration'],
      size: json['size'],
      color: json['color'],
      qty: json['qty'],
    );
  }
}

class RentalRequest {
  List<Product> products;
  String phone;
  String name;
  String address;
  String notes;

  RentalRequest({
    required this.products,
    required this.phone,
    required this.name,
    required this.address,
    required this.notes,
  });

  factory RentalRequest.fromJson(Map<String, dynamic> json) {
    List<Product> products = (json['product'] as List<dynamic>)
        .map((productJson) => Product.fromJson(productJson))
        .toList();

    return RentalRequest(
      products: products,
      phone: json['phone'],
      name: json['name'],
      address: json['address'],
      notes: json['notes'],
    );
  }
}
