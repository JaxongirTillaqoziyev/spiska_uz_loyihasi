import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/person_model.dart';
import '../service/utils.dart';

class ShopInfoVM extends ChangeNotifier {
  bool isLoading = false;
  int? userId;

  List<Person> allUsers = [];
  List<Person> shopMembers = [];
  final customer = TextEditingController();
  final admin = TextEditingController();
  String searchText = '';

  Future fetchCustomer() async {
    isLoading = true;
    notifyListeners();
    try {
      Uri url = Uri.parse('https://spiska.pythonanywhere.com/api/user/');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        isLoading = false;
        allUsers =
            (res['data'] as List).map((e) => Person.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    // return [].cast<Person>();
  }

  Future fetchCustomerBySearch(String text) async {
    isLoading = true;
    notifyListeners();
    try {
      Uri url =
          Uri.parse('https://spiska.pythonanywhere.com/api/user/?q=$text');

      var response = await http.get(url);

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        isLoading = false;
        allUsers =
            (res['data'] as List).map((e) => Person.fromJson(e)).toList();

        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future addCustomer({required int shopId, required int userId}) async {
    isLoading = true;
    notifyListeners();
    try {
      Uri url = Uri.parse('https://spiska.pythonanywhere.com/api/add-member/');
      var response = await http.post(url, body: {
        "shop-id": shopId.toString(),
        "user-id": userId.toString(),
      });

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        isLoading = false;
        Utils.showToast('Do\'konga yangi a\'zo qo\'shildi');
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future addAdmin({required int shopId, required int userId}) async {
    isLoading = true;
    notifyListeners();
    try {
      Uri url =
          Uri.parse('https://spiska.pythonanywhere.com/api/shops/add-admin/');
      var response = await http.post(url,
          body: {"shop-id": shopId.toString(), "user-id": userId.toString()});

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        isLoading = false;
        Utils.showToast('Do\'konga yangi admin qo\'shildi');
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
