// import 'dart:convert';
//
// /// id : 3
// /// shop_id : 15
// /// images : ["/media/products-img/photo_2021-05-21_12-41-17.jpg","/media/products-img/Screenshot_284.png","/media/products-img/background.png"]
// /// name : "DDDDDD"
// /// description : "dddd"
// /// count : 12
// /// money_type : "1"
// /// type : "1"
// /// entry_price : 12000
// /// price : 12000
// /// percent : 12
// /// selling_price : 13200
// /// company : "Spiskauz"
// /// likes : []
// /// views : []
//
// ShopProductModel shopProductModelFromJson(String str) =>
//     ShopProductModel.fromJson(json.decode(str));
// String shopProductModelToJson(ShopProductModel data) =>
//     json.encode(data.toJson());
//
// class ShopProductModel {
//   ShopProductModel({
//     this.id,
//     this.shopId,
//     this.images,
//     this.name,
//     this.description,
//     this.count,
//     this.moneyType,
//     this.type,
//     this.entryPrice,
//     this.price,
//     this.percent,
//     this.sellingPrice,
//     this.company,
//     this.likes,
//     this.views,
//   });
//
//   ShopProductModel.fromJson(dynamic json) {
//     id = json['id'];
//     shopId = json['shop_id'];
//     images = json['images'] != null ? json['images'].cast<String>() : [];
//     name = json['name'];
//     description = json['description'];
//     count = json['count'];
//     moneyType = json['money_type'];
//     type = json['type'];
//     entryPrice = json['entry_price'];
//     price = json['price'];
//     percent = json['percent'];
//     sellingPrice = json['selling_price'];
//     company = json['company'];
//     if (json['likes'] != null) {
//       likes = [];
//       json['likes'].forEach((v) {
//         likes?.add(v);
//       });
//     }
//     if (json['views'] != null) {
//       views = [];
//       json['views'].forEach((v) {
//         views?.add(v);
//       });
//     }
//   }
//   num? id;
//   num? shopId;
//   List<String>? images;
//   String? name;
//   String? description;
//   num? count;
//   String? moneyType;
//   String? type;
//   num? entryPrice;
//   num? price;
//   num? percent;
//   num? sellingPrice;
//   String? company;
//   List<dynamic>? likes;
//   List<dynamic>? views;
//   ShopProductModel copyWith({
//     num? id,
//     num? shopId,
//     List<String>? images,
//     String? name,
//     String? description,
//     num? count,
//     String? moneyType,
//     String? type,
//     num? entryPrice,
//     num? price,
//     num? percent,
//     num? sellingPrice,
//     String? company,
//     List<dynamic>? likes,
//     List<dynamic>? views,
//   }) =>
//       ShopProductModel(
//         id: id ?? this.id,
//         shopId: shopId ?? this.shopId,
//         images: images ?? this.images,
//         name: name ?? this.name,
//         description: description ?? this.description,
//         count: count ?? this.count,
//         moneyType: moneyType ?? this.moneyType,
//         type: type ?? this.type,
//         entryPrice: entryPrice ?? this.entryPrice,
//         price: price ?? this.price,
//         percent: percent ?? this.percent,
//         sellingPrice: sellingPrice ?? this.sellingPrice,
//         company: company ?? this.company,
//         likes: likes ?? this.likes,
//         views: views ?? this.views,
//       );
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['shop_id'] = shopId;
//     map['images'] = images;
//     map['name'] = name;
//     map['description'] = description;
//     map['count'] = count;
//     map['money_type'] = moneyType;
//     map['type'] = type;
//     map['entry_price'] = entryPrice;
//     map['price'] = price;
//     map['percent'] = percent;
//     map['selling_price'] = sellingPrice;
//     map['company'] = company;
//     if (likes != null) {
//       map['likes'] = likes?.map((v) => v.toJson()).toList();
//     }
//     if (views != null) {
//       map['views'] = views?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }
