import 'package:flutter/material.dart';
import 'package:spiska_uz_loyihasi/pages/shop/AdminSpiskalari/tanlangan_spiskalar.dart';
import 'package:spiska_uz_loyihasi/pages/shop/AdminSpiskalari/tasdiqlangan_spiskalar.dart';
import '../../../service/utils.dart';
class Admin_Spiskalari extends StatefulWidget {
  const Admin_Spiskalari({Key? key}) : super(key: key);
  @override
  State<Admin_Spiskalari> createState() => _Admin_SpiskalariState();
}
class _Admin_SpiskalariState extends State<Admin_Spiskalari> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Admin  Spiskalari"),
          actions: [
            InkWell(
                onTap: () {
                  Utils.showToast(
                      "Keraksiz spiskani o'chiramiz dialog ochilib so'rasin");
                },
                child: Icon(Icons.delete)),
            InkWell(
                onTap: () {
                  Utils.showToast("Nimadir bor bilamdim");
                },
                child: Icon(Icons.account_balance)),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Tanlanganlar',
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
                  'Tasdiqlanganlar',
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
            ],
          ),
        ),
        body: const TabBarView(
          children: [Tanlangan_Spiskalar(), Tasdiqlangan_Spiskalar()],
        ),
      ),
    );
  }
}
////////
/*

 appBar: AppBar(title: Text("Admin  Spiskalari"),
      actions: [
        InkWell(
            onTap: (){
              Utils.showToast("Keraksiz spiskani o'chiramiz dialog ochilib so'rasin");
            },
            child: Icon(Icons.delete)),
        InkWell(
            onTap: (){
              Utils.showToast("Nimadir bor bilamdim");
            },
            child: Icon(Icons.account_balance)),

      ],
      ),

 */
