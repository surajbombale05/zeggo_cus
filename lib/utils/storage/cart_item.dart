class CartItem {
  final String productId;
  final String name;
  final double price;
  final String image;
  final String unit;
  int quantity;
  final String superCategory;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    required this.image,
    required this.unit,
    required this.quantity,
    required this.superCategory,
  });

  factory CartItem.empty() => CartItem(
        productId: '',
        name: '',
        price: 0,
        image: '',
        unit: '',
        quantity: 0,
        superCategory: 'grocery',
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "name": name,
        "price": price,
        "image": image,
        "unit": unit,
        "quantity": quantity,
        "super_category": superCategory,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        productId: json["product_id"] ?? "",
        name: json["name"] ?? "",
        price: (json["price"] as num?)?.toDouble() ?? 0,
        image: json["image"] ?? "",
        unit: json["unit"] ?? "",
        quantity: json["quantity"] ?? 0,
        superCategory: json["super_category"] ?? "grocery",
      );

  CartItem copyWith({
    String? productId,
    String? name,
    double? price,
    String? image,
    String? unit,
    dynamic quantity,
    String? superCategory,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      image: image ?? this.image,
      unit: unit ?? this.unit,
      quantity: quantity ?? this.quantity,
      superCategory: superCategory ?? this.superCategory,
    );
  }
}
