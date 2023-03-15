import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/shop_info_and_add_customer_view_model.dart';

class AddCustomerPage extends StatefulWidget {
  final int shopId;
  const AddCustomerPage({Key? key, required this.shopId}) : super(key: key);

  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ShopInfoVM>(context, listen: false);
    Future.delayed(Duration.zero).then((value) => {provider.fetchCustomer()});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShopInfoVM>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const Text(
          'A\'zolar qo\'shish',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: provider.customer,
              onChanged: (input) {
                setState(() {
                  provider.fetchCustomerBySearch(input);
                });
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 10.0),
                fillColor: Colors.white,
                filled: true,
                hintText: 'A\'zolarni qidirsh',
                prefixIcon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black54,
                    )),
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 10, minHeight: 0),
                hintStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blue)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blue)),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.transparent)),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Colors.black12,
            ),
            !provider.isLoading
                ? Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: provider.allUsers.length,
                      itemBuilder: (ctx, index) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: CachedNetworkImage(
                            width: 50,
                            height: 50,
                            imageUrl:
                                'https://spiska.pythonanywhere.com/${provider.allUsers[index].img}',
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
                        title: Text(
                          provider.allUsers[index].firstName ?? '...',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        subtitle: Text(
                            provider.allUsers[index].lastName ?? '...',
                            style: Theme.of(context).textTheme.headline5),
                        trailing: IconButton(
                          onPressed: () {
                            dialogAddCustomer(index, context);
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 22,
                          ),
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }

  void dialogAddCustomer(int index, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                'Foydalanuvchini rostan do\'konga qo\'shmoqchimisiz',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.copyWith(color: Colors.black54),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Bekor qilish',
                      style: Theme.of(context).textTheme.headline4,
                    )),
                TextButton(
                    onPressed: () {
                      addCustomerButton(index);
                    },
                    child: Text(
                      'Ha',
                      style: Theme.of(context).textTheme.headline4,
                    ))
              ],
            ));
  }

  void addCustomerButton(index) {
    final provider = Provider.of<ShopInfoVM>(context, listen: false);
    provider.addCustomer(
        shopId: widget.shopId, userId: provider.allUsers[index].id!);
    // provider.getShops(widget.shopId);
    Navigator.pop(context);
  }
}
