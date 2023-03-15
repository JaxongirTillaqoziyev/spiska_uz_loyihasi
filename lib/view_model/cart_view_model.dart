import 'package:flutter/material.dart';

import '../model/selling_item_model.dart';

class CartVM extends ChangeNotifier {
  int count = 1;
  var summa = 0;
  int? price;
  int discount = 5;
  num allCost = 0;
  num? withoutDiscount;
  final newAmount = TextEditingController();

  void afterEditCalc(index) {
    int newsum = int.parse(newAmount.text.trim()) *
        int.parse(cartItems[index].price.toString());
    cartItems[index].sum = newsum.toString();
    cartItems[index].amount = newAmount.text.trim();
    calcAllCost();
    notifyListeners();
  }

  void add() {
    count++;
    summa = price! * count;
    notifyListeners();
  }

  void unAdd() {
    count--;
    summa = price! * count;
    notifyListeners();
  }

  void sliderCalc(double? a) {
    count = a!.toInt();
    summa = price! * count;
    notifyListeners();
  }

  num calcAllCost() {
    count = 1;
    allCost = 0;
    if (cartItems.isNotEmpty) {
      for (int i = 0; i < cartItems.length; i++) {
        allCost += num.parse(cartItems[i].sum!);
      }
    }
    print(allCost);
    return allCost;
  }

  void calc({sellPrice}) {
    price = sellPrice;
    summa = sellPrice;
    withoutDiscount = price! + (price! * discount / 100);
  }

  List<SellingItem> cartItems = [];
}
