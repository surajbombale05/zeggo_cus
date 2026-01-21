// To parse this JSON data, do
//
//     final getAllTrendingProductModel = getAllTrendingProductModelFromJson(jsonString);

import 'dart:convert';

GetAllTrendingProductModel getAllTrendingProductModelFromJson(String str) => GetAllTrendingProductModel.fromJson(json.decode(str));

String getAllTrendingProductModelToJson(GetAllTrendingProductModel data) => json.encode(data.toJson());

class GetAllTrendingProductModel {
    bool? status;
    String? message;
    List<Datum>? data;

    GetAllTrendingProductModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetAllTrendingProductModel.fromJson(Map<String, dynamic> json) => GetAllTrendingProductModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
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
    int? quantity;
    DateTime? createdAt;
    DateTime? updatedAt;
    Category? category;
    Category? subcategory;

    Datum({
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
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.category,
        this.subcategory,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
        quantity: json["quantity"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        subcategory: json["subcategory"] == null ? null : Category.fromJson(json["subcategory"]),
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
        "quantity": quantity,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "category": category?.toJson(),
        "subcategory": subcategory?.toJson(),
    };
}

class Category {
    String? id;
    String? name;
    dynamic img;
    String? des;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? categoryId;

    Category({
        this.id,
        this.name,
        this.img,
        this.des,
        this.createdAt,
        this.updatedAt,
        this.categoryId,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        des: json["des"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        categoryId: json["category_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "des": des,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "category_id": categoryId,
    };
}
