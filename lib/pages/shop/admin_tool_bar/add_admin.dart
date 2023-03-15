import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../model/person_model.dart';
import '../../../model/shop_model.dart';
import '../../../view_model/shop_info_and_add_customer_view_model.dart';
class AddAdminPage extends StatefulWidget {
  final Shop shop;
  const AddAdminPage({Key? key, required this.shop}) : super(key: key);
  @override
  State<AddAdminPage> createState() => _AddAdminPageState();
}

class _AddAdminPageState extends State<AddAdminPage> {
  List _adminId = [];

  // @override
  // void initState() {
  //   super.initState();
  //   adminIdList();
  // }

  void adminIdList() {
    for (int i = 0; i < widget.shop.admins!.length; i = 0) {
      _adminId.add(widget.shop.admins?[i].id);
    }
    print("admin id: $_adminId");
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShopInfoVM>(context, listen: true);
    Shop shop = widget.shop;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin qo\'shish',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: provider.admin,
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
                      scrollDirection: Axis.vertical,
                      itemCount: shop.members?.length,
                      itemBuilder: (ctx, index) {
                        List<Person> members = shop.members!
                            .map((e) => Person.fromJson(e))
                            .toList();
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: CachedNetworkImage(
                              width: 50,
                              height: 50,
                              imageUrl:
                                  'https://spiska.pythonanywhere.com/${members[index].img}',
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
                            members[index].firstName ?? '...',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          subtitle: Text(members[index].lastName ?? '...',
                              style: Theme.of(context).textTheme.headline5),
                          trailing: _adminId.contains(members[index].id)
                              ? IconButton(
                                  onPressed: () {
                                    dialogAddAdmin(index, context);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 22,
                                  ),
                                  color: Colors.blue,
                                )
                              : Text(
                                  "Admin",
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                        );
                      },
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

  void dialogAddAdmin(int index, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(
                'Foydalanuvchini rostan do\'konga admin qilmoqchimisiz?',
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
                      addAdminButton(index);
                    },
                    child: Text(
                      'Ha',
                      style: Theme.of(context).textTheme.headline4,
                    ))
              ],
            ));
  }

  void addAdminButton(index) {
    final provider = Provider.of<ShopInfoVM>(context, listen: false);
    provider.addAdmin(
        shopId: widget.shop.id!, userId: widget.shop.members![index].id!);
    // provider.getShops(widget.shop.id);
    Navigator.pop(context);
  }
}
