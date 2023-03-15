import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../service/utils.dart';
import '../../view_model/entry_view_model.dart';

class OTPScreen extends StatefulWidget {
  final String phone;
  const OTPScreen(this.phone, {Key? key}) : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 3);
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<EntryPageVM>(context, listen: false);
    provider.getSms();
    resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EntryPageVM>(context, listen: true);
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));
    return Scaffold(
      key: provider.scaffoldKey,
      backgroundColor: Colors.blue,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mobil raqamni tasdiqlash\n${widget.phone}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              'Biz sizga yuborgan kodni kiriting',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Pinput(
                length: 6,
                focusNode: provider.pinPutFocusNode,
                controller: provider.pinPutController,
                pinAnimationType: PinAnimationType.fade,
                onCompleted: (pin) {
                  onCompleted(pin);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  '$minutes:$seconds',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 25),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (countdownTimer?.isActive == false)
              InkWell(
                onTap: () {
                  provider.getSms();
                  setState(() {
                    resetTimer();
                  });
                },
                child: const Text(
                  'SMS.ni qayta yuborish uchun bosing',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.red,
                      fontSize: 19),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onCompleted(String pin) async {
    final provider = Provider.of<EntryPageVM>(context, listen: false);
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: provider.verificationCode, smsCode: pin))
          .then((value) {
        provider.isNewUser(context);
        pin = '';
      });
    } catch (e) {
      Utils.showToast("Xato kod kiritdingiz");
    }
    stopTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    final seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
      setState(() {});
    } else {
      if (mounted) {
        setState(() {
          myDuration = Duration(seconds: seconds);
        });
      }
    }
  }

  void stopTimer() {
    countdownTimer?.cancel();
  }

  void resetTimer() {
    stopTimer();
    myDuration = const Duration(minutes: 3);
    startTimer();
  }
}
