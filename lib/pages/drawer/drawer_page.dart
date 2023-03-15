import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import '../../service/hive_service.dart';
import '../../service/utils.dart';
import '../../view_model/drawer_view_model.dart';
import '../../view_model/main_tabbar_vm/tab1_view_model.dart';
import '../company/company_admin_page.dart';
import '../shop/myshop_admin.dart';
import 'drawer_category_pages/settings/settings.dart';
import 'drawer_header.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  void initState() {
    if (HiveDB.boxBonus.isEmpty) {
      HiveDB.storeIsGet();
      print('object');
    }
    super.initState();
    Future.delayed(Duration.zero).then((value) => {getShopLists()});
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DrawerViewModal>(context, listen: true);
    return Drawer(
      child: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            const CustomDrawerHeader(),
            drawerCategory(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/diamond.png',
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${HiveDB.loadPerson().diamond}',
                    style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 13),
                  ),
                ],
              ),
              context,
              onTap: () {},
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            drawerCategory(
              context,
              title: const Text(
                "sozlamalar",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ).tr(),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AppSettings()));
              },
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            drawerCategory(
              context,
              title: const Text(
                "openShop",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ).tr(),
              onTap: () {
                provider.dialogCheckShop(context);
              },
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            drawerCategory(
              context,
              title: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(
                      Icons.telegram,
                      color: Colors.blue,
                      size: 35,
                    ),
                  ),
                  Text(
                    "Qo'llab quvvatlash",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              onTap: () {
                provider.getSupport();
                },
            ),
            const Divider(
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(height: 0),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                itemCount: provider.drawerPageShops.length,
                itemBuilder: (ctx, index) => ListTile(
                  contentPadding: const EdgeInsets.all(1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      )),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      width: 60,
                      height: 80,
                      imageUrl:
                          'https://spiska.pythonanywhere.com/${provider.drawerPageShops[index].img}',
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
                  textColor: Colors.black,
                  onTap: () {
                    if (provider.drawerPageShops[index].type == "1") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => MyShopAdmin(
                                    shop: provider.drawerPageShops[index],
                                  )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => CompanyAdminPage(
                                    shop: provider.drawerPageShops[index],
                                  )));
                    }
                  },
                  title: Container(
                      height: 20,
                      width: 200,
                      child: Marquee(
                          blankSpace: 15,
                          velocity: 3,
                          text: '${provider.drawerPageShops[index].name}')),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (provider.drawerPageShops[index].type == '2')
                        const Text("Korxona"),
                      if (provider.drawerPageShops[index].type == '1')
                        const Text("Do'kon"),
                      Container(
                          decoration: BoxDecoration(
                              color: Colors.lightGreenAccent,
                              borderRadius: BorderRadius.circular(30.0)),
                          width: 50,
                          height: 30,
                          child:const Center(
                              child: const Text(
                                "200",
                                style: TextStyle(fontSize: 13, color: Colors.red),
                              ))),
                    ],
                  ),
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 5);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget drawerCategory(
    BuildContext context, {
    VoidCallback? onTap,
    Widget? title,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          constraints: const BoxConstraints(minHeight: 50, maxHeight: 55),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: title),
    );
  }

  getShopLists() {
    final provider = Provider.of<DrawerViewModal>(context, listen: false);
    setState(() {
      provider.drawerPageShops = [...context.read<TabBar1VM>().adminShop];
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
