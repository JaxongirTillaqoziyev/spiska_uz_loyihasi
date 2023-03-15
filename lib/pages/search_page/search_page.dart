import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spiska_uz_loyihasi/pages/search_page/search_tab1.dart';
import 'package:spiska_uz_loyihasi/pages/search_page/search_tab2.dart';

import '../../view_model/search_view_model.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  @override
  State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<SearchVM>(context, listen: false);
    setState(() {
      provider.searchProduct();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchVM>(context, listen: true);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: provider.scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: SizedBox(
            height: 45,
            child: TextFormField(
              controller: provider.controller,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(15, 10, 0, 10),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Siz nima izlayapsiz?',
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 25,
                    color: Colors.black87,
                  )),
              onChanged: (input) {
                if (provider.tabIndex == 0) {
                  provider.searchProduct(
                      searchWord: provider.controller.text.trim());
                } else {
                  provider.searchShop(
                      searchWord: provider.controller.text.trim());
                }
              },
            ),
          ),
          bottom: TabBar(
              onTap: (index) {
                setState(() {
                  provider.tabIndex = index;
                });
              },
              tabs: const [
                Tab(
                  child: Text('Mahsulotlar'),
                ),
                Tab(
                  child: Text('Do\'konlar'),
                )
              ]),
        ),
        body: const TabBarView(
          children: [
            SearchProduct(),
            SearchShop(),
          ],
        ),
      ),
    );
  }
}
