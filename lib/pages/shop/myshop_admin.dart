import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spiska_uz_loyihasi/pages/shop/shop_clients.dart';
import '../../core/core_widgets.dart';
import '../../model/Member_model.dart';
import '../../model/shop_model.dart';
import '../../view_model/get_products_vm.dart';
import '../../view_model/shop/get_shop_by_id.dart';
import '../../widgets/shop_admin_body.dart';
import '../../widgets/shop_widgets/shop_more_dialog.dart';
class MyShopAdmin extends StatefulWidget {
  final Shop shop;
  const MyShopAdmin({Key? key, required this.shop}) : super(key: key);
  @override
  State<MyShopAdmin> createState() => _MyShopAdminState();
}
class _MyShopAdminState extends State<MyShopAdmin> {

  bool isLiked = false;
  final scrollCtrl = ScrollController();
  bool isSearching = false;
  @override
  void initState() {
    super.initState();
    final provider1 = Provider.of<GetProductsVM>(context, listen: false);
    Future.delayed(Duration.zero).then((value) => {
          _getShop(),
          provider1.getShopProducts(widget.shop.id.toString()),
        });
  }
  void _getShop() async {
    final providerShop = Provider.of<GetShopVM>(context, listen: false);
    await providerShop.getShop(widget.shop.id.toString());
  }
  @override
  Widget build(BuildContext context) {
    final providerShop = Provider.of<GetShopVM>(context, listen: true);
    return Scaffold(
      appBar: !isSearching
          ? AppBar(
              backgroundColor: Colors.blue,
              titleTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  overflow: TextOverflow.ellipsis),
              iconTheme: const IconThemeData(color: Colors.white),
              actionsIconTheme: const IconThemeData(color: Colors.white),
              title: InkWell(
                onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return FullScreenImage(
                          imageUrl:
                              'https://spiska.pythonanywhere.com/${widget.shop.img}',
                          tag: "generate_a_unique_tag",
                        );
                      },
                    ),
                  );
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
                        widget.shop.name!.toUpperCase(),
                        style: const TextStyle(overflow: TextOverflow.clip),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
                ElevatedButton(
                    onPressed: () {
                      dialogShop(context, widget.shop);
                    },
                    child: Image.asset(
                      'assets/images/filter.png',
                      height: 22,
                      width: 22,
                    )),
              ],
            )
          : AppBar(
              leading: IconButton(
                onPressed: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    isSearching = false;
                    providerShop.searchTextController.text = '';
                  });
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
              ),
              title: TextField(
                controller: providerShop.searchTextController,
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
                  providerShop.searchProduct(
                      providerShop.searchTextController.text.trim());
                },
              ),
            ),
      body: ShopAdminBody(
        isSearching: isSearching,
        shopId: widget.shop.id.toString(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 130.0),
        child: FloatingActionButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (ctx) => Shop_Clients(
                        members: (widget.shop.members as List)
                        .map((e) => MemberModel.fromJson(e))
                        .toList(),
                    ),

                ));
          },
          child: Icon(Icons.people_sharp,color: Colors.blue),
        ),
      ),
    );
  }
}
Container downButtons(BuildContext context, String text, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    alignment: Alignment.centerLeft,
    width: double.infinity,
    constraints: const BoxConstraints(
      maxHeight: 55,
      minHeight: 50,
    ),
    color: color,
    child: Text(
      text,
      style:
          Theme.of(context).textTheme.headline4?.copyWith(color: Colors.white),
    ),
  );
}
