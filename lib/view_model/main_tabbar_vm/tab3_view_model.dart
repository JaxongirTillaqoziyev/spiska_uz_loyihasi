import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/product_model.dart';
import '../../model/regions.dart';
import '../../service/api_response.dart';
import '../../service/utils.dart';
class Tab3VM extends ChangeNotifier {
  bool isLoading = false;
  List<ProductModel> allProducts = [];
  List<Viloyat>? viloyatlar = [];
  int? viloyat;
  List<Tuman>? tumanlar = [];
  int? tuman;
  String dropItem1 = '';
  String dropItem2 = '';
  int? vil_index;

  ApiResponse _apiResponse = ApiResponse.initial("loading");
  ApiResponse get apiResponse {
    return _apiResponse;
  }

  Future getProducts({int? region, int? district}) async {
    _apiResponse = ApiResponse.initial("loading");
    try {
      var url = Uri.parse(
          'https://spiska.pythonanywhere.com/api/product/?region=${region ?? ''}&district=${district ?? ''}');
      var response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        var res = jsonDecode(utf8.decode(response.bodyBytes));
        if (res['status'] == 400) {
          _apiResponse = ApiResponse.haveNotShops("Xatolik sodir bo\'ldi!");
        } else if (res['status'] == 200) {
          allProducts = ((res['data'] as List)
              .map((e) => ProductModel.fromJson(e))).toList();
          if (allProducts.isEmpty) {
            _apiResponse = ApiResponse.haveNotShops("Mahsulotlar mavjud emas!");
          } else {
            _apiResponse = ApiResponse.haveShops(allProducts);
          }
          debugPrint("${region.toString()}+${district.toString()}");
          debugPrint(allProducts.toString());
        } else {
          _apiResponse = ApiResponse.haveNotShops("Xatolik sodir bo\'ldi!");
        }
      }
    } on SocketException {
      Utils.showToast('Internet tarmog\'iga ulanmagan bo\'lishi mumkin!');
      _apiResponse = ApiResponse.error("Internet bilan aloqa yo'q");
    } catch (e) {
      Utils.showToast('Xatolik sodir bo\'ldi!');
      _apiResponse = ApiResponse.haveNotShops("Xatolik sodir bo\'ldi!:$e");
    }
    notifyListeners();
  }
}
