import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeService extends ChangeNotifier {
  scan() async {
    String barcodeText = '';
    await FlutterBarcodeScanner.scanBarcode(
            '#000000', 'Cancel', true, ScanMode.BARCODE)
        .then((value) => {barcodeText = value});
    notifyListeners();
    return barcodeText;
  }
}
