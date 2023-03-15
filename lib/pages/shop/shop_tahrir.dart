import 'package:flutter/material.dart';

import '../../model/shop_model.dart';

class EditPage extends StatefulWidget {
  final Shop shop;
  const EditPage({Key? key, required this.shop}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tahrirlash',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: const [],
      ),
    );
  }
}
