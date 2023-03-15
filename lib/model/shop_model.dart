class Shops {
  int? status;
  List<Shop>? data;

  Shops({this.status, this.data});

  Shops.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Shop>[];
      json['data'].forEach((v) {
        data?.add(Shop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shop {
  Map? host;
  List<dynamic>? admins;
  int? id;
  String? name;
  String? description;
  String? img;
  String? viloyat;
  String? tuman;
  Map? location;
  List? products;
  List<dynamic>? members;
  String? currency;
  String? type;
  double? distance;
  int? dollarCurrency;
  List? promocodes = [];
  List? output = [];
  List? input = [];
  List? selected = [];
  int? allSum;
  int? allProfit;
  Shop(
      {this.id,
      this.name,
      this.description,
      this.img,
      this.viloyat,
      this.tuman,
      this.location,
      this.host,
      this.admins,
      this.products,
      this.members,
      this.currency,
      this.type,
      this.distance,
      this.selected,
      this.dollarCurrency,
      this.output,
      this.input,
      this.allSum,
      this.allProfit,
      this.promocodes});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    host = json['host'];
    admins = json['admins'];
    products = json['products'];
    members = json['members'];
    name = json['name'];
    description = json['description'];
    img = json['img'];
    viloyat = json['viloyat'];
    tuman = json['tuman'];
    location = json['location'];
    currency = json['currency'];
    distance = json['distance'];
    type = json['type'];
    dollarCurrency = json['dollar_currency'];
    promocodes = json["promocodes"];
    output = json["output"];
    input = json["input"];
    selected = json["selected"];
    allSum = json['all_summ'];
    allProfit = json['all_profit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['img'] = img;
    data['viloyat'] = viloyat;
    data['tuman'] = tuman;
    if (location != null) {
      data['location'] = location;
    }
    data['host'] = host;
    if (admins != null) {
      data['admins'] = admins?.map((v) => v.toJson()).toList();
    }
    if (members != null) {
      data['members'] = members?.map((v) => v.toJson()).toList();
    }
    data['products'] = products;
    data['currency'] = currency;
    data['type'] = type;
    data['distance'] = distance;
    data["selected"] = selected;
    data["output"] = output;
    data["input"] = input;
    data["dollar_currency"] = dollarCurrency;
    data["promocodes"] = promocodes;
    data["all_summ"] = allSum;
    data["all_profit"] = allProfit;
    data["members"] = members;

    return data;
  }
}
