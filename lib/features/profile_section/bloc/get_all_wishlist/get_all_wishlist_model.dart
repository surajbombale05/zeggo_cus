// To parse this JSON data, do
//
//     final getAllWishlistModel = getAllWishlistModelFromJson(jsonString);

import 'dart:convert';

import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_model.dart';

GetAllWishlistModel getAllWishlistModelFromJson(String str) => GetAllWishlistModel.fromJson(json.decode(str));

String getAllWishlistModelToJson(GetAllWishlistModel data) => json.encode(data.toJson());

class GetAllWishlistModel {
    bool? status;
    String? message;
    int? totalLikedProducts;
    List<Datums>? data;

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
        data: json["data"] == null ? [] : List<Datums>.from(json["data"]!.map((x) => Datums.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "total_liked_products": totalLikedProducts,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datums {
    String? id;
    String? productId;
    String? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    Datum? product;
    User? user;

    Datums({
        this.id,
        this.productId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.user,
    });

    factory Datums.fromJson(Map<String, dynamic> json) => Datums(
        id: json["id"],
        productId: json["product_id"],
        userId: json["UserId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        product: json["product"] == null ? null : Datum.fromJson(json["product"]),
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
