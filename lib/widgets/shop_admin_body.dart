import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spiska_uz_loyihasi/widgets/warning_dialog.dart';
import '../core/constants.dart';
import '../core/core_widgets.dart';
import '../model/product_model.dart';
import '../model/shop_model.dart';
import '../pages/company/company_add_product.dart';
import '../pages/shop/add_product.dart';
import '../pages/shop/edit_product_page.dart';
import '../pages/shop/myshop_admin.dart';
import '../service/api_response.dart';
import '../service/utils.dart';
import '../view_model/shop/delete_shop_vm.dart';
import '../view_model/shop/get_shop_by_id.dart';
import '../view_model/shop/shop_page_tools_view_model.dart';
import 'custom_dropdown.dart';
import 'custom_list_view.dart';
class ShopAdminBody extends StatefulWidget {
  final String shopId;
  final bool isSearching;
  const ShopAdminBody(
      {Key? key, required this.shopId, required this.isSearching})
      : super(key: key);
  @override
  State<ShopAdminBody> createState() => _ShopAdminBodyState();
}
class _ShopAdminBodyState extends State<ShopAdminBody> {
  List categories = ["1", "2", "3", "5", "6", "7","8","9","10","11","12","13","14","15"];
  String categValue = '1';
  final scrollCtrl = ScrollController();
  Shop? shop;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShopToolsPageVM>(context, listen: true);
    final providerShop = Provider.of<GetShopVM>(context, listen: true);
    final providerDelete = Provider.of<DeleteVM>(context, listen: true);
    return Consumer<GetShopVM>(builder: (context, data, child) {
      if (data.apiResponse.status == Status.HAVE) {
        if (!widget.isSearching) {
          return Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                color: Colors.white,
                alignment: Alignment.centerLeft,
                height: MediaQuery.of(context).size.height / 6,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (data.shop!.type == '1') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => AddingShopProductUi(
                                        shopId: data.shop!.id.toString(),
                                        category: categValue,
                                      )));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => AddingCompanyProductUi(
                                        companyId: data.shop!.id.toString(),
                                        category: categValue,
                                      )));
                        }
                      },
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                            color: const Color(0xff63BDFF),
                            borderRadius: BorderRadius.circular(20)),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.8,
                          child: CustomDropDown(
                              items: categories
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e + '-kategoriya'),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (dynamic input) {
                                setState(() {
                                  categValue = input;
                                });
                              },
                              hint: '$categValue-kategoriya'),
                        ),
                        const Spacer(
                          flex: 2,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Pul birligi ${data.shop?.currency}da',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  ?.copyWith(color: Colors.red, fontSize: 10),
                              textAlign: TextAlign.end,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Jadval ${data.shop?.currency ?? ''}da',
                                  style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 13),
                                ),
                                const SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    changeCurrencyDialog(
                                        context, data.shop!.id.toString());
                                  },
                                  child: !provider.isLoading
                                      ? Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 5),
                                          decoration: BoxDecoration(
                                              color: const Color(0xffC0FFC0),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Text(
                                            '1\$ = ${data.shop?.dollarCurrency}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4?.copyWith(fontSize: 15),
                                          ))
                                      : const SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                     //   const Spacer()
                      ],
                    )
                  ],
                ),
              ),
             // const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    controller: scrollCtrl,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: data.shop?.products?.length,
                    itemBuilder: (ctx, index) {
                      List<ProductModel> list = (data.shop?.products as List)
                          .map((e) => ProductModel.fromJson(e))
                          .toList();
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (ctx) => EditProductPage(
                                        product: list[index],
                                      )));
                        },
                        onLongPress: () {
                          warningDialog1(
                            context,
                            () {
                              providerDelete
                                  .deleteProduct(list[index].id.toString())
                                  .then((value) async => {
                                        await providerShop
                                            .getShop(widget.shopId),
                                        Utils.showToast("Mahsulot o'chirildi!"),
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) => MyShopAdmin(
                                                    shop: providerShop.shop!))),
                                      });
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  height: 130,
                                  width: 120,
                                  imageUrl:
                                      'https://spiska.pythonanywhere.com/${list[index].images?.first}',
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
                              const SizedBox(width: 5),
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6.4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: '${list[index].name}'
                                                    .toUpperCase(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4
                                                    ?.copyWith(
                                                       fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                              )
                                            ]),
                                            maxLines: 1,
                                          ),
                                          RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: 'O\'z.q. narx: ',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4
                                                      ?.copyWith(fontSize: 16)),
                                              TextSpan(
                                                text:
                                                    '${list[index].price} ${data.shop?.currency ?? ''}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4
                                                    ?.copyWith(
                                                  fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                              )
                                            ]),
                                            maxLines: 1,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Sotish narxi: ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4
                                                    ?.copyWith(
                                                        fontSize: 14,
                                                        color: Colors.blue),
                                              ),
                                              Text(
                                                '${list[index].sellingPrice} ${data.shop?.currency ?? ''}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4
                                                    ?.copyWith(
                                                         fontSize: 15,
                                                        fontWeight:

                                                            FontWeight.normal,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: Colors.blue),
                                              ),
                                              const Spacer(),
                                              Text(
                                                '${list[index].percent}%',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4
                                                    ?.copyWith(
                                                        fontSize: 10,
                                                        color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text: 'Jami: ',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline4
                                                            ?.copyWith(
                                                                fontSize: 20,
                                                                color: list[index]
                                                                            .count! <=
                                                                        5
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .black)),
                                                    TextSpan(
                                                      text:
                                                          '${list[index].count}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4
                                                          ?.copyWith(
                                                            color: list[index]
                                                                        .count! <=
                                                                    5
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                    ),
                                                    TextSpan(
                                                      text:
                                                          ' ${itemUnit[int.parse(list[index].type.toString()) - 1]}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .headline4
                                                          ?.copyWith(
                                                            color: list[index]
                                                                        .count! <=
                                                                    5
                                                                ? Colors.red
                                                                : Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                    )
                                                  ],
                                                ),
                                                maxLines: 1,
                                              ),

                                              Text(
                                                '${categories[int.parse(list[index].type.toString())-1]}-kategoriya',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5?.copyWith(fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: const [
                                        Icon(
                                          Icons.circle,
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              downButtons(
                context,
                'Magazindagi jami summa: ${providerShop.shop?.allSum.toString()} ${providerShop.shop?.currency}',
                const Color(0xff42BA96),
              ),
              downButtons(
                context,
                'Turgan tavarlardan: ${providerShop.shop?.allProfit.toString()} ${providerShop.shop?.currency} foyda',
                const Color(0xff2084E9),
              ),
            ],
          );
        } else {
          return CustomListView(
            shopProducts: data.searchedProduct,
            currency: data.shop!.currency!,
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
      }
    });
  }

  void dialogDelete(int index) {
    final provider = Provider.of<ShopToolsPageVM>(context, listen: false);
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Rostan do\'konni o\'chirmoqchimisiz?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('no'.tr())),
                TextButton(
                    onPressed: () {
                      deleteProductApi(
                          provider.shopProducts[index].id.toString());
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: Text('yes'.tr())),
              ],
            ));
  }

  Future deleteProductApi(String id) async {
    try {
      Uri url =
          Uri.parse('https://spiska.pythonanywhere.com/api/product/?id=$id');
      var request = await http.delete(url);
      if (request.statusCode == 200) {
        Utils.showToast('Mahsulot muvaffaqiyatli o\'chirildi!');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
