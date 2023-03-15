import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/cart_view_model.dart';
class MyCart extends StatefulWidget {
  String id;
  MyCart({Key? key, required this.id}) : super(key: key);

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  void initState() {
    final provider = Provider.of<CartVM>(context, listen: false);
    super.initState();
    provider.calcAllCost();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartVM>(context, listen: false);
    var formatter = NumberFormat('###,###,###.0');
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'cart'.tr(),
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: provider.cartItems.isNotEmpty
          ? Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ListView.builder(
                    itemCount: provider.cartItems.length,
                    itemBuilder: (ctx, index) {
                      return provider.cartItems[index].shopId == widget.id
                          ? Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                setState(() {
                                  provider.cartItems.removeAt(index);
                                  provider.calcAllCost();
                                });
                              },
                              background: Container(
                                  alignment: Alignment.center,
                                  color: Colors.red,
                                  child: const Text(
                                    'O\'chirish',
                                    style: TextStyle(fontSize: 22),
                                  )),
                              child: InkWell(
                                onTap: () {
                                  dialogEdit(index);
                                },
                                child: Card(
                                  child: Container(
                                    // height: MediaQuery.of(context).size.height / 5,
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 0, 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.transparent,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            width: 120,
                                            height: 120,
                                            imageUrl:
                                                'https://spiska.pythonanywhere.com/${provider.cartItems[index].img![0]}',
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context,
                                                url, downloadProgress) {
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value:
                                                      downloadProgress.progress,
                                                  color: Colors.grey[350],
                                                  strokeWidth: 3,
                                                ),
                                              );
                                            },
                                            errorWidget:
                                                (context, url, error) => Icon(
                                              Icons.error,
                                              color: Colors.grey[350],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                provider.cartItems[index]
                                                        .name ??
                                                    '...',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline3
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FontStyle.italic),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.6,
                                              child: Text(
                                                'Jami Summa: ${formatter.format(num.parse(provider.cartItems[index].sum.toString()))} so\'m',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FontStyle.italic),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.6,
                                              child: Text(
                                                'Mahsulot narxi: ${formatter.format(num.parse(provider.cartItems[index].price.toString()))} so\'m',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                    ),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.6,
                                              child: Text(
                                                'Olindi(miqdor): ${formatter.format(num.parse(provider.cartItems[index].amount.toString()))} ${provider.cartItems[index].type.toString()} ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline4
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height,
                              child: Text(
                                'Bu do\'kondan mahsulot qo\'shilmagan',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    ?.copyWith(fontWeight: FontWeight.normal),
                              ),
                            );
                    }),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    'Umumiy Xarajat: ${formatter.format(provider.allCost)}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                )
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: Text(
                'Korzinka bo\'sh',
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: provider.cartItems.isNotEmpty
          ? SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width / 2.5,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                onPressed: () {
                  print(provider.cartItems[0].sum);
                  dialog1();
                },
                child: Text(
                  'Buyurtma berish',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  void dialog1() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              actionsOverflowDirection: VerticalDirection.down,
              actionsAlignment: MainAxisAlignment.center,
              title: Text(
                'To\'lov turini tanlang',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    dialog2();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Naqt pul',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    dialog2();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Plastik',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
              ],
              alignment: Alignment.center,
            ));
  }

  void dialog2() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              actionsPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
              actionsOverflowDirection: VerticalDirection.down,
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'Yetkazib berish',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                InkWell(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      'O’zim olib ketaman',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                )
              ],
              alignment: Alignment.center,
            ));
  }

  void dialogEdit(index) {
    final provider = Provider.of<CartVM>(context, listen: false);
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Container(
                height: MediaQuery.of(context).size.width / 2.5 / 2,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: TextFormField(
                        // focusNode: FocusNode(canRequestFocus: false),
                        controller: provider.newAmount,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 19, color: Colors.black54),
                        decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                    const BorderSide(color: Colors.red)),
                            labelText: 'Yangi Miqdor...',
                            labelStyle:
                                Theme.of(context).textTheme.headline6?.copyWith(
                                      fontSize: 16,
                                    )),
                        keyboardType: TextInputType.number,
                        maxLength: 256,
                        validator: (value) =>
                            value!.isEmpty ? 'Miqdorni kiriting' : null,
                      ),
                    ),
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceAround,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      height: 40,
                      width: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text('Bekor qilish')),
                ),
                InkWell(
                  onTap: () {
                    provider.afterEditCalc(index);
                    Navigator.pop(context);
                    provider.newAmount.clear();
                  },
                  child: Container(
                      height: 40,
                      width: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text('Ok')),
                ),
              ],
            ));
  }
}
