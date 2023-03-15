import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/regions.dart';

class PickRegionsVM extends ChangeNotifier {
  List<Viloyat>? viloyat = [];
  List<Tuman>? tuman;
  int? vilId;

  Future getRegionsAPI(BuildContext context) async {
    try {
      // faqat viloyatlarni olib keladigan api
      Uri url = Uri.parse('https://spiska.pythonanywhere.com/api/regions/');
      var request = await http.get(url);
      if (request.statusCode == 200) {
        request.body;
        Regions regions = Regions.fromJson(jsonDecode(request.body));
        viloyat = regions.data;
        notifyListeners();
        return request.body;
      }
    } catch (e) {
      print(e);
    }
  }

  bool loader1 = false;

  Future getTuman(int vilID) async {
    loader1 = true;
    tuman = null;
    notifyListeners();
    try {
      Uri url = Uri.parse(
          'https://spiska.pythonanywhere.com/api/districts/?region-id=$vilID');
      var request = await http.get(url);
      if (request.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(request.body);
        tuman = (map['data'] as List).map((e) => Tuman.fromJson(e)).toList();
        loader1 = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
      loader1 = false;
      notifyListeners();
    }
  }
}
