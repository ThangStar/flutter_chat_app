// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

class Product {
    int id;
    String name;
    int price;
    int amount;
    String category;
    String size;
    String image;
    String colors;
    int isOnline;

    Product({
        required this.id,
        required this.name,
        required this.price,
        required this.amount,
        required this.category,
        required this.size,
        required this.image,
        required this.colors,
        required this.isOnline,
    });

    factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        amount: json["amount"],
        category: json["category"],
        size: json["size"],
        image: json["image"],
        colors: json["colors"],
        isOnline: json["isOnline"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "amount": amount,
        "category": category,
        "size": size,
        "image": image,
        "colors": colors,
        "isOnline": isOnline,
    };
}
