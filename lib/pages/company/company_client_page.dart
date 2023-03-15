import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/core_widgets.dart';
import '../../model/shop_model.dart';
import '../../service/api_response.dart';
import '../../view_model/get_products_vm.dart';
import '../../view_model/like_vm.dart';
import '../../view_model/shop/get_shop_by_id.dart';
import '../../widgets/custom_gridview.dart';
import '../../widgets/product_image.dart';
import '../cart_ui.dart';

class CompanyClientPage extends StatefulWidget {
  final Shop shop;
  const CompanyClientPage({Key? key, required this.shop}) : super(key: key);

  @override
  State<CompanyClientPage> createState() => _CompanyClientPageState();
}

class _CompanyClientPageState extends State<CompanyClientPage> {
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<GetProductsVM>(context, listen: false);
    // final providerShop = Provider.of<GetShopVM>(context, listen: false);
    Future.delayed(Duration.zero).then((value) => {
          _getShop(),
          provider.getShopProducts(widget.shop.id.toString()),
        });
  }

  void _getShop() async {
    final providerShop = Provider.of<GetShopVM>(context, listen: false);
    await providerShop.getShop(widget.shop.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    final providerLike = Provider.of<LikeVM>(context, listen: false);
    final providerProduct = Provider.of<GetProductsVM>(context, listen: true);

    return Scaffold(
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
                        builder: (ctx) => MyCart(id: widget.shop.id.toString()),
                      ),
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
      body: Consumer<GetProductsVM>(
        builder: (context, data, child) {
          if (data.apiResponse.status == Status.HAVE) {
            if (!isSearching) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  enterMetalSize(
                    context,
                    title: 'Razmeri kiriting 1.1 lik 1.90*1.25 lik',
                    onPressed: () {},
                  ),
                  enterMetalSize(
                    context,
                    title: 'Nechchi kesilsin 1.90*0.62.5 lik',
                    onPressed: () {},
                  ),
                  Expanded(
                    child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.6,
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 2),
                        itemCount: data.shopProducts.length,
                        itemBuilder: (ctx, index) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(10)),
                                        child: ProductImage(
                                            height: 200,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            image:
                                                'https://spiska.pythonanywhere.com/${data.shopProducts[index].images?[0]}'),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.white10,
                                                blurRadius: 5,
                                                spreadRadius: 5),
                                            BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 15,
                                                spreadRadius: 7,
                                                offset: Offset(5.2, 6.2)),
                                            BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 15,
                                                spreadRadius: 7,
                                                offset: Offset(5.2, 6.2))
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                    onTap: () {
                                                      providerLike.pressLike();
                                                    },
                                                    child: providerLike.isLiked
                                                        ? const Icon(
                                                            Icons.favorite,
                                                            color: Colors.red,
                                                          )
                                                        : const Icon(Icons
                                                            .favorite_border)),
                                                Text(
                                                  '99999',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4
                                                      ?.copyWith(
                                                          color: Colors.red),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                            Text(
                                              '-5%',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  ?.copyWith(color: Colors.red),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Spacer(),
                                          Text(
                                            data.shopProducts[index].name
                                                    ?.toUpperCase() ??
                                                '...',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          Text(
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                ?.copyWith(
                                                    color: Colors.red,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                            '${data.shopProducts[index].sellingPrice} ${widget.shop.currency}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          Text(
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4,
                                            '${data.shopProducts[index].sellingPrice} ${widget.shop.currency}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {},
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "${data.shopProducts[index].count} ${data.shopProducts[index].type}"
                                                      .toString(),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const Icon(
                                                  Icons.shopping_cart_outlined,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
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
        },
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.blue,
        children: [
          SpeedDialChild(child: const Icon(Icons.location_on_outlined)),
          SpeedDialChild(
              child: const Icon(
            Icons.telegram,
            color: Colors.blue,
          )),
          SpeedDialChild(child: const Icon(Icons.qr_code_scanner_rounded)),
          SpeedDialChild(
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
    );
  }

  InkWell enterMetalSize(BuildContext context,
      {required String title, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        alignment: Alignment.centerLeft,
        height: 45,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.black,
          width: 0.5,
        )),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
