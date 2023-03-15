import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../pages/home_page.dart';
import '../service/utils.dart';
import '../view_model/cart_view_model.dart';
import '../view_model/shop/get_shop_by_id.dart';
import '../view_model/shop/shop_page_tools_view_model.dart';
import '../widgets/custom_textfield.dart';
class PriceWidget extends StatelessWidget {
  int? index1;
  bool isCart;
  PriceWidget({Key? key, this.index1, required this.isCart}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartVM>(context, listen: true);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                if (isCart == false) {
                  provider.unAdd();
                } else {
                  provider.unAdd();
                }
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: 2,
                    width: 15,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(width: 20),
            Text(
              isCart
                  ? provider.cartItems[index1!].amount.toString()
                  : provider.count.toString(),
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () {
                if (isCart == false) {
                  provider.add();
                } else {
                  provider.add();
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10)),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
        Slider(
          value: provider.count.toDouble(),
          min: 1,
          max: 150,
          onChanged: (double? a) {
            provider.sliderCalc(a);
          },
        ),
      ],
    );
  }
}

PreferredSizeWidget shopAppBarLoading(BuildContext context) {
  return AppBar(
    titleTextStyle: const TextStyle(color: Colors.white),
    actionsIconTheme: const IconThemeData(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
    title: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Hero(
            tag: 'image1',
            child: Image.asset(
              "assets/images/shop_vector.png",
              width: 50,
              height: 50,
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            "...",
            style: TextStyle(overflow: TextOverflow.clip),
          ),
        ),
      ],
    ),
    actions: [
      InkWell(
        onTap: () {
          // _launchCaller(shop.host!['phone']);
        },
        child: const Icon(Icons.search),
      ),
      const SizedBox(width: 20),
      const Icon(Icons.shopping_cart),
      const SizedBox(width: 20),
    ],
  );
}

void changeCurrencyDialog(BuildContext context, String shopId) {
  final provider = Provider.of<ShopToolsPageVM>(context, listen: false);
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text(
              'Yangi valyuta summasini kiritish',
              style: Theme.of(context).textTheme.headline4,
            ),
            content: CustomTextfield(
              hintText: 'Kursni kiriting',
              controller: provider.exchangeRateController,
              keyboardType: TextInputType.number,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Bekor Qilish'),
              ),
              TextButton(
                onPressed: () {
                  provider.changeExchangeRate(shopId).then((value) => {
                        _getShop(context, shopId),
                      });
                  Navigator.pop(context);
                },
                child: const Text('Yangilash'),
              )
            ],
          ));
}

void _getShop(BuildContext context, String shopId) async {
  final providerShop = Provider.of<GetShopVM>(context, listen: false);
  await providerShop.getShop(shopId);
}

void deleteShop(String id, context) async {
  try {
    Uri url = Uri.parse('https://spiska.pythonanywhere.com/api/shop/?id=$id');
    var request = await http.delete(url);
    if (request.statusCode == 200) {
      Utils.showToast("Do'kon muvaffaqiyatli o'chirildi!");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx) => const HomePage()));
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}

class CoreFunctios {
  static List<File> images = [];
  static ImagePicker imagePicker = ImagePicker();

  static Future imgFromGallery() async {
    images.clear();
    try {
      var image = await imagePicker.pickMultiImage(imageQuality: 50);
      print(image);
      for (int i = 0; i < image.length; i++) {
        images.add(File(image[i].path));
      }
      print('images:$images');
      return images;
    } catch (e) {
      if (kDebugMode) {
        print('image error: $e');
      }
    }
  }

  /// pick images from gallery
  static imgFromCamera() async {
    XFile? image = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    images.add(File(image!.path));
  }

  static void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    print(DateTime.now().microsecondsSinceEpoch);
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}

class FullScreenImage extends StatelessWidget {
  final String? imageUrl;
  final String? tag;

  const FullScreenImage({Key? key, this.imageUrl, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: tag!,
            child: CachedNetworkImage(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
              imageUrl: imageUrl!,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
