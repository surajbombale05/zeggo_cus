// To parse this JSON data, do
//
//     final getAllOrdersModel = getAllOrdersModelFromJson(jsonString);

import 'dart:convert';

GetAllOrdersModel getAllOrdersModelFromJson(String str) => GetAllOrdersModel.fromJson(json.decode(str));

String getAllOrdersModelToJson(GetAllOrdersModel data) => json.encode(data.toJson());

class GetAllOrdersModel {
    bool? status;
    String? message;
    List<Datum>? data;

    GetAllOrdersModel({
        this.status,
        this.message,
        this.data,
    });

    factory GetAllOrdersModel.fromJson(Map<String, dynamic> json) => GetAllOrdersModel(
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
    String? orderStatus;
    String? totalAmount;
    String? deliveryFee;
    String? paymentMode;
    String? userId;
    String? addressId;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Item>? items;

    Datum({
        this.id,
        this.name,
        this.orderStatus,
        this.totalAmount,
        this.deliveryFee,
        this.userId,
        this.paymentMode,
        this.addressId,
        this.createdAt,
        this.updatedAt,
        this.items,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        orderStatus: json["order_status"],
        totalAmount: json["total_amount"],
        deliveryFee: json["delivery_fee"],
        userId: json["user_id"],
        addressId: json["address_id"],
        paymentMode: json["payment_method"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "order_status": orderStatus,
        "total_amount": totalAmount,
        "delivery_fee": deliveryFee,
        "user_id": userId,
        "address_id": addressId,
        "payment_method":paymentMode,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    };
}

class Item {
    String? id;
    String? orderId;
    String? productId;
    dynamic quantity;
    String? price;
    DateTime? createdAt;
    DateTime? updatedAt;
    Product? product;

    Item({
        this.id,
        this.orderId,
        this.productId,
        this.quantity,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.product,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        price: json["price"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "price": price,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "product": product?.toJson(),
    };
}

class Product {
    String? id;
    String? name;
    String? categoryId;
    String? subcategoryId;
    String? img;
    String? offerPrice;
    String? actualPrice;
    String? productDetails;
    bool? isTrending;
    String? percentOff;
    String? unit;
    bool? isCafe;
    dynamic quantity;
    DateTime? createdAt;
    DateTime? updatedAt;

    Product({
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
        this.unit,
        this.isCafe,
        this.quantity,
        this.createdAt,
        this.updatedAt,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        unit: json["unit"],
        isCafe: json["is_cafe"],
        quantity: json["quantity"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
        "unit": unit,
        "is_cafe": isCafe,
        "quantity": quantity,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}
