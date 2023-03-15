import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:spiska_uz_loyihasi/view_model/add_shop_vm/pickImage_vm.dart';
import '../../model/person_model.dart';
import '../../model/regions.dart';
import '../../pages/home_page.dart';
import '../../service/hive_service.dart';
import '../../service/utils.dart';

class AddShopVM extends ChangeNotifier {
  String radioValue = '0';
  String? type;
  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isCheck = false;

  Map map = {};
  List<Viloyat>? viloyat = [];
  List<Tuman>? tuman;

  final shopNameController = TextEditingController();
  final descrController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmController = TextEditingController();

  String? lati;
  String? long;
  int? tum_id;
  int? vil_index;

  Future updateShopData(BuildContext context, String shopId) async {
    final provider2 = Provider.of<PickImageVM>(context, listen: false);
    isLoading = true;
    notifyListeners();
    try {
      Uri url =
          Uri.parse('https://spiska.pythonanywhere.com/api/shop/?id=$shopId');
      var request = http.MultipartRequest('PUT', url);
      request.fields.addAll({
        'name': shopNameController.text.trim().toString(),
        'description': descrController.text.trim().toString(),
        'password': passController.text.trim().toString(),
        'viloyat': '${vil_index! + 1}',
        'tuman': '${tum_id!}',
        "lat": lati!,
        "lon": long!,
        "currency": radioValue,
      });
      request.files.add(await http.MultipartFile.fromPath(
          'image', provider2.imageShop!.path));
      request.files.add(await http.MultipartFile.fromPath(
          'passport_image', provider2.imageShop!.path));
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        isLoading = false;
        notifyListeners();
        return 'success';
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      debugPrint(e.toString());
    }
  }

  void addShopButton(BuildContext context) {
    final provider1 = Provider.of<PickImageVM>(context, listen: false);
    if (formKey.currentState!.validate()) {
      if (provider1.imageShop != null && long != null && lati != null) {
        if (vil_index != null && tum_id != null) {
          isLoading = true;
          notifyListeners();
          addShopApi(context).then((value) => {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (ctx) => const HomePage()),
                    (route) => false),
              });
        } else {
          Utils.showToast('Do\'kon joylashgan viloyat va tumanni kiriting!');
        }
      } else {
        Utils.showToast('Rasm va do\'kon manzilini ham qo\'shing');
      }
    }
  }

  Future addShopApi(BuildContext context) async {
    final provider1 = Provider.of<PickImageVM>(context, listen: false);
    try {
      Person person = HiveDB.loadPerson();
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://spiska.pythonanywhere.com/api/shop/'));
      request.fields.addAll({
        'name': shopNameController.text.trim().toString(),
        'description': descrController.text.trim().toString(),
        'password': passController.text.trim().toString(),
        'viloyat': '$vil_index',
        'tuman': '$tum_id',
        'host-id': person.id.toString(),
        "lat": lati!,
        "lon": long!,
        "currency": radioValue,
        "type": type!,
      });
      request.files.add(await http.MultipartFile.fromPath(
          'image', provider1.imageShop!.path));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      Map map = jsonDecode(response.body);
      if (map['status'] == 200) {
        provider1.imageShop = null;
        disposeFunction();
        notifyListeners();
        Utils.showToast('Do\'kon yaratildi');
      } else if (map['status'] == 400 || map['message'] != '') {
        provider1.imageShop = null;
        disposeFunction();
        notifyListeners();
        Utils.showToast('Sizda yetarli olmos tangalar mavjud emas!');
      }
    } catch (e) {
      provider1.imageShop = null;
      disposeFunction();
      notifyListeners();
      if (kDebugMode) {
        print("Error:$e");
      }
    }
  }

  Future<void> getLocation(BuildContext context) async {
    LocationPermission permission;

    try {
      permission = await Geolocator.requestPermission();

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lati = position.latitude.toString();
      long = position.longitude.toString();

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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

  Future getTuman() async {
    loader1 = true;
    tuman = null;
    notifyListeners();
    try {
      Uri url = Uri.parse(
          'https://spiska.pythonanywhere.com/api/districts/?region-id=$vil_index');
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

  void disposeFunction() {
    isLoading = false;
    passConfirmController.text = '';
    descrController.text = '';
    shopNameController.text = '';
    passController.text = "";
    isCheck = false;
    lati = null;
    long = null;
    tuman = null;
    viloyat = null;
    vil_index = null;
    tum_id = null;
  }
}
