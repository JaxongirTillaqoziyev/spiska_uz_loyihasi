import 'dart:convert';
OutcomeModel expenseModelFromJson(String str) =>
    OutcomeModel.fromJson(json.decode(str));
String expenseModelToJson(OutcomeModel data) => json.encode(data.toJson());
class OutcomeModel {
  OutcomeModel({
    this.id,
    this.name,
    this.count,
    this.entryPrice,
    this.dollarCurrency,
    this.date,
    this.type,
    this.totalsum,
  });
  OutcomeModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    count = json['count'];
    entryPrice = json['entry_price'];
    dollarCurrency = json['dollar_currency'];
    date = json['date'];
    type = json['type'];
    totalsum = json['total-sum'];
  }
  num? id;
  String? name;
  num? count;
  num? entryPrice;
  num? dollarCurrency;
  String? date;
  String? type;
  num? totalsum;
  OutcomeModel copyWith({
    num? id,
    String? name,
    num? count,
    num? entryPrice,
    num? dollarCurrency,
    String? date,
    String? type,
    num? totalsum,
  }) =>
      OutcomeModel(
        id: id ?? this.id,
        name: name ?? this.name,
        count: count ?? this.count,
        entryPrice: entryPrice ?? this.entryPrice,
        dollarCurrency: dollarCurrency ?? this.dollarCurrency,
        date: date ?? this.date,
        type: type ?? this.type,
        totalsum: totalsum ?? this.totalsum,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['count'] = count;
    map['entry_price'] = entryPrice;
    map['dollar_currency'] = dollarCurrency;
    map['date'] = date;
    map['type'] = type;
    map['total-sum'] = totalsum;
    return map;
  }
}
