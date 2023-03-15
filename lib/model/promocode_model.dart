import 'dart:convert';

/// id : 1
/// shop-id : 1
/// code : "zvzzwy"
/// rows : []

PromocodeModel promocodeModelFromJson(String str) =>
    PromocodeModel.fromJson(json.decode(str));
String promocodeModelToJson(PromocodeModel data) => json.encode(data.toJson());

class PromocodeModel {
  PromocodeModel({
    this.id,
    this.shopid,
    this.code,
    this.rows,
  });

  PromocodeModel.fromJson(dynamic json) {
    id = json['id'];
    shopid = json['shop-id'];
    code = json['code'];
    if (json['rows'] != null) {
      rows = [];
      json['rows'].forEach((v) {
        rows?.add(v);
      });
    }
  }
  num? id;
  num? shopid;
  String? code;
  List<dynamic>? rows;
  PromocodeModel copyWith({
    num? id,
    num? shopId,
    String? code,
    List<dynamic>? rows,
  }) =>
      PromocodeModel(
        id: id ?? this.id,
        shopid: shopId ?? shopid,
        code: code ?? this.code,
        rows: rows ?? this.rows,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['shop-id'] = shopid;
    map['code'] = code;
    if (rows != null) {
      map['rows'] = rows?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
