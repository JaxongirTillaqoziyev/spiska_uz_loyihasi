import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spiska_uz_loyihasi/pages/shop/ClientSpiskalari/client_spiskalari.dart';
import 'package:spiska_uz_loyihasi/pages/shop/shop_location.dart';
import '../../core/core_widgets.dart';
import '../../model/person_model.dart';
import '../../model/shop_model.dart';
import '../../service/api_response.dart';
import '../../service/barcode_service.dart';
import '../../service/hive_service.dart';
import '../../view_model/get_products_vm.dart';
import '../../view_model/shop/get_shop_by_id.dart';
import '../../widgets/custom_gridview.dart';
import '../../widgets/dialog_admin_info.dart';
import '../../widgets/product_image.dart';
import '../cart_ui.dart';

class MyShopClient extends StatefulWidget {
  final Shop shop;

  const MyShopClient({Key? key, required this.shop}) : super(key: key);

  @override
  State<MyShopClient> createState() => _MyShopClientState();
}

class _MyShopClientState extends State<MyShopClient> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<GetProductsVM>(context, listen: false);
    Future.delayed(Duration.zero).then((value1) => {
          provider.getShopProducts(widget.shop.id.toString()),
        });
  }

  bool isSearching = false;

  bool isMember(Shop shop) {
    List<Person> persons =
        shop.members!.map((e) => Person.fromJson(e)).toList();
    Person user = HiveDB.loadPerson();
    return persons.contains(user);
  }

  @override
  Widget build(BuildContext context) {
    final providerBarcode = Provider.of<BarcodeService>(context, listen: false);
    final providerProduct = Provider.of<GetProductsVM>(context, listen: true);
    final providerShop = Provider.of<GetShopVM>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: !isSearching
          ? AppBar(
              titleTextStyle: const TextStyle(color: Colors.white),
              actionsIconTheme: const IconThemeData(color: Colors.white),
              iconTheme: const IconThemeData(color: Colors.white),
              title: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return FullScreenImage(
                      imageUrl:
                          'https://spiska.pythonanywhere.com/${widget.shop.img}',
                      tag: "generate_a_unique_tag",
                    );
                  }));
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Hero(
                        tag: 'image1',
                        child: CachedNetworkImage(
                          width: 50,
                          height: 50,
                          imageUrl:
                              'https://spiska.pythonanywhere.com/${widget.shop.img}',
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) {
                            return Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: Colors.grey[350],
                                strokeWidth: 3,
                              ),
                            );
                          },
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.grey[350],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "${widget.shop.name}",
                        style: const TextStyle(overflow: TextOverflow.clip),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  child: const Icon(Icons.search),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                     //   builder: (ctx) => MyCart(id: widget.shop.id.toString()),
                        builder: (ctx) => Client_spisklari()),
                    );
                  },
                  child: const Icon(Icons.shopping_cart),
                ),
                const SizedBox(width: 20),
              ],
            )
          : AppBar(
              leading: IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    isSearching = false;
                    providerProduct.searchTextController.text = "";
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
              ),
              title: TextField(
                controller: providerProduct.searchTextController,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  fillColor: Colors.white,
                  filled: true,
                  constraints:
                      const BoxConstraints(minHeight: 38, maxHeight: 42),
                  hintText: "Mahsulot qidirish",
                  hintStyle: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (input) {
                  providerProduct.searchProduct(
                      providerProduct.searchTextController.text.trim());
                },
              ),
            ),
      body: Consumer<GetProductsVM>(builder: (context, data, child) {
        if (data.apiResponse.status == Status.HAVE) {
          if (!isSearching) {
            return Column(
              children: [
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CarouselSlider.builder(
                            itemCount: widget.shop.selected?.length,
                            options: CarouselOptions(
                              disableCenter: false,
                              autoPlay: false,
                              enlargeCenterPage: false,
                              viewportFraction: 1,
                              initialPage: 0,
                              height: MediaQuery.of(context).size.width / 2.3,
                            ),
                            itemBuilder: (BuildContext context, int itemIndex,
                                int pageViewIndex) {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color(0xff5FD3F8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                        left: Radius.circular(10),
                                      ),
                                      child: ProductImage(
                                        height:
                                            MediaQuery.of(context).size.width,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        image:
                                            'https://images.unsplash.com/photo-1581456495146-65a71b2c8e52?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80',
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: Text(
                                        '${widget.shop.name?.toUpperCase()} Do’konimizga siz kutgan Yangi maxsulotlar chegirmali narxlarda yetib keldi.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            ?.copyWith(
                                          fontSize: 18,
                                              color: Colors.white,
                                            ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 8,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                        CustomGridView(
                          currency: widget.shop.currency ?? '',
                          shopProducts: data.shopProducts,
                          addCart: () {},
                          likeButton: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                if (isMember(widget.shop) == false)
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 50,
                    color: Colors.blue,
                    child: const Text(
                      "Do'konga ulanish",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            );
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomGridView(
                  currency: widget.shop.currency!,
                  addCart: () {},
                  likeButton: () {},
                  shopProducts: [...data.searchedProduct],
                ),
              ),
            );
          }
        } else if (data.apiResponse.status == Status.HAVENOT) {
          return Center(
            child: Shimmer.fromColors(
              highlightColor: Colors.green,
              baseColor: Colors.redAccent,
              child: Text(
                data.apiResponse.message ?? '',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          );
        } else if (data.apiResponse.status == Status.ERROR) {
          return Center(
            child: Shimmer.fromColors(
              highlightColor: Colors.green,
              baseColor: Colors.redAccent,
              child: Text(
                data.apiResponse.message ?? '',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: isMember(widget.shop) ? 40.0 : 0),
        child: SpeedDial(
          backgroundColor: Colors.blue,
          children: [
            SpeedDialChild(
                onTap: () {
            MapUtils.openMap(double.parse(providerShop.shop!.location!['lat']),double.parse(providerShop.shop!.location!['lon']));
                }, child: const Icon(Icons.location_on_outlined)),
            SpeedDialChild(
                onTap: () {
                  dialogAdminInfo(context,
                      "Do'kon adminlari telegramlari", "https://t.me/");
                },
                child: const Icon(
                  Icons.telegram,
                  color: Colors.blue,
                )),
            SpeedDialChild(
              onTap: () {
                providerBarcode.scan();
              },
              child: const Icon(Icons.qr_code_scanner_rounded),
            ),
            SpeedDialChild(
                onTap: () {
                  dialogAdminInfo(
                      context, "Do'kon adminlari telefon nomerlari:", "tel:");
                },
                backgroundColor: Colors.blue,
                child: const Icon(
                  Icons.phone,
                  color: Colors.white,
                )),
          ],
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
//[{id: 7, first_name: Dilshodbek, last_name: Qurbonaliyev, phone: +998911490349, img: /media/profile-img/scaled_image_picker3152970648733462374.jpg, diamond: 200}]
