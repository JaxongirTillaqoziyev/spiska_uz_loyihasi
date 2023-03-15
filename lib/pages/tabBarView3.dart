import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spiska_uz_loyihasi/pages/shop/my_shop_client.dart';
import '../core/apis.dart';
import '../model/product_model.dart';
import '../model/shop_model.dart';
import '../service/api_response.dart';
import '../view_model/main_tabbar_vm/tab3_view_model.dart';
import '../view_model/pick_regions_vm.dart';
import '../view_model/shop/get_shop_by_id.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/product_image.dart';
class TabBar3 extends StatefulWidget {
  const TabBar3({Key? key}) : super(key: key);
  @override
  State<TabBar3> createState() => _TabBar3State();
}
class _TabBar3State extends State<TabBar3> {
  @override
  void initState() {
    super.initState();
    final providerTab3 = Provider.of<Tab3VM>(context, listen: false);
    final providerRegions = Provider.of<PickRegionsVM>(context, listen: false);
    providerRegions.getRegionsAPI(context);
    providerTab3.getProducts();
  }

  List<String?> itemUnit = ['Kg', 'Dona', 'Litr', 'm²', 'Metr', 'm³'];
  @override
  Widget build(BuildContext context) {
    final provider2 = Provider.of<PickRegionsVM>(context, listen: true);
    final providerTab3 = Provider.of<Tab3VM>(context, listen: true);
    final providerShop = Provider.of<GetShopVM>(context, listen: true);
    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 5),
            Expanded(
              child: CustomDropDown(
                items: provider2.viloyat
                    ?.map((e) => DropdownMenuItem(
                          value: e.id,
                          child: Text(
                            '${e.name}',
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                          ),
                        ))
                    .toList(),
                onChanged: (dynamic input) {
                  providerTab3.getProducts(region: input);
                  provider2.getTuman(input);
                },
                hint: "Viloyat",
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: !provider2.loader1
                  ? CustomDropDown(
                      items: provider2.tuman
                          ?.map((e) => DropdownMenuItem(
                                value: e.id,
                                child: Text(
                                  '${e.name}',
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ))
                          .toList(),
                      onChanged: (dynamic input) {
                        providerTab3.getProducts(
                            region: provider2.vilId, district: input);
                      },
                      hint: "Tuman",
                    )
                  : const Center(child: CircularProgressIndicator()),
            ),
            const SizedBox(width: 5),
          ],
        ),
        Expanded(
          child: Consumer<Tab3VM>(builder: (context, data, child) {
            if (data.apiResponse.status == Status.HAVE) {
              return Container(
                color: Colors.grey.shade100,
                child: GridView.builder(
                  padding: const EdgeInsets.all(1),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemCount: data.allProducts.length,
                  itemBuilder: (ctx, index) {
                    ProductModel product = data.apiResponse.data[index];
                    return InkWell(
                      onTap: () async {
                        await providerShop
                            .getShop(data.allProducts[index].shopId.toString())
                            .then((value) => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => MyShopClient(
                                        shop: providerShop.shop!,
                                      ),
                                    ),
                                  ),
                                });
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10)),
                                  child: ProductImage(
                                      height: 180,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      image:
                                          '${ApiUrl.baseUrl}${product.images?[0]}'),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.white10,
                                          blurRadius: 1,
                                          spreadRadius: 1),
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          offset: Offset(5.2, 6.2)),
                                      BoxShadow(
                                          color: Colors.white,
                                          blurRadius: 5,
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
                                              onTap: () {},
                                              child:   Image.asset(
                                                "assets/images/like_btn.png",
                                                height: 20,
                                                width: 20,
                                                alignment: Alignment.bottomRight,
                                              )),
                                          SizedBox(width: 5,),
                                          Text(
                                            "${product.likes?.length.toString()}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                ?.copyWith(color: Colors.red,
                                            fontSize: 17
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '-${product.discountPercentage}%',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            ?.copyWith(
                                            fontSize: 13,
                                            color: Colors.red),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Spacer(),
                                  Text(
                                    data.apiResponse.data[index].name
                                            ?.toUpperCase() ,
                                    style:
                                        Theme.of(context).textTheme.headline4?.copyWith(fontSize: 12),
                                   // maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                  Text(
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(
                                            fontSize: 13,
                                            color: Colors.red,
                                            decoration:
                                                TextDecoration.lineThrough),
                                    '${product.sellingPrice! + product.percent! * product.sellingPrice! / 100} ${product.moneyType != '1' ? "Dollar" : "So'm"}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                  Text(
                                    style:
                                        Theme.of(context).textTheme.headline4?.copyWith(fontSize: 13),
                                    '${product.sellingPrice} ${product.moneyType != '1' ? "Dollar" : "So'm"}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      //TODO mahsulotni savatga qoshishda savatga faqat id qashadigan qil keyin id boyicha mahsulotni savatda korsataverasan, 1ta mahsulot 2marta qoshishda ham muammo bolmaydi
                                      // provider1.cartItems.add(SellingItem(
                                      //   img: [...?provider.shopProducts[index].images],
                                      //   name: provider.shopProducts[index].name,
                                      //   price: provider.shopProducts[index].sellingPrice
                                      //       .toString(),
                                      //   proBarcode: '123423232',
                                      //   productId: '',
                                      //   shopId: providerShop.shop?.id.toString(),
                                      //   type: provider.shopProducts[index].type,
                                      //   sum: provider.shopProducts[index].sellingPrice
                                      //       .toString(),
                                      //   amount: '1',
                                      // ));
                                      // setState(() {});
                                      // Utils.showToast('Mahsulot savatga qo\'shildi');
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${product.count} ${itemUnit[int.parse(product.type.toString())-1]}"
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5?.copyWith(fontSize: 13),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Image.asset(
                                          "assets/images/basket_btn.png",
                                          height: 25,
                                          width: 25,
                                          alignment: Alignment.bottomRight,
                                        )

                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (data.apiResponse.status == Status.HAVENOT) {
              print('succcess not');
              return Center(
                child: Shimmer.fromColors(
                  highlightColor: Colors.green,
                  baseColor: Colors.redAccent,
                  child: Text(
                    "${data.apiResponse.message}",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              );
            } else if (data.apiResponse.status == Status.ERROR) {
              print('error');
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
              print('loading');
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void gotoShop(Shop shop) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => MyShopClient(
                  shop: shop,
                )));
  }
}
