import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/search_model.dart';
import '../model/shop_model.dart';

class SearchVM extends ChangeNotifier {
  bool isLoading = false;
  List<Shop> searchShopList = [];
  int tabIndex = 0;
  final TextEditingController controller = TextEditingController();
  List<SearchProductModel> searchProductList = [];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  Shop? shop;

  Future searchProduct({String? searchWord}) async {
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              'http://spiska.pythonanywhere.com/api/product/?q=${searchWord ?? ''}'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        print('aa');
        Map map = jsonDecode(utf8.decode(res.codeUnits));
        print(map['data']);
        print((map['data'] as List).map((e) => SearchProductModel.fromJson(e)));
        searchProductList = (map['data'] as List)
            .map((e) => SearchProductModel.fromJson(e))
            .toList();

        debugPrint(searchProductList.toString());
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future searchShop({String? searchWord}) async {
    print("searchWord: $searchWord");
    try {
      var request = http.Request(
          'GET',
          Uri.parse(
              'http://spiska.pythonanywhere.com/api/shop/?q=$searchWord'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        Map map = jsonDecode(utf8.decode(res.codeUnits));
        print("shop");
        print(map['data']);
        searchShopList =
            (map['data'].first as List).map((e) => Shop.fromJson(e)).toList();
        print(searchProductList);
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getShop(int id) async {
    isLoading = true;
    notifyListeners();
    try {
      String url = 'https://spiska.pythonanywhere.com/api/shop/?id=$id';
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        Map map = jsonDecode(utf8.decode(res.bodyBytes));
        isLoading = false;
        notifyListeners();
        return (Shop.fromJson(map['data'].first));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
