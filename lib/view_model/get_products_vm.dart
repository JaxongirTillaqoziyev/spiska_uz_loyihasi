import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';
import '../service/api_response.dart';
class GetProductsVM extends ChangeNotifier {
  TextEditingController searchTextController = TextEditingController();
  ApiResponse _apiResponse = ApiResponse.initial("Yukalanmoqda");
  ApiResponse get apiResponse {
    return _apiResponse;
  }

  List<ProductModel> shopProducts = [];
  List<ProductModel> searchedProduct = [];

  Future getShopProducts(String id) async {
    _apiResponse = ApiResponse.initial("Yuklanmoqda");
    notifyListeners();
    try {
      Uri url = Uri.parse(
          "https://spiska.pythonanywhere.com/api/product/?shop-id=$id");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        if ((map['data'] as List).isNotEmpty) {
          shopProducts = (map['data'] as List)
              .map((e) => ProductModel.fromJson(e))
              .toList();
          _apiResponse = ApiResponse.haveShops(shopProducts);
        } else if ((map['data'] as List).isEmpty) {
          _apiResponse = ApiResponse.haveNotShops("Mahsulotlar mavjud emas");
        }
      }
    } catch (e) {
      print("error");
      _apiResponse = ApiResponse.error("Error:$e");
    }
    notifyListeners();
  }

  Future searchProduct(String text) async {
    _apiResponse = ApiResponse.initial("Yuklanmoqda");
    notifyListeners();
    searchedProduct = shopProducts
        .where((product) =>
            product.name!.toLowerCase().contains(text.toLowerCase()))
        .toList();
    if (searchedProduct.isEmpty) {
      print("bosh");
      _apiResponse = ApiResponse.haveNotShops("Mahsulotlar mavjud emas");
    } else {
      print("bosh emas");
      _apiResponse = ApiResponse.haveShops(shopProducts);
      print(shopProducts);
    }
    notifyListeners();
  }
}
