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
import 'company_admin_page.dart';

class AddingCompanyProductUi extends StatefulWidget {
  final String companyId;
  final String category;
  const AddingCompanyProductUi(
      {Key? key, required this.companyId, required this.category})
      : super(key: key);

  @override
  State<AddingCompanyProductUi> createState() => _AddingCompanyProductUiState();
}

class _AddingCompanyProductUiState extends State<AddingCompanyProductUi> {
  bool isPressed = false;
  final _scrollController = ScrollController();
  DateTime selectedDate = DateTime.now();

  List<String?> itemUnit = ['kg', 'dona', 'litr', 'm²', 'metr', 'm³'];
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
          "Yangi mahsulot qo'shish",
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
                            print('value: $value');
                            images = value;
                          })
                        });
                    print(images);
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

                const SizedBox(height: 20),

                TextFieldForAddProduct(
                  controller: nameController,
                  label: 'Nomi',
                  validator: (input) =>
                      input!.isEmpty ? 'Nomini kiriting' : null,
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: descriptionController,
                  label: 'Tovar tasnifi',
                  validator: (input) =>
                      input!.isEmpty ? 'Tovar tasnifini kiriting' : null,
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
                          print(unit);
                        },
                        hint: const Text('Birligi'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: sellPriceController,
                  label: 'Xizmat narxi',
                  validator: (input) =>
                      input!.isEmpty ? 'Narxini kiriting' : null,
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
          'POST', Uri.parse('https://spiska.pythonanywhere.com/api/eproduct/'));
      request.fields.addAll({
        'shop_id': widget.companyId, // dokon id
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'type': unit!,
        'selling_price': sellPrice.round().toString(),
        "category": category,
        "discount": discountController.text.trim(),
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
        var res = await response.stream.bytesToString();
        return res;
      }
    } on SocketException {
      Utils.showToast("Internet bilan aloqa mavjud emas!");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void gotoShop() async {
    final providerShop = Provider.of<GetShopVM>(context, listen: false);
    await providerShop.getShop(widget.companyId.toString()).then((value) => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) =>
                      CompanyAdminPage(shop: providerShop.shop!))),
          setState(() {
            isPressed = false;
          }),
        });
  }
}
