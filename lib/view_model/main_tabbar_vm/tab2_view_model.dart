import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import '../../model/shop_model.dart';
import '../../service/api_response.dart';
import '../../service/utils.dart';
class Tab2VM extends ChangeNotifier {
  String? lat;
  String? lon;
  String? distance;
  List<Shop> nearShops = [];
  ApiResponse _apiResponse = ApiResponse.initial("loading");
  ApiResponse get apiResponse {
    return _apiResponse;
  }

  Future getNearShops() async {
    final LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude.toString();
    lon = position.longitude.toString();
    notifyListeners();
    try {
      Uri url = Uri.parse(
          'https://spiska.pythonanywhere.com/api/geo/?lat=$lat&long=$lon');
      var request = await http.get(url);

      if (request.statusCode == 200) {
        Map map = jsonDecode(utf8.decode(request.bodyBytes));
        if (map['status'] == 200) {
          nearShops =
              (map['data'] as List).map((e) => Shop.fromJson(e)).toList();
          print("status 200");
          _apiResponse = ApiResponse.haveShops(nearShops);
          print("near shop:$nearShops");
        } else if (map['status'] == 400) {
          _apiResponse = ApiResponse.haveNotShops("Xatolik sodir bo\'ldi!");
          nearShops = [];
        } else {
          _apiResponse = ApiResponse.error("Xatolik sodir bo\'ldi!");
        }
      }
    } on SocketException {
      Utils.showToast('No Internet');
      _apiResponse = ApiResponse.error("Internet mavjud emas!");
    } catch (e) {
      Utils.showToast('There are some errors');
      _apiResponse = ApiResponse.error("Xatolik sodir bo'ldi: $e");
    }
    notifyListeners();
  }
}
