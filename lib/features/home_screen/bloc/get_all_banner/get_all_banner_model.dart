// To parse this JSON data, do
//
//     final getAllBannerModel = getAllBannerModelFromJson(jsonString);

import 'dart:convert';

GetAllBannerModel getAllBannerModelFromJson(String str) => GetAllBannerModel.fromJson(json.decode(str));

String getAllBannerModelToJson(GetAllBannerModel data) => json.encode(data.toJson());

class GetAllBannerModel {
    bool? status;
    String? message;
    List<Datum>? data;

    GetAllBannerModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetAllBannerModel.fromJson(Map<String, dynamic> json) => GetAllBannerModel(
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
    String? img;
    DateTime? createdAt;
    DateTime? updatedAt;

    Datum({
        this.id,
        this.name,
        this.img,
        this.createdAt,
        this.updatedAt,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        img: json["img"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "img": img,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
