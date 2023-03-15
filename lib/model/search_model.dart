class SearchProductModel {
  int? id;
  int? shopId;
  List? images;
  String? name;
  String? description;
  int? count;
  String? moneyType;
  String? type;
  int? entryPrice;
  int? percent;
  int? sellingPrice;
  String? enterprise;
  List? likes;
  List? views;

  SearchProductModel(
      {this.id,
      this.shopId,
      this.name,
      this.description,
      this.count,
      this.moneyType,
      this.type,
      this.entryPrice,
      this.percent,
      this.sellingPrice,
      this.enterprise,
      this.likes,
      this.views,
      this.images});

  SearchProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopId = json['shop_id'];
    images = json['images'];
    name = json['name'];
    description = json['description'];
    count = json['count'];
    moneyType = json['money_type'];
    type = json['type'];
    entryPrice = json['entry_price'];
    percent = json['percent'];
    sellingPrice = json['selling_price'];
    enterprise = json['enterprise'];
    likes = json['likes'];
    views = json['views'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['shop_id'] = shopId;
    data['images'] = images;
    data['name'] = name;
    data['description'] = description;
    data['count'] = count;
    data['money_type'] = moneyType;
    data['type'] = type;
    data['entry_price'] = entryPrice;
    data['percent'] = percent;
    data['selling_price'] = sellingPrice;
    data['enterprise'] = enterprise;
    data['likes'] = likes;
    data['views'] = views;
    return data;
  }
}
