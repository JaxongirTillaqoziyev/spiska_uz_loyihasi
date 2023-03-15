class SellingItem {
  String? name;
  String? price;
  String? amount;
  String? sum;
  List<String>? img;
  String? productId;
  String? shopId;
  String? proBarcode;
  String? type;

  SellingItem(
      {this.name,
      this.price,
      this.amount,
      this.sum,
      this.img,
      this.productId,
      this.shopId,
      this.proBarcode,
      this.type});

  SellingItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    amount = json['amount'];
    sum = json['sum'];
    img = json['img'];
    productId = json['productId'];
    shopId = json['shopId'];
    proBarcode = json['proBarcode'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'amount': amount,
        'sum': sum,
        'img': img,
        'productId': productId,
        'shopId': shopId,
        'proBarcode': proBarcode,
        'type': type,
      };
}
