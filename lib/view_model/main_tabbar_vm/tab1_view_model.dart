import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/person_model.dart';
import '../../model/regions.dart';
import '../../model/shop_model.dart';
import '../../pages/introPages/login_with_phone.dart';
import '../../service/api_response.dart';
import '../../service/hive_service.dart';
import '../../service/pref_service.dart';
class TabBar1VM extends ChangeNotifier {
  int? index;
  String userPhone = '';
  List<Shop> shopList = [];
  List<Shop> ownerShop = [];
  List<Shop> adminShop = [];
  List<Shop> userShop = [];
  double? distance;
  List list = [];
  List<Viloyat>? viloyatlar = [];
  int? viloyat;
  List<Tuman>? tumanlar = [];
  int? tuman;
  String dropItem1 = '';
  String dropItem2 = '';
  int? vil_index;
  String? phone;
  ApiResponse _apiUserResponse = ApiResponse.initial('INITIAL');
  ApiResponse get responseAsUser {
    return _apiUserResponse;
  }

  ApiResponse _apiAdminResponse = ApiResponse.initial('INITIAL');
  ApiResponse get responseAsAdmin {
    return _apiAdminResponse;
  }

  // Future getShops() async {
  //   Person person = HiveDB.loadPerson();
  //   print(person.id);
  //   try {
  //     // user id berilsa o'zi azo dokonlarni olib kelib beradi.
  //     var url = Uri.parse(
  //         'https://spiska.pythonanywhere.com/api/shop/?user-id=${person.id}');
  //     var response = await http.get(
  //       url,
  //     );
  //     if (response.statusCode == 200) {
  //       var data = jsonDecode(utf8.decode(response.bodyBytes));
  //       if (data['status'] == 400) {
  //         _apiResponse = ApiResponse.haveNotShops('Xatolik sodir bo\'ldi!');
  //         shopList = [];
  //       } else if (data['status'] == 200) {
  //         print("status:200");
  //         ShopModel2 shopModel2 = ShopModel2.fromJson(data);
  //         List<CreatorAdmin>? creatorAdminList = shopModel2.creatorAdmin;
  //         _apiResponse = ApiResponse.haveShops(creatorAdminList);
  //       }
  //     }
  //   } on SocketException {
  //     _apiResponse = ApiResponse.error("Internet mavjud emas!");
  //   } catch (error) {
  //     _apiResponse = ApiResponse.error("Xatolik sodir bo'ldi: $error");
  //   }
  //   notifyListeners();
  // }

  Future getShopAsUser() async {
    Person person = HiveDB.loadPerson();
    try {
      // user id berilsa o'zi azo dokonlarni olib kelib beradi.
      var url = Uri.parse(
          'https://spiska.pythonanywhere.com/api/shop/?user-id=${person.id}'); // 13 meniki
      var response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        //  return (data['creator-admin'] as List).map((e) => Shop.fromJson(e)).toList();
        userShop = (data['user'] as List).map((e) => Shop.fromJson(e)).toList();
        if (userShop.isEmpty) {
          _apiUserResponse =
              ApiResponse.haveNotShops('Do\'konlar mavjud emas!');
        } else {
          adminShop = (data["creator-admin"] as List)
              .map((e) => Shop.fromJson(e))
              .toList();
          _apiUserResponse = ApiResponse.haveShops(userShop);
        }
      }
    } on SocketException {
      _apiUserResponse = ApiResponse.error("Internet mavjud emas!");
    } catch (error) {
      _apiUserResponse = ApiResponse.error("Xatolik sodir bo'ldi: $error");
    }
    notifyListeners();
  }

  Future getShopAsAdmin() async {
    Person person = HiveDB.loadPerson();
    try {
      // user id berilsa o'zi azo dokonlarni olib kelib beradi.
      var url = Uri.parse(
          'https://spiska.pythonanywhere.com/api/shop/?user-id=${person.id}'); // 13 meniki
      var response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        adminShop = (data["creator-admin"] as List)
            .map((e) => Shop.fromJson(e))
            .toList();
        if (adminShop.isEmpty) {
          _apiAdminResponse =
              ApiResponse.haveNotShops('Do\'konlar mavjud emas!');
        } else {
          _apiAdminResponse = ApiResponse.haveShops(adminShop);
        }
      }
    } on SocketException {
      _apiAdminResponse = ApiResponse.error("Internet mavjud emas!");
    } catch (error) {
      _apiAdminResponse = ApiResponse.error("Xatolik sodir bo'ldi: $error");
    }
    notifyListeners();
  }

  Future _getUser() async {
    try {
      Uri url = Uri.parse(
          'http://spiska.pythonanywhere.com/api/user/?phone=${await Prefs.loadPhone()}');
      var request = await http.get(url);
      if (request.statusCode == 200) {
        var user1 = jsonDecode(utf8.decode(request.bodyBytes));
        if ((user1['data'] as List).isEmpty) {
          return 'empty';
        } else {
          return user1;
        }
      }
    } on SocketException {
      debugPrint('socket exception');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void getApiResponse(BuildContext context) {
    Person person;
    _getUser().then((value) => {
          if (value == 'empty')
            {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginWithPhone()),
                  (route) => false),
            }
          else
            {
              person = Person.fromJson((value['data'] as List).first),
              HiveDB.storePerson(person),
              notifyListeners(),
            }
        });
  }
}
