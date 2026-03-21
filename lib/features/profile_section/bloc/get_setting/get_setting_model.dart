// To parse this JSON data, do
//
//     final getSettingModel = getSettingModelFromJson(jsonString);

import 'dart:convert';

GetSettingModel getSettingModelFromJson(String str) => GetSettingModel.fromJson(json.decode(str));

String getSettingModelToJson(GetSettingModel data) => json.encode(data.toJson());

class GetSettingModel {
    bool? status;
    String? message;
    Data? data;

    GetSettingModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetSettingModel.fromJson(Map<String, dynamic> json) => GetSettingModel(
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
    String? currentVersion;
    String? adminUpi;
    String? adminContactNo;
    String? instaUrl;
    String? youtubeUrl;
    String? razorpayKey;
    String? razorpaySecretKey;
    String? whatsappChannel;
    String? termsAndCondition;
    String? privacyPolicy;
    String? aboutUs;
    String? playStoreLink;
    String? whatsappContactNumber;
    String? author;
    String? websiteLink;
    String? helpSupport;
    DateTime? createdAt;
    DateTime? updatedAt;

    Data({
        this.id,
        this.currentVersion,
        this.adminUpi,
        this.adminContactNo,
        this.instaUrl,
        this.youtubeUrl,
        this.razorpayKey,
        this.razorpaySecretKey,
        this.whatsappChannel,
        this.termsAndCondition,
        this.privacyPolicy,
        this.aboutUs,
        this.playStoreLink,
        this.whatsappContactNumber,
        this.author,
        this.websiteLink,
        this.helpSupport,
        this.createdAt,
        this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        currentVersion: json["current_version"],
        adminUpi: json["admin_upi"],
        adminContactNo: json["admin_contact_no"],
        instaUrl: json["insta_url"],
        youtubeUrl: json["youtube_url"],
        razorpayKey: json["razorpay_key"],
        razorpaySecretKey: json["razorpay_secret_key"],
        whatsappChannel: json["whatsapp_channel"],
        termsAndCondition: json["terms_and_condition"],
        privacyPolicy: json["privacy_policy"],
        aboutUs: json["about_us"],
        playStoreLink: json["playStore_link"],
        whatsappContactNumber: json["whatsapp_contact_number"],
        author: json["author"],
        websiteLink: json["website_link"],
        helpSupport: json["help_support"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "current_version": currentVersion,
        "admin_upi": adminUpi,
        "admin_contact_no": adminContactNo,
        "insta_url": instaUrl,
        "youtube_url": youtubeUrl,
        "razorpay_key": razorpayKey,
        "razorpay_secret_key": razorpaySecretKey,
        "whatsapp_channel": whatsappChannel,
        "terms_and_condition": termsAndCondition,
        "privacy_policy": privacyPolicy,
        "about_us": aboutUs,
        "playStore_link": playStoreLink,
        "whatsapp_contact_number": whatsappContactNumber,
        "author": author,
        "website_link": websiteLink,
        "help_support": helpSupport,
        "createdAt": "${createdAt!.year.toString().padLeft(4, '0')}-${createdAt!.month.toString().padLeft(2, '0')}-${createdAt!.day.toString().padLeft(2, '0')}",
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
