import 'package:flutter/material.dart';

class ShopProductSearch extends StatefulWidget {
  const ShopProductSearch({Key? key}) : super(key: key);

  @override
  State<ShopProductSearch> createState() => _ShopProductSearchState();
}

class _ShopProductSearchState extends State<ShopProductSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          decoration: InputDecoration(
              hintText: "Mahsulot qidirish",
              hintStyle: Theme.of(context).textTheme.headline5),
        ),
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
          ),
          itemBuilder: (ctx, index) {
            return Container();
          }),
    );
  }
}
