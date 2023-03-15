import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../core/core_widgets.dart';
import '../../service/utils.dart';
import '../../view_model/shop/get_shop_by_id.dart';
import '../../widgets/custom_textfield.dart';
import 'myshop_admin.dart';

class AddingShopProductUi extends StatefulWidget {
  final String shopId;
  final String category;
  const AddingShopProductUi(
      {Key? key, required this.shopId, required this.category})
      : super(key: key);

  @override
  State<AddingShopProductUi> createState() => _AddingShopProductUiState();
}

class _AddingShopProductUiState extends State<AddingShopProductUi> {
  bool isPressed = false;
  final _scrollController = ScrollController();
  DateTime selectedDate = DateTime.now();

  List<String?> itemUnit = ['Dona', 'Litr', 'm²', 'm³', "Metr", 'Kg'];
  List<File> images = [];

  String number = "";
  String? unit = '';
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

  final _formKey = GlobalKey<FormState>();

  bool isCheck = false;

  num get sellPrice =>
      (num.parse(enterPriceController.text.trim()) *
          num.parse(percentController.text.trim()) /
          100) +
      num.parse(enterPriceController.text.trim());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yangi mahsulot qo’shish',
          style: TextStyle(fontSize: 19, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                //image area
                InkWell(
                  onTap: () {
                    CoreFunctios.imgFromGallery().then((value) => {
                          setState(() {
                            images = value;
                          })
                        });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.width - 90,
                    color: Colors.grey.withOpacity(0.4),
                    child: images.isEmpty
                        ? const Center(
                            child: Icon(
                              Icons.add_a_photo,
                              size: 60,
                              color: Colors.grey,
                            ),
                          )
                        : Stack(
                            children: [
                              CarouselSlider.builder(
                                itemCount: CoreFunctios.images.length,
                                options: CarouselOptions(
                                  height: MediaQuery.of(context).size.width,
                                  autoPlay: images.length > 1 ? true : false,
                                  enlargeCenterPage: false,
                                  viewportFraction: 1,
                                  initialPage: 2,
                                ),
                                itemBuilder: (BuildContext context,
                                        int itemIndex, int pageViewIndex) =>
                                    Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Image.file(
                                    images[itemIndex],
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                color: Colors.black12,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          images.removeAt(0);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.highlight_remove,
                                        color: Colors.red,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                //shtrix kod
                Row(
                  children: [
                    //to take barcode
                    InkWell(
                      onTap: () {
                        _scan();
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(color: Colors.grey.shade100),
                        child: const Icon(
                          Icons.qr_code_scanner_sharp,
                          size: 35,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextFieldForAddProduct(
                        controller: barcodeController,
                        validator: (input) =>
                            input!.isEmpty ? 'Shtrix kodni kiriting' : null,
                        label: 'Shtrix kod',
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {
                        generateAuto();
                      },
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue),
                      child: const Text('Auto'),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: nameController,
                  label: 'Nomi',
                  validator: (input) =>
                      input!.isEmpty ? 'Ismizni kiriting' : null,
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: descriptionController,
                  label: 'Tovar tasnifi',
                  validator: (input) =>
                      input!.isEmpty ? 'Ismizni kiriting' : null,
                ),
                const SizedBox(height: 10),
                //Soni
                Row(
                  children: [
                    SizedBox(
                        width: 100,
                        child: TextFieldForAddProduct(
                          keyboardType: TextInputType.number,
                          controller: countController,
                          label: 'Soni',
                          validator: (input) =>
                              input!.isEmpty ? 'Sonini kiriting' : null,
                        )),
                    Expanded(
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20)),
                        items: itemUnit
                            .map((String? val) => DropdownMenuItem(
                                  value: val,
                                  child: Text('$val'),
                                ))
                            .toList(),
                        onChanged: (input) {
                          setState(() {
                            unit = input.toString();
                          });
                        },
                        hint: const Text('Birligi'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: enterPriceController,
                  label: 'Kirish narxi',
                  validator: (input) =>
                      input!.isEmpty ? 'Narxini kiriting' : null,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: myPriceController,
                  label: 'O\'zim qo\'ygan narx',
                  validator: (input) =>
                      input!.isEmpty ? 'Narxini kiriting' : null,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: percentController,
                  keyboardType: TextInputType.number,
                  label: 'Foiz',
                  validator: (input) =>
                      input!.isEmpty ? 'Foizni kiriting' : null,
                  onChanged: (input) {
                    sellPriceController.text =
                        "${(num.parse(myPriceController.text.trim()) * num.parse(percentController.text.trim()) / 100) + num.parse(myPriceController.text.trim())}";
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: sellPriceController,
                  label: 'Sotish narxi',
                  validator: (input) =>
                      input!.isEmpty ? 'Sotish narxini  kiriting' : null,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: discountController,
                  label: 'Chegirmali foiz',
                  validator: (input) =>
                      input!.isEmpty ? 'Chegirmali foizni kiriting' : null,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                !isPressed
                    ? SizedBox(
                        width: 200,
                        child: FloatingActionButton(
                            backgroundColor: Colors.blue,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isPressed = true;
                                });
                                addProductApi(widget.category).then((value) => {
                                      gotoShop(),
                                      setState(() {
                                        isPressed = false;
                                      }),
                                    });
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: const Text('Mahsulot qo\'shish')),
                      )
                    : FloatingActionButton(
                        backgroundColor: Colors.blue,
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _scan() async {
    await FlutterBarcodeScanner.scanBarcode(
            '#000000', 'Cancel', true, ScanMode.BARCODE)
        .then((value) => {
              setState(() {
                barcodeController.text = value;
              })
            });
  }

  generateAuto() {
    var randomNumber = Random();
    number = '';
    for (var i = 0; i < 13; i++) {
      number = number + randomNumber.nextInt(9).toString();
    }
    barcodeController.text = number.toString();
  }

  Future addProductApi(String category) async {
    double sellPrice = double.parse(sellPriceController.text.trim().toString());
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://spiska.pythonanywhere.com/api/product/'));
      request.fields.addAll({
        'shop_id': widget.shopId, // dokon id
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'count': countController.text.trim(),
        'type': unit!,
        'entry_price': enterPriceController.text.trim(),
        "price": myPriceController.text.trim(),
        'percent': percentController.text.trim(),
        'selling_price': sellPrice.round().toString(),
        'barcode': barcodeController.text.trim(),
        "category": "$category-kategoriya",
        "enterprise": "Spiskauz"
      });
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

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Utils.showToast("Yangi mahsulot qo'shildi");
        var res = await response.stream.bytesToString();
        print("-----------------------------------------------");

        print(res.runtimeType);
        return res;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void gotoShop() async {
    final providerShop = Provider.of<GetShopVM>(context, listen: false);
    await providerShop.getShop(widget.shopId.toString()).then((value) => {
          Navigator.pop(
              context,
              MaterialPageRoute(
                  builder: (ctx) => MyShopAdmin(shop: providerShop.shop!))),
          setState(() {
            isPressed = false;
          }),
        });
  }
}
