import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class DeleteVM extends ChangeNotifier {
  Future deleteProduct(String productId) async {
    debugPrint("delete product");
    try {
      Uri url = Uri.parse(
          "https://spiska.pythonanywhere.com/api/product/?id=$productId");

      var request = await http.delete(url);
      var res = jsonDecode(request.body);
      if (res['status'] == 200) {
        debugPrint("success delete");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
