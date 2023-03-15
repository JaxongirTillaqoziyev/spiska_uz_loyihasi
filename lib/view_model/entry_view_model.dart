import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../model/person_model.dart';
import '../pages/home_page.dart';
import '../pages/introPages/registration.dart';
import '../service/hive_service.dart';
import '../service/pref_service.dart';
import '../service/utils.dart';
import 'add_shop_vm/pickImage_vm.dart';

class EntryPageVM extends ChangeNotifier {
  bool isAgree = false;
  bool isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final TextEditingController pinPutController = TextEditingController();
  final famController = TextEditingController();
  final nameController = TextEditingController();
  String? phone;
  final FocusNode pinPutFocusNode = FocusNode();
  String verificationCode = '';

  getSms() async {
    print('get sms');
    String? phone = await Prefs.loadPhone();
    print(phone);
    String p1 = phone!.replaceAll(' ', '');
    print(p1);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: p1,
      verificationFailed: (FirebaseAuthException e) {
        Utils.showToast('Xatolik sodir bo\'ldi. Qaytadan urinib ko\'ring');
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationCode = verificationId;
        notifyListeners();
        Utils.showToast('SMS Jo\'natildi');
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        verificationCode = verificationID;
        notifyListeners();
        print('timeout');
      },
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) async {
        print(credential.smsCode!);
        pinPutController.setText(credential.smsCode!);
        notifyListeners();
      },
    );
  }

  void isNewUser(context) async {
    print('isNewUser');
    phone = await Prefs.loadPhone();
    notifyListeners();
    try {
      Uri url =
          Uri.parse('https://spiska.pythonanywhere.com/api/user/?phone=$phone');
      var request = await http.get(url);
      if (request.statusCode == 200) {
        Map map = jsonDecode(utf8.decode(request.bodyBytes));
        if ((map['data'] as List).isNotEmpty) {
          Person person = Person.fromJson((map['data'] as List).first);
          print('person: $person');
          HiveDB.storePerson(person);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (ctx) => const HomePage()),
            (route) => false,
          );
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => Registration(
                        title: "Ma'lumotlaringizni kiriting",
                        onPressed: () async {
                          if (isLoading == false) {
                            await uploadUserInfo(context);
                          }
                        },
                        buttonTitle: "Keyingisi",
                      )));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future uploadUserInfo(context) async {
    final provider = Provider.of<PickImageVM>(context, listen: false);
    isLoading = true;
    notifyListeners();
    phone = await Prefs.loadPhone();
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://spiska.pythonanywhere.com/api/user/'));
      request.fields.addAll({
        'first_name': nameController.text.trim().toString(),
        'last_name': famController.text.trim().toString(),
        'phone': phone!,
      });
      request.files.add(await http.MultipartFile.fromPath(
          'image', provider.imagePerson!.path));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        await response.stream.bytesToString();
        isLoading = false;
        provider.imagePerson = null;
        notifyListeners();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => const HomePage()),
          (route) => false,
        );
      }
    } catch (e) {
      print(e);
      Utils.showToast('Xatolik sodir bo\'ldi');
      isLoading = false;
      notifyListeners();
    }
  }

  Future changeUserInfo(BuildContext context) async {
    int? id = HiveDB.loadPerson().id;
    final provider = Provider.of<PickImageVM>(context, listen: false);
    isLoading = true;
    notifyListeners();
    try {
      var request = http.MultipartRequest('PUT',
          Uri.parse('https://spiska.pythonanywhere.com/api/user/?id=$id'));
      request.fields.addAll({
        'first_name': nameController.text.trim().toString(),
        'last_name': famController.text.trim().toString(),
      });
      request.files.add(await http.MultipartFile.fromPath(
          'image', provider.imagePerson!.path));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        await response.stream.bytesToString();
        isLoading = false;
        provider.imagePerson = null;
        notifyListeners();
        return "1";
      }
    } catch (e) {
      print(e);
      Utils.showToast('Xatolik sodir bo\'ldi');
      isLoading = false;
      notifyListeners();
    }
  }
}
