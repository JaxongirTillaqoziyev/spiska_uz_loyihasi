import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../../model/product_model.dart';
import '../../model/shop_model.dart';
import '../../service/api_response.dart';
class GetShopVM extends ChangeNotifier {
  TextEditingController searchTextController = TextEditingController();
  bool isLoading = false;
  Shop? shop;
  List<ProductModel> searchedProduct = [];
  ApiResponse _apiResponse = ApiResponse.initial("Yuklanmoqda");

  ApiResponse get apiResponse {
    return _apiResponse;
  }

  Future getShop(String shopId) async {
    _apiResponse = ApiResponse.initial("Yuklanmoqda");
    notifyListeners();
    try {
      Uri url =
          Uri.parse("http://spiska.pythonanywhere.com/api/shop/?id=$shopId");
      //id dokonniki
      var response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        if (map['status'] == 200) {
          shop = Shop.fromJson(map['data'].first);
          _apiResponse = ApiResponse.haveShops(shop);
        } else {
          _apiResponse = ApiResponse.haveNotShops("Bunday dokon mavjud emas!");
        }
      }
    } on SocketException {
      _apiResponse = ApiResponse.error("Internetga ulanmagansiz!");
    } catch (e) {
      _apiResponse = ApiResponse.error("Xatolik sodir bo'ldi!");
    }
    notifyListeners();
  }

  Future searchProduct(String text) async {
    _apiResponse = ApiResponse.initial("Yuklanmoqda");
    notifyListeners();
    List<ProductModel> list =
        (shop?.products as List).map((e) => ProductModel.fromJson(e)).toList();
    searchedProduct = list
        .where((product) =>
            product.name!.toLowerCase().contains(text.toLowerCase()))
        .toList();
    if (searchedProduct.isEmpty) {
      print("bosh");
      _apiResponse = ApiResponse.haveNotShops("Mahsulotlar mavjud emas");
    } else {
      print("bosh emas");
      _apiResponse = ApiResponse.haveShops(searchedProduct);
    }
    notifyListeners();
  }
}
