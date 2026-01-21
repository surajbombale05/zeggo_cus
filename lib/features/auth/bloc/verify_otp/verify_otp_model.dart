// To parse this JSON data, do
//
//     final verifyOtpModel = verifyOtpModelFromJson(jsonString);

import 'dart:convert';

VerifyOtpModel verifyOtpModelFromJson(String str) => VerifyOtpModel.fromJson(json.decode(str));

String verifyOtpModelToJson(VerifyOtpModel data) => json.encode(data.toJson());

class VerifyOtpModel {
    bool? status;
    String? message;
    Data? data;

    VerifyOtpModel({
        this.status,
        this.message,
        this.data,
    });

    factory VerifyOtpModel.fromJson(Map<String, dynamic> json) => VerifyOtpModel(
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
    String? id;
    dynamic name;
    dynamic profilePicture;
    String? phoneNo;
    dynamic email;
    dynamic password;
    String? deviceToken;
    String? deviceId;
    bool? firstTimeUser;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
