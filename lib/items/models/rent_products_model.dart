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

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'rent_duration': rentDuration,
      'size': size,
      'color': color,
      'qty': qty,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'product': products.map((product) => product.toJson()).toList(),
      'phone': phone,
      'name': name,
      'address': address,
      'notes': notes,
    };
  }
}
