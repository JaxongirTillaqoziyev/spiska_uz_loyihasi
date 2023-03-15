import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../model/product_model.dart';
import '../../service/utils.dart';

class ShopToolsPageVM extends ChangeNotifier {
  List<ProductModel> shopProducts = [];
  bool isLiked = false;
  final exchangeRateController = TextEditingController();
  bool isLoading = false;

  Future changeExchangeRate(String shopId) async {
    isLoading = true;
    notifyListeners();
    try {
      Uri url =
          Uri.parse("https://spiska.pythonanywhere.com/api/update-currency/");
      var data = {
        "shop-id": shopId,
        "currency": exchangeRateController.text.trim(),
      };
      var request = await http.put(url, body: data);
      var res = jsonDecode(request.body);
      if (res['status'] == 200) {
        Utils.showToast("Valyuta kursi yangilandi!");
        exchangeRateController.text = '';
        notifyListeners();
      } else {
        Utils.showToast("Xatolik sodir boldi!");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  Future likeButton({required String productId, required String userId}) async {
    try {
      Uri url = Uri.parse(
          'https://spiska.pythonanywhere.com/api/like/?user_id=$userId&product_id=$productId&command=add');
      var request = await http.get(url);
      if (request.statusCode == 200) {
        debugPrint('like bosildi');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future unLikeButton(
      {required String productId, required String userId}) async {
    try {
      Uri url = Uri.parse(
          'https://spiska.pythonanywhere.com/api/like/?user_id=$userId&product_id=$productId&command=remove');
      var request = await http.get(url);
      if (request.statusCode == 200) {
        debugPrint('unlike11 bosildi');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future checkIsLiked({required int index, required String userId}) async {
    try {
      Uri url = Uri.parse(
          'http://spiska.pythonanywhere.com/api/check-like/?user_id=$userId&product_id=${shopProducts[index].id}');

      var res = await http.get(url);
      if (res.statusCode == 200) {
        isLiked = true;
        notifyListeners();
      } else {
        isLiked = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
