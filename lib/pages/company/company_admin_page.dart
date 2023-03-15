import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/core_widgets.dart';
import '../../model/shop_model.dart';
import '../../service/api_response.dart';
import '../../view_model/get_products_vm.dart';
import '../../view_model/shop/get_shop_by_id.dart';
import '../../view_model/shop/shop_page_tools_view_model.dart';
import '../../widgets/company_widgets/company_more_dialog.dart';
import '../../widgets/custom_dropdown.dart';
import '../shop/myshop_admin.dart';
import 'company_add_product.dart';

class CompanyAdminPage extends StatefulWidget {
  final Shop shop;
  const CompanyAdminPage({Key? key, required this.shop}) : super(key: key);

  @override
  State<CompanyAdminPage> createState() => _CompanyAdminPageState();
}

class _CompanyAdminPageState extends State<CompanyAdminPage> {
  final scrollCtrl = ScrollController();

  List categories = [
    "1smx10sm",
    "10smx25sm",
    "25smx55sm",
    "55smx125sm",
    "125sm ++",
  ];
  String categValue = '1smx10sm';

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<GetProductsVM>(context, listen: false);
    Future.delayed(Duration.zero).then((value) => {
          _getShop(),
          provider.getShopProducts(widget.shop.id.toString()),
        });
  }

  void _getShop() async {
    final providerShop = Provider.of<GetShopVM>(context, listen: false);
    await providerShop.getShop(widget.shop.id.toString());
  }

  num allEntryPriceSum = 0;
  num totalSumInAProduct = 0;
  int productCount = 0;
  num profitOrLossInProduct = 0;

  @override
  Widget build(BuildContext context) {
    final providerShop = Provider.of<GetShopVM>(context, listen: true);
    final provider = Provider.of<ShopToolsPageVM>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
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
                    progressIndicatorBuilder: (context, url, downloadProgress) {
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
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          ElevatedButton(
              onPressed: () {
                dialogCompany(context, widget.shop);
              },
              child: Image.asset(
                'assets/images/filter.png',
                height: 22,
                width: 22,
              )),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.white,
            alignment: Alignment.centerLeft,
            height: MediaQuery.of(context).size.height / 6,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => AddingCompanyProductUi(
                                  companyId: widget.shop.id.toString(),
                                  category: categValue,
                                )));
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
                      size: 50,
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
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (dynamic input) {
                            setState(() {
                              categValue = input;
                            });
                          },
                          hint: categValue),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Pul birligi ${widget.shop.currency}da',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.red, fontSize: 14),
                          textAlign: TextAlign.end,
                        ),
                        Row(
                          children: [
                            Text(
                              'Jadval ${widget.shop.currency ?? ''}da',
                              style: Theme.of(context).textTheme.headline5,
                            ),
                            const SizedBox(width: 5),
                            InkWell(
                              onTap: () {
                                changeCurrencyDialog(
                                    context, widget.shop.id.toString());
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 5),
                                decoration: BoxDecoration(
                                    color: const Color(0xffC0FFC0),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Text(
                                  '1\$ = ${providerShop.shop?.dollarCurrency ?? ''}',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer()
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer<GetProductsVM>(
              builder: (context, data, child) {
                if (data.apiResponse.status == Status.HAVE) {
                  return ListView.builder(
                      controller: scrollCtrl,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: data.shopProducts.length,
                      itemBuilder: (ctx, index) {
                        productCount = data.shopProducts.length;
                        allEntryPriceSum +=
                            data.shopProducts[index].entryPrice! *
                                data.shopProducts[index].count!;
                        print(data.shopProducts[index].entryPrice!);
                        print(data.shopProducts[index].count!);
                        profitOrLossInProduct +=
                            (data.shopProducts[index].entryPrice! -
                                data.shopProducts[index].price!);
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 1)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    height: 120,
                                    width: 120,
                                    imageUrl:
                                        'https://spiska.pythonanywhere.com/${data.shopProducts[index].images?.first}',
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
                              const SizedBox(width: 5),
                              Expanded(
                                child: SizedBox(
                                  height: 120,
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
                                              text: 'Nomi: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  ?.copyWith(fontSize: 20)),
                                          TextSpan(
                                            text:
                                                '${data.shopProducts[index].name}'
                                                    .toUpperCase(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w800,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                          )
                                        ]),
                                        maxLines: 1,
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
                                                            fontSize: 20)),
                                                TextSpan(
                                                  text:
                                                      '${data.shopProducts[index].count}',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                ),
                                                TextSpan(
                                                  text:
                                                      '${data.shopProducts[index].type}q',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline4
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                )
                                              ],
                                            ),
                                            maxLines: 1,
                                          ),
                                          Text(
                                            '1-kategoriya',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline5,
                                          ),
                                        ],
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: 'O\'lchov birligi: ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline4
                                                  ?.copyWith(fontSize: 20)),
                                          TextSpan(
                                            text:
                                                '${data.shopProducts[index].type}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline4
                                                ?.copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                          )
                                        ]),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      });
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
          ),
          downButtons(
              context,
              'Magazindagi jami summa: ${allEntryPriceSum * productCount} so\'m',
              const Color(0xff42BA96)),
          downButtons(
              context,
              'Turgan tavarlardan: ${profitOrLossInProduct * productCount} foyda',
              const Color(0xff2084E9)),
        ],
      ),
      // floatingActionButton: SpeedDial(
      //   backgroundColor: Colors.blue,
      //   children: [
      //     SpeedDialChild(child: const Icon(Icons.shopping_cart_outlined)),
      //     SpeedDialChild(child: const Icon(Icons.qr_code_scanner_rounded)),
      //   ],
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      // ),
    );
  }

  int exchangeRate = 11200;
  final exchangeRateController = TextEditingController();

  void changeexchangeRate() {
    setState(() {
      exchangeRate = int.parse(exchangeRateController.text.trim());
    });
  }
}
