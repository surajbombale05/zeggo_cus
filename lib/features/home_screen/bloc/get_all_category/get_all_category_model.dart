// To parse this JSON data, do
//
//     final getCategoryModel = getCategoryModelFromJson(jsonString);

import 'dart:convert';

GetCategoryModel getCategoryModelFromJson(String str) => GetCategoryModel.fromJson(json.decode(str));

String getCategoryModelToJson(GetCategoryModel data) => json.encode(data.toJson());

class GetCategoryModel {
    bool? status;
    String? message;
    List<Datum>? data;

    GetCategoryModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetCategoryModel.fromJson(Map<String, dynamic> json) => GetCategoryModel(
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
    dynamic img;
    String? des;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Datum>? subcategories;
    String? categoryId;

    Datum({
        this.id,
        this.name,
        this.img,
        this.des,
        this.createdAt,
        this.updatedAt,
        this.subcategories,
        this.categoryId,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        des: json["des"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        subcategories: json["subcategories"] == null ? [] : List<Datum>.from(json["subcategories"]!.map((x) => Datum.fromJson(x))),
        categoryId: json["category_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "des": des,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "subcategories": subcategories == null ? [] : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
        "category_id": categoryId,
    };
}
