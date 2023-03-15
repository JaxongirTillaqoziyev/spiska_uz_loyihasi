import 'dart:convert';

/// id : 26
/// shop_id : 25
/// images : ["/media/products-img/4e47a590a60fa7379005d2225d67ad2c.webp","/media/products-img/5777865927c69ff82aec804547a1d462.png",""]
/// name : "test3"
/// description : "test3"
/// count : 5
/// money_type : "2"
/// category : "1-kategoriya"
/// type : "1"
/// discount_percentage : 0
/// entry_price : 100000
/// price : 100000
/// percent : 15
/// first_count : 5
/// price_in_dollar : 8.333
/// dollar_currency : 12000
/// selling_price : 115000
/// barcode : "1597846324985"
/// likes : [{"id":8,"first_name":"o'zganbek","last_name":"ibrohimov","phone":"+998903090060","img":"/media/profile-img/scaled_image_picker2811005604174141870.jpg","diamond":200}]

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));
String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.id,
    this.shopId,
    this.images,
    this.name,
    this.description,
    this.count,
    this.moneyType,
    this.category,
    this.type,
    this.discountPercentage,
    this.entryPrice,
    this.price,
    this.percent,
    this.firstCount,
    this.priceInDollar,
    this.dollarCurrency,
    this.sellingPrice,
    this.barcode,
    this.likes,
  });

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    shopId = json['shop_id'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    name = json['name'];
    description = json['description'];
    count = json['count'];
    moneyType = json['money_type'];
    category = json['category'];
    type = json['type'];
    discountPercentage = json['discount_percentage'];
    entryPrice = json['entry_price'];
    price = json['price'];
    percent = json['percent'];
    firstCount = json['first_count'];
    priceInDollar = json['price_in_dollar'];
    dollarCurrency = json['dollar_currency'];
    sellingPrice = json['selling_price'];
    barcode = json['barcode'];
    if (json['likes'] != null) {
      likes = [];
      json['likes'].forEach((v) {
        likes?.add(Likes.fromJson(v));
      });
    }
  }
  num? id;
  num? shopId;
  List<String>? images;
  String? name;
  String? description;
  num? count;
  String? moneyType;
  String? category;
  String? type;
  num? discountPercentage;
  num? entryPrice;
  num? price;
  num? percent;
  num? firstCount;
  num? priceInDollar;
  num? dollarCurrency;
  num? sellingPrice;
  String? barcode;
  List<Likes>? likes;
  ProductModel copyWith({
    num? id,
    num? shopId,
    List<String>? images,
    String? name,
    String? description,
    num? count,
    String? moneyType,
    String? category,
    String? type,
    num? discountPercentage,
    num? entryPrice,
    num? price,
    num? percent,
    num? firstCount,
    num? priceInDollar,
    num? dollarCurrency,
    num? sellingPrice,
    String? barcode,
    List<Likes>? likes,
  }) =>
      ProductModel(
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
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['shop_id'] = shopId;
    map['images'] = images;
    map['name'] = name;
    map['description'] = description;
    map['count'] = count;
    map['money_type'] = moneyType;
    map['category'] = category;
    map['type'] = type;
    map['discount_percentage'] = discountPercentage;
    map['entry_price'] = entryPrice;
    map['price'] = price;
    map['percent'] = percent;
    map['first_count'] = firstCount;
    map['price_in_dollar'] = priceInDollar;
    map['dollar_currency'] = dollarCurrency;
    map['selling_price'] = sellingPrice;
    map['barcode'] = barcode;
    if (likes != null) {
      map['likes'] = likes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 8
/// first_name : "o'zganbek"
/// last_name : "ibrohimov"
/// phone : "+998903090060"
/// img : "/media/profile-img/scaled_image_picker2811005604174141870.jpg"
/// diamond : 200

Likes likesFromJson(String str) => Likes.fromJson(json.decode(str));
String likesToJson(Likes data) => json.encode(data.toJson());

class Likes {
  Likes({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.img,
    this.diamond,
  });

  Likes.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    img = json['img'];
    diamond = json['diamond'];
  }
  num? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? img;
  num? diamond;
  Likes copyWith({
    num? id,
    String? firstName,
    String? lastName,
    String? phone,
    String? img,
    num? diamond,
  }) =>
      Likes(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        img: img ?? this.img,
        diamond: diamond ?? this.diamond,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['phone'] = phone;
    map['img'] = img;
    map['diamond'] = diamond;
    return map;
  }
}
