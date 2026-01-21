// To parse this JSON data, do
//
//     final getAllAddressModel = getAllAddressModelFromJson(jsonString);

import 'dart:convert';

GetAllAddressModel getAllAddressModelFromJson(String str) => GetAllAddressModel.fromJson(json.decode(str));

String getAllAddressModelToJson(GetAllAddressModel data) => json.encode(data.toJson());

class GetAllAddressModel {
    bool? status;
    String? message;
    List<Datum>? data;

    GetAllAddressModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetAllAddressModel.fromJson(Map<String, dynamic> json) => GetAllAddressModel(
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
    String? addType;
    String? fullName;
    String? phoneNo;
    String? fullAddress;
    String? city;
    String? zipCode;
    bool? isPrimary;
    String? userId;
    DateTime? createdAt;
    DateTime? updatedAt;
    User? user;

    Datum({
        this.id,
        this.addType,
        this.fullName,
        this.phoneNo,
        this.fullAddress,
        this.city,
        this.zipCode,
        this.isPrimary,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.user,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        addType: json["add_type"],
        fullName: json["full_name"],
        phoneNo: json["phone_no"],
        fullAddress: json["full_address"],
        city: json["city"],
        zipCode: json["zip_code"],
        isPrimary: json["is_primary"],
        userId: json["user_id"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "add_type": addType,
        "full_name": fullName,
        "phone_no": phoneNo,
        "full_address": fullAddress,
        "city": city,
        "zip_code": zipCode,
        "is_primary": isPrimary,
        "user_id": userId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
    };
}

class User {
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

    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
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
