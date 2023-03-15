import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../core/core_widgets.dart';
import '../../model/product_model.dart';
import '../../view_model/shop/edit_product_vm.dart';
import '../../view_model/shop/get_shop_by_id.dart';
import '../../widgets/custom_textfield.dart';
import 'myshop_admin.dart';

class EditProductPage extends StatefulWidget {
  final ProductModel product;
  const EditProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<EditProductVM>(context, listen: false);

    Future.delayed(Duration.zero).then((value) => {
          getShop(),
          provider.getOldData(widget.product),
        });
  }

  Future getShop() async {
    final provider1 = Provider.of<GetShopVM>(context, listen: false);
    await provider1.getShop(widget.product.shopId.toString());
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EditProductVM>(context, listen: false);
    final provider1 = Provider.of<GetShopVM>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mahsulotni tahrirlash',
          style: TextStyle(fontSize: 19, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        controller: provider.scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Form(
            key: provider.formKey,
            child: Column(
              children: [
                //image area
                InkWell(
                  onTap: () {
                    CoreFunctios.imgFromGallery().then((value) => {
                          setState(() {
                            provider.images = value;
                          })
                        });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: MediaQuery.of(context).size.width - 90,
                    color: Colors.grey.withOpacity(0.4),
                    child: provider.images.isEmpty
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
                                  autoPlay:
                                      provider.images.length > 1 ? true : false,
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
                                    provider.images[itemIndex],
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
                                          provider.images.removeAt(0);
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
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: provider.nameController,
                  label: 'Nomi',
                  validator: (input) =>
                      input!.isEmpty ? 'Ismizni kiriting' : null,
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: provider.descriptionController,
                  label: 'Tovar tasnifi',
                  validator: (input) =>
                      input!.isEmpty ? 'Ismizni kiriting' : null,
                ),
                const SizedBox(height: 10),
                //Soni
                TextFieldForAddProduct(
                  keyboardType: TextInputType.number,
                  controller: provider.countController,
                  label: 'Soni',
                  validator: (input) =>
                      input!.isEmpty ? 'Sonini kiriting' : null,
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: provider.enterPriceController,
                  label: 'Kirish narxi',
                  validator: (input) =>
                      input!.isEmpty ? 'Narxini kiriting' : null,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: provider.percentController,
                  keyboardType: TextInputType.number,
                  label: 'Foiz',
                  validator: (input) =>
                      input!.isEmpty ? 'Foizni kiriting' : null,
                  onChanged: (input) {
                    provider.sellPriceController.text =
                        "${(num.parse(provider.myPriceController.text.trim()) * num.parse(provider.percentController.text.trim()) / 100) + num.parse(provider.myPriceController.text.trim())}";
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: provider.myPriceController,
                  label: 'O\'zim qo\'ygan narxi',
                  validator: (input) =>
                      input!.isEmpty ? 'Sotish narxini  kiriting' : null,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                TextFieldForAddProduct(
                  controller: provider.sellPriceController,
                  label: 'Sotish narxi',
                  validator: (input) =>
                      input!.isEmpty ? 'Sotish narxini  kiriting' : null,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: IconButton(
                    icon: !provider.isCheck
                        ? const Icon(Icons.check_box_outline_blank)
                        : const Icon(Icons.check_box),
                    onPressed: () {
                      setState(() {
                        provider.isCheck = !provider.isCheck;
                      });
                      print(provider.isCheck);
                    },
                  ),
                  title: Text(
                    "Bosh sahifada ko'rinsinmi?",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const SizedBox(height: 20),
                !provider.isPressed
                    ? SizedBox(
                        width: 200,
                        child: FloatingActionButton(
                            backgroundColor: Colors.blue,
                            onPressed: () {
                              if (provider.formKey.currentState!.validate()) {
                                provider
                                    .editProduct(
                                        context, widget.product.id.toString())
                                    .then((value) => {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) => MyShopAdmin(
                                                      shop: provider1.shop!)))
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
}
