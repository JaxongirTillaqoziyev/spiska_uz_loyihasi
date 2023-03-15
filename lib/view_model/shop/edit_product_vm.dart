import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import '../../core/core_widgets.dart';
import '../../model/product_model.dart';

class EditProductVM extends ChangeNotifier {
  bool isPressed = false;
  final scrollController = ScrollController();
  DateTime selectedDate = DateTime.now();

  List<String?> itemUnit = ['kg', 'dona', 'litr', 'm²', 'metr', 'm³'];
  List<File> images = [];

  String number = "";
  String unit = '';
  String percent = '';

  final TextEditingController barcodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController countController = TextEditingController();
  final TextEditingController enterPriceController = TextEditingController();
  final TextEditingController myPriceController = TextEditingController();
  final TextEditingController percentController = TextEditingController();
  final TextEditingController sellPriceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isCheck = false;

  num get sellPrice =>
      (num.parse(enterPriceController.text.trim()) *
          num.parse(percentController.text.trim()) /
          100) +
      num.parse(enterPriceController.text.trim());

  Future editProduct(BuildContext context, String id) async {
    isPressed = true;
    notifyListeners();
    String url = "http://spiska.pythonanywhere.com/api/product/?id=$id";
    try {
      var request = http.MultipartRequest('PUT', Uri.parse(url));
      request.fields.addAll({
        "name": nameController.text.trim(),
        "description": descriptionController.text.trim(),
        "count": countController.text.trim(),
        "percent": percentController.text.trim(),
        "price": myPriceController.text.trim(),
        "selling_price":
            double.parse(sellPriceController.text.trim()).toInt().toString(),
        "entry_price": enterPriceController.text.trim(),
        "selected": isCheck ? "1" : "0",
      });
      if (CoreFunctios.images.isNotEmpty) {
        request.files.add(await http.MultipartFile.fromPath(
            'image1', CoreFunctios.images[0].path));
        if (CoreFunctios.images.length >= 2) {
          request.files.add(await http.MultipartFile.fromPath(
              'image2', CoreFunctios.images[1].path));
        }
        if (CoreFunctios.images.length >= 3) {
          request.files.add(await http.MultipartFile.fromPath(
              'image3', CoreFunctios.images[2].path));
        }
      }
      http.StreamedResponse response = await request.send();
      await response.stream.bytesToString();
      if (response.statusCode == 200) {
        isPressed = false;
        percentController.text = '';
        nameController.text = '';
        descriptionController.text = '';
        countController.text = '';
        enterPriceController.text = '';
        sellPriceController.text = '';
        images.clear();
        notifyListeners();
        var res = await response.stream.bytesToString();
        print("res:$res");
      }
    } catch (e) {
      isPressed = false;
      notifyListeners();
      debugPrint("error:$e");
    }
    isPressed = false;
    notifyListeners();
  }

  void getOldData(ProductModel product) {
    nameController.text = product.name.toString();
    descriptionController.text = product.description.toString();
    sellPriceController.text = product.sellingPrice.toString();
    enterPriceController.text = product.entryPrice.toString();
    myPriceController.text = product.price.toString();
    percentController.text = product.percent.toString();
    countController.text = product.count.toString();
    unit = product.type.toString();
  }
}
