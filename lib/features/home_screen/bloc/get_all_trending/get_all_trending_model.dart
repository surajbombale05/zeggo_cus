// To parse this JSON data, do
//
//     final getAllTrendingModel = getAllTrendingModelFromJson(jsonString);

import 'dart:convert';

import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_model.dart';

GetAllTrendingModel getAllTrendingModelFromJson(String str) => GetAllTrendingModel.fromJson(json.decode(str));

String getAllTrendingModelToJson(GetAllTrendingModel data) => json.encode(data.toJson());

class GetAllTrendingModel {
    bool? status;
    String? message;
    List<Datum>? data;

    GetAllTrendingModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetAllTrendingModel.fromJson(Map<String, dynamic> json) => GetAllTrendingModel(
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
