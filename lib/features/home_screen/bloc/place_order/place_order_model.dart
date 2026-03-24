// To parse this JSON data, do
//
//     final placeOrderModel = placeOrderModelFromJson(jsonString);

import 'dart:convert';

PlaceOrderModel placeOrderModelFromJson(String str) => PlaceOrderModel.fromJson(json.decode(str));

String placeOrderModelToJson(PlaceOrderModel data) => json.encode(data.toJson());

class PlaceOrderModel {
  bool? status;
  String? message;
  Data? data;

  PlaceOrderModel({this.status, this.message, this.data});

  factory PlaceOrderModel.fromJson(Map<String, dynamic> json) => PlaceOrderModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"status": status, "message": message, "data": data?.toJson()};
}

class Data {
  dynamic orderId;

  Data({this.orderId});

  factory Data.fromJson(Map<String, dynamic> json) => Data(orderId: json["order_id"]);

  Map<String, dynamic> toJson() => {"order_id": orderId};
}
