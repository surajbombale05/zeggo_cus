// To parse this JSON data, do
//
//     final getAllWishlistModel = getAllWishlistModelFromJson(jsonString);

import 'dart:convert';

GetAllWishlistModel getAllWishlistModelFromJson(String str) => GetAllWishlistModel.fromJson(json.decode(str));

String getAllWishlistModelToJson(GetAllWishlistModel data) => json.encode(data.toJson());

class GetAllWishlistModel {
    bool? status;
    String? message;
    int? totalLikedProducts;
    List<Datum>? data;

    GetAllWishlistModel({
        this.status,
        this.message,
        this.totalLikedProducts,
        this.data,
    });

    factory GetAllWishlistModel.fromJson(Map<String, dynamic> json) => GetAllWishlistModel(
        status: json["status"],
        message: json["message"],
        totalLikedProducts: json["total_liked_products"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "total_liked_products": totalLikedProducts,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? productId;
    String? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    Product? product;
    User? user;

    Datum({
        this.id,
        this.productId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.user,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        userId: json["UserId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "UserId": userId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
        "user": user?.toJson(),
    };
}

class Product {
    String? id;
    String? name;
    String? categoryId;
    String? subcategoryId;
    dynamic img;
    String? offerPrice;
    String? actualPrice;
    String? productDetails;
    bool? isTrending;
    String? percentOff;
    dynamic unit;
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
    dynamic name;
    String? phoneNo;

    User({
        this.id,
        this.name,
        this.phoneNo,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        phoneNo: json["phone_no"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_no": phoneNo,
    };
}
