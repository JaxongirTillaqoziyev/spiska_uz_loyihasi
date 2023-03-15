import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../core/Allvalidators.dart';
import '../../service/pref_service.dart';
import 'otp.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool isLoading = false;
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Telefon raqamingizni \n kiriting',
                style: TextStyle(fontSize: 28, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 4,
              ),
              //phone
              TextFormField(
                controller: phoneController,
                inputFormatters: [
                  MaskTextInputFormatter(mask: "## ### ## ##"),
                ],
                validator: AllValidators.instance.phoneNumberValidator,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  fillColor: Colors.white,
                  filled: true,
                  hintText: 'XX XXX XX XX',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "+998",
                      style: TextStyle(fontSize: 19, color: Colors.black),
                    ),
                  ),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 10, minHeight: 0),
                  hintStyle: const TextStyle(
                    fontSize: 19,
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.transparent)),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width / 5,
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    String phone =
                        phoneController.text.trim().replaceAll(' ', '');
                    Prefs.savePhone('+998$phone');
                    setState(() {
                      isLoading = true;
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OTPScreen(phoneController.text)));
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                            color: Colors.white,
                            width: 0.5,
                            style: BorderStyle.solid))),
                child: !isLoading
                    ? const Text(
                        'Sms kodni olish',
                        style: TextStyle(
                          fontSize: 28,
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
