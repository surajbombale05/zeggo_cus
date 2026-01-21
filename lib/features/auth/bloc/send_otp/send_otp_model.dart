// To parse this JSON data, do
//
//     final sendOtpModel = sendOtpModelFromJson(jsonString);

import 'dart:convert';

SendOtpModel sendOtpModelFromJson(String str) => SendOtpModel.fromJson(json.decode(str));

String sendOtpModelToJson(SendOtpModel data) => json.encode(data.toJson());

class SendOtpModel {
    bool? status;
    String? message;
    Data? data;

    SendOtpModel({
        this.status,
        this.message,
        this.data,
    });

    factory SendOtpModel.fromJson(Map<String, dynamic> json) => SendOtpModel(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    String? phoneNo;
    String? otp;

    Data({
        this.phoneNo,
        this.otp,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        phoneNo: json["phone_no"],
        otp: json["otp"],
    );

    Map<String, dynamic> toJson() => {
        "phone_no": phoneNo,
        "otp": otp,
    };
}
