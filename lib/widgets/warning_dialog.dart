import 'package:flutter/material.dart';

import '../core/core_widgets.dart';
import '../model/shop_model.dart';

void warningDialog1(
  BuildContext context,
  VoidCallback onPressed,
) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: const Text(
              "Rostan mahsulotni o'chirib yubormoqchimisiz?",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Bekor qilish",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  )),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: onPressed,
                  child: const Text(
                    "Ok",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ))
            ],
          ));
}

void warningDialog(context, Shop shop) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(
        'Siz rostan ham do\'konni o\'chirmoqchimisiz?',
        style: Theme.of(context).textTheme.headline4,
      ),
      actions: [
        TextButton(
          onPressed: () {
            deleteShop(shop.id.toString(), context);
          },
          child: Text(
            'Ha',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Yo\'q',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ],
    ),
  );
}
