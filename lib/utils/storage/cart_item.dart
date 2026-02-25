class CartItem {
  final String productId;
  final String name;
  final double price;
  final String image;
  final String unit;
  int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.unit,
    required this.quantity,
  });

  /// ✅ Empty cart item (SAFE fallback)
  factory CartItem.empty() => CartItem(
        productId: '',
        name: '',
        price: 0,
        image: '',
        unit: '',
        quantity: 0,
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "price": price,
        "image": image,
        "unit": unit,
        "quantity": quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json["productId"] ?? "",
        name: json["name"] ?? "",
        price: (json["price"] as num?)?.toDouble() ?? 0,
        image: json["image"] ?? "",
        unit: json["unit"] ?? "",
        quantity: json["quantity"] ?? 0,
      );

  CartItem copyWith({
    String? productId,
    String? name,
    double? price,
    String? image,
    String? unit,
    int? quantity,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
    );
  }
}
