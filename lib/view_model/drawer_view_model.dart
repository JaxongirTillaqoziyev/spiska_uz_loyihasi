import 'dart:async';
import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/shop_model.dart';
import '../pages/drawer/drawer_category_pages/addShop.dart';
import '../service/hive_service.dart';
import '../service/utils.dart';
class DrawerViewModal extends ChangeNotifier {
  int olmos= HiveDB.loadPerson().diamond as int;
  bool isGetBonus = false;
  String? userName = '';
  String? userFam = '';
  String? userPhone = '';
  String imageUrl = '';
  int? id;
  int count = 0;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final shopNameCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  String timer = '';
  List<Shop> drawerPageShops = [];
  final loginController = TextEditingController();
  Future<void> getSupport() async {
    String url = "http://spiska.pythonanywhere.com/support/";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      String nomer = data['phone'];
      Utils.jumpedUrl('https://t.me/$nomer');
      return data['phone'];
    }
  }
  Future<void> dialogCheckShop(context) async {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('haveShop'.tr()),
              actions: [
                InkWell(
                  onTap: () {
                    if(olmos>=400){
                      Navigator.pop(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => AddShop()));
                    }
                       else {
                         Utils.showToast("Sizda olmos tangalar 400 tadan kam ");
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "no".tr(),
                        style: const TextStyle(color: Colors.red, fontSize: 19),
                      )),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    enterShopWithPassword(context);
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'yes'.tr(),
                        style:
                            const TextStyle(color: Colors.green, fontSize: 19),
                      )),
                ),
              ],
              actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
              actionsAlignment: MainAxisAlignment.end,
            ));
  }
  void enterShopWithPassword(context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text(
                      "enterPassAndName".tr(),
                      style: const TextStyle(
                          fontSize: 18, color: Colors.lightBlueAccent),
                    ),
                    TextFormField(
                      controller: shopNameCtrl,
                      decoration: InputDecoration(
                        hintText: 'shopName'.tr(),
                      ),
                      validator: (input) =>
                          input!.isEmpty ? 'Do\'kon nomini kiriting!' : null,
                    ),
                    TextFormField(
                      controller: passCtrl,
                      decoration: InputDecoration(
                        hintText: 'enterPass'.tr(),
                      ),
                      validator: (input) =>
                          input!.isEmpty ? 'Do\'kon parolini kiriting!' : null,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'forgotPass'.tr(),
                      style: TextStyle(fontSize: 15, color: Colors.red),
                    ),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                          maxHeight: 55,
                          maxWidth: 130,
                          minHeight: 45,
                          minWidth: 100),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.lightBlue,
                            primary: Colors.white),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            count++;
                            notifyListeners();
                            if (count <= 15) {
                              enterShop(shopNameCtrl.text.trim(),
                                  passCtrl.text.trim(), id.toString(), context);
                            } else {
                              Utils.showToast(
                                  'Parolni bilmasangiz o\'zingizni qiynamang!');
                            }
                          }
                        },
                        child: !isLoading
                            ? Text("enterShop".tr())
                            : const CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Future enterShop(String shopName, shopPass, userId, context) async {
    isLoading = true;
    notifyListeners();
    try {
      Uri url = Uri.parse('http://spiska.pythonanywhere.com/api/change-owner/');
      var response = await http.post(url,
          body: {'name': shopName, 'password': shopPass, 'user-id': userId});

      if (response.statusCode == 200) {
        Map map = jsonDecode(utf8.decode(response.bodyBytes));
        print('dokonni nomiga olish');
        print(map['status']);
        print(map['status'].runtimeType);
        Utils.showToast('Do\'kon sizning nomizga o\'tdi');
        // getShops();
        Navigator.pop(context);
        isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
      Utils.showToast('Do\'kon nomi va paroli noto\'g\'ri bo\'lishi mumkin!');
    }
  }
}
