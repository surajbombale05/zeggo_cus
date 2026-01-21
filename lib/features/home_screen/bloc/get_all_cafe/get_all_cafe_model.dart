// To parse this JSON data, do
//
//     final getAllCafeModel = getAllCafeModelFromJson(jsonString);

import 'dart:convert';

import 'package:zeggo_cus/features/home_screen/bloc/get_all_products/get_all_products_model.dart';

GetAllCafeModel getAllCafeModelFromJson(String str) => GetAllCafeModel.fromJson(json.decode(str));

String getAllCafeModelToJson(GetAllCafeModel data) => json.encode(data.toJson());

class GetAllCafeModel {
  bool? status;
  String? message;
  List<Datum>? data;

  GetAllCafeModel({this.status, this.message, this.data});

  factory GetAllCafeModel.fromJson(Map<String, dynamic> json) => GetAllCafeModel(
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

