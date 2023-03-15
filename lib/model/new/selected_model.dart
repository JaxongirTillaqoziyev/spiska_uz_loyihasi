// To parse this JSON data, do
//
//     final selectedModel = selectedModelFromJson(jsonString);

import 'dart:convert';

SelectedModel selectedModelFromJson(String str) => SelectedModel.fromJson(json.decode(str));

String selectedModelToJson(SelectedModel data) => json.encode(data.toJson());

class SelectedModel {
  SelectedModel({
    required this.id,
    required this.shopId,
    required this.images,
    required this.name,
    required this.description,
    required this.count,
    required this.moneyType,
    required this.category,
    required this.type,
    required this.discountPercentage,
    required this.entryPrice,
    required this.price,
    required this.percent,
    required this.firstCount,
    required this.priceInDollar,
    required this.dollarCurrency,
    required this.sellingPrice,
    required this.barcode,
    required this.likes,
    required this.reports,
  });

  int id;
  int shopId;
  List<String> images;
  String name;
  String description;
  int count;
  String moneyType;
  String category;
  String type;
  int discountPercentage;
  int entryPrice;
  int price;
  int percent;
  int firstCount;
  double priceInDollar;
  int dollarCurrency;
  int sellingPrice;
  String barcode;
  List<Like> likes;
  List<Report> reports;

  SelectedModel copyWith({
    int? id,
    int? shopId,
    List<String>? images,
    String? name,
    String? description,
    int? count,
    String? moneyType,
    String? category,
    String? type,
    int? discountPercentage,
    int? entryPrice,
    int? price,
    int? percent,
    int? firstCount,
    double? priceInDollar,
    int? dollarCurrency,
    int? sellingPrice,
    String? barcode,
    List<Like>? likes,
    List<Report>? reports,
  }) =>
      SelectedModel(
        id: id ?? this.id,
        shopId: shopId ?? this.shopId,
        images: images ?? this.images,
        name: name ?? this.name,
        description: description ?? this.description,
        count: count ?? this.count,
        moneyType: moneyType ?? this.moneyType,
        category: category ?? this.category,
        type: type ?? this.type,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        entryPrice: entryPrice ?? this.entryPrice,
        price: price ?? this.price,
        percent: percent ?? this.percent,
        firstCount: firstCount ?? this.firstCount,
        priceInDollar: priceInDollar ?? this.priceInDollar,
        dollarCurrency: dollarCurrency ?? this.dollarCurrency,
        sellingPrice: sellingPrice ?? this.sellingPrice,
        barcode: barcode ?? this.barcode,
        likes: likes ?? this.likes,
        reports: reports ?? this.reports,
      );

  factory SelectedModel.fromJson(Map<String, dynamic> json) => SelectedModel(
    id: json["id"],
    shopId: json["shop_id"],
    images: List<String>.from(json["images"].map((x) => x)),
    name: json["name"],
    description: json["description"],
    count: json["count"],
    moneyType: json["money_type"],
    category: json["category"],
    type: json["type"],
    discountPercentage: json["discount_percentage"],
    entryPrice: json["entry_price"],
    price: json["price"],
    percent: json["percent"],
    firstCount: json["first_count"],
    priceInDollar: json["price_in_dollar"]?.toDouble(),
    dollarCurrency: json["dollar_currency"],
    sellingPrice: json["selling_price"],
    barcode: json["barcode"],
    likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
    reports: List<Report>.from(json["reports"].map((x) => Report.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "shop_id": shopId,
    "images": List<dynamic>.from(images.map((x) => x)),
    "name": name,
    "description": description,
    "count": count,
    "money_type": moneyType,
    "category": category,
    "type": type,
    "discount_percentage": discountPercentage,
    "entry_price": entryPrice,
    "price": price,
    "percent": percent,
    "first_count": firstCount,
    "price_in_dollar": priceInDollar,
    "dollar_currency": dollarCurrency,
    "selling_price": sellingPrice,
    "barcode": barcode,
    "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
    "reports": List<dynamic>.from(reports.map((x) => x.toJson())),
  };
}

class Like {
  Like({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.img,
    required this.diamond,
  });

  int id;
  String firstName;
  String lastName;
  String phone;
  String img;
  int diamond;

  Like copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? img,
    int? diamond,
  }) =>
      Like(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        img: img ?? this.img,
        diamond: diamond ?? this.diamond,
      );

  factory Like.fromJson(Map<String, dynamic> json) => Like(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    img: json["img"],
    diamond: json["diamond"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "img": img,
    "diamond": diamond,
  };
}

class Report {
  Report({
    required this.userId,
    required this.type,
  });

  int userId;
  String type;

  Report copyWith({
    int? userId,
    String? type,
  }) =>
      Report(
        userId: userId ?? this.userId,
        type: type ?? this.type,
      );

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    userId: json["user-id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "user-id": userId,
    "type": type,
  };
}
