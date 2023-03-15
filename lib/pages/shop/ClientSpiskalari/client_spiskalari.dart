import 'package:flutter/material.dart';
import '../../../service/utils.dart';
import 'client_tanlangan_spiskalar.dart';
import 'client_tasdiqlangan_spiskalar.dart';
class Client_spisklari extends StatefulWidget {
  const Client_spisklari({Key? key}) : super(key: key);
  @override
  State<Client_spisklari> createState() => _Client_spisklariState();
}

class _Client_spisklariState extends State<Client_spisklari> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Client  Spiskasi"),
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
          children: [Client_Tanlangan_Spisklar(), Client_Tasdiqlangan_Spiskalar()],
        ),
      ),
    );
  }
}

