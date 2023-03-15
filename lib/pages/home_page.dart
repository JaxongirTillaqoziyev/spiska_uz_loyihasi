import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spiska_uz_loyihasi/pages/search_page/search_page.dart';
import 'package:spiska_uz_loyihasi/pages/tabBarView1.dart';
import 'package:spiska_uz_loyihasi/pages/tabBarView2.dart';
import 'package:spiska_uz_loyihasi/pages/tabBarView3.dart';
import '../service/hive_service.dart';
import 'cart_ui.dart';
import 'drawer/drawer_page.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          actionsIconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const SearchPage()));
                },
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => MyCart(
                            id: '1',
                          )));
                },
                icon: const Icon(Icons.shopping_cart)),
          ],
          title: InkWell(
            onTap: () {
              print(HiveDB.loadPerson().id);
            },
            child: Text(
              'Online',
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.copyWith(  fontSize: 13,color: Colors.white),
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'mainScreen',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(
                      fontSize: 13,
                      color: Colors.white),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ).tr(),
              ),
              Tab(
                child: Text(
                  'Do\'konlar',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(
                      fontSize: 13,
                      color: Colors.white),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  'Mahsulotlar',
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(color: Colors.white,
                    fontSize: 13
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        drawer: const MyDrawer(),
        body: const TabBarView(
          children: [
            TabBar1(),
            TabBar2(),
            TabBar3(),
          ],
        ),
      ),
    );
  }
}
