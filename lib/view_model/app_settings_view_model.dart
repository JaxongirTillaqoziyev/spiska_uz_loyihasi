import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../service/pref_service.dart';

class AppSettingsVM with ChangeNotifier {
  String language = "O'zbekcha";
  String? currency;
  Prefs darkThemePreference = Prefs();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }

  Future getCurrencyEx() async {
    try {
      String url = 'https://cbu.uz/common/json/';
      var res = await http.get((Uri.parse(url)));
      if (res.statusCode == 200) {
        print(res.body);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool isLoading = false;
}
