import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../../core/core_widgets.dart';

class PickImageVM extends ChangeNotifier {
  File? imageShop;
  File? imagePassport;
  File? imagePerson;
  void pickImageShop() async {
    var res = await CoreFunctios.imgFromGallery();
    imageShop = res[0];
    notifyListeners();
  }

  void pickImagePas() async {
    var res = await CoreFunctios.imgFromGallery();
    imagePassport = res[0];
    notifyListeners();
  }

  void pickImagePerson() async {
    var res = await CoreFunctios.imgFromGallery();
    imagePerson = res[0];
    notifyListeners();
  }
}
