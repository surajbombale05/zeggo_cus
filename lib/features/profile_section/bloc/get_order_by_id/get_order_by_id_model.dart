// To parse this JSON data, do
//
//     final getOrderByIdModel = getOrderByIdModelFromJson(jsonString);

import 'dart:convert';

GetOrderByIdModel getOrderByIdModelFromJson(String str) => GetOrderByIdModel.fromJson(json.decode(str));

String getOrderByIdModelToJson(GetOrderByIdModel data) => json.encode(data.toJson());

class GetOrderByIdModel {
  bool? status;
  String? message;
  Data? data;

  GetOrderByIdModel({this.status, this.message, this.data});

  factory GetOrderByIdModel.fromJson(Map<String, dynamic> json) => GetOrderByIdModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"status": status, "message": message, "data": data?.toJson()};
}

class Data {
  String? id;
  String? name;
  String? orderStatus;
  String? totalAmount;
  String? deliveryFee;
  String? userId;
  String? paymentMode;
  String? addressId;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? user;
  Address? address;
  List<Item>? items;

  Data({
    this.id,
    this.name,
    this.orderStatus,
    this.totalAmount,
    this.deliveryFee,
    this.userId,
    this.addressId,
    this.createdAt,
    this.paymentMode,
    this.updatedAt,
    this.user,
    this.address,
    this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    orderStatus: json["order_status"],
    totalAmount: json["total_amount"],
    deliveryFee: json["delivery_fee"],
    userId: json["user_id"],
    addressId: json["address_id"],
    paymentMode: json["payment_method"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "order_status": orderStatus,
    "total_amount": totalAmount,
    "delivery_fee": deliveryFee,
    "user_id": userId,
    "address_id": addressId,
    "payment_method": paymentMode,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "user": user?.toJson(),
    "address": address?.toJson(),
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
  };
}

class Address {
  String? id;
  String? addType;
  String? fullName;
  String? phoneNo;
  String? fullAddress;
  String? city;
  String? zipCode;
  bool? isPrimary;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Address({
    this.id,
    this.addType,
    this.fullName,
    this.phoneNo,
    this.fullAddress,
    this.city,
    this.zipCode,
    this.isPrimary,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    addType: json["add_type"],
    fullName: json["full_name"],
    phoneNo: json["phone_no"],
    fullAddress: json["full_address"],
    city: json["city"],
    zipCode: json["zip_code"],
    isPrimary: json["is_primary"],
    userId: json["user_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "add_type": addType,
    "full_name": fullName,
    "phone_no": phoneNo,
    "full_address": fullAddress,
    "city": city,
    "zip_code": zipCode,
    "is_primary": isPrimary,
    "user_id": userId,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Item {
  String? id;
  String? orderId;
  String? productId;
  int? quantity;
  String? price;
  DateTime? createdAt;
  DateTime? updatedAt;
  Product? product;

  Item({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    orderId: json["order_id"],
    productId: json["product_id"],
    quantity: json["quantity"],
    price: json["price"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "product_id": productId,
    "quantity": quantity,
    "price": price,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "product": product?.toJson(),
  };
}

class Product {
  String? id;
  String? name;
  String? categoryId;
  String? subcategoryId;
  String? img;
  String? offerPrice;
  String? actualPrice;
  String? productDetails;
  bool? isTrending;
  String? percentOff;
  String? unit;
  bool? isCafe;
  int? quantity;
  DateTime? createdAt;
  DateTime? updatedAt;

  Product({
    this.id,
    this.name,
    this.categoryId,
    this.subcategoryId,
    this.img,
    this.offerPrice,
    this.actualPrice,
    this.productDetails,
    this.isTrending,
    this.percentOff,
    this.unit,
    this.isCafe,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    categoryId: json["category_id"],
    subcategoryId: json["subcategory_id"],
    img: json["img"],
    offerPrice: json["offer_price"],
    actualPrice: json["actual_price"],
    productDetails: json["product_details"],
    isTrending: json["is_trending"],
    percentOff: json["percent_off"],
    unit: json["unit"],
    isCafe: json["is_cafe"],
    quantity: json["quantity"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category_id": categoryId,
    "subcategory_id": subcategoryId,
    "img": img,
    "offer_price": offerPrice,
    "actual_price": actualPrice,
    "product_details": productDetails,
    "is_trending": isTrending,
    "percent_off": percentOff,
    "unit": unit,
    "is_cafe": isCafe,
    "quantity": quantity,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class User {
  String? id;
  String? name;
  String? profilePicture;
  String? phoneNo;
  String? email;
  dynamic password;
  String? deviceToken;
  String? deviceId;
  bool? firstTimeUser;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.profilePicture,
    this.phoneNo,
    this.email,
    this.password,
    this.deviceToken,
    this.deviceId,
    this.firstTimeUser,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    profilePicture: json["profile_picture"],
    phoneNo: json["phone_no"],
    email: json["email"],
    password: json["password"],
    deviceToken: json["device_token"],
    deviceId: json["device_id"],
    firstTimeUser: json["first_time_user"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "profile_picture": profilePicture,
    "phone_no": phoneNo,
    "email": email,
    "password": password,
    "device_token": deviceToken,
    "device_id": deviceId,
    "first_time_user": firstTimeUser,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
