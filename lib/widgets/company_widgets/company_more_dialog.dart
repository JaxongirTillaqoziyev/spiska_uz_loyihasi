import 'package:flutter/material.dart';

import '../../model/shop_model.dart';
import '../../pages/shop/admin_tool_bar/add_admin.dart';
import '../../pages/shop/admin_tool_bar/add_customer_toShop.dart';
import '../../pages/shop/admin_tool_bar/promocode.dart';
import '../../pages/shop/shop_tahrir.dart';
import '../warning_dialog.dart';

void dialogCompany(BuildContext context, Shop shop) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            insetPadding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 2.5,
                right: 10,
                top: 10),
            backgroundColor: const Color(0xffE8E8e8),
            actionsPadding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
            actionsOverflowDirection: VerticalDirection.down,
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              adminShopToolBarDialog(
                title: 'Admin qo\'shish',
                func: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => AddAdminPage(shop: shop)));
                },
                icon: Icons.add,
                context,
              ),
              adminShopToolBarDialog(
                title: 'Xaridor qo\'shish',
                func: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => AddCustomerPage(
                                shopId: shop.id!,
                              )));
                },
                icon: Icons.add,
                context,
              ),
              adminShopToolBarDialog(
                title: 'Korxonani tahrirlash',
                func: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => EditPage(
                                shop: shop,
                              )));
                },
                icon: Icons.edit,
                context,
              ),
              adminShopToolBarDialog(
                title: 'Buyurtmalar',
                func: () {},
                icon: Icons.local_atm_sharp,
                context,
              ),
              adminShopToolBarDialog(title: 'Promokod qo\'shish', func: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const PromoCodePage()));
              }, icon: Icons.discount, context),
              adminShopToolBarDialog(
                title: 'Barkodlar tarixi',
                func: () {},
                icon: Icons.local_atm_sharp,
                context,
              ),
              adminShopToolBarDialog(
                title: 'Korxona faol 08.12.2022',
                func: () {},
                context,
              ),
              adminShopToolBarDialog(title: 'Korxonani o\'chirish', func: () {
                warningDialog(context, shop);
              }, icon: Icons.logout, context),
            ],
            alignment: Alignment.topRight,
          ));
}

Widget adminShopToolBarDialog(context,
    {required String title, VoidCallback? func, IconData? icon}) {
  return InkWell(
    onTap: func,
    child: Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(bottom: 6),
      alignment: Alignment.center,
      height: 42,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: icon != null ? Colors.white : Colors.blue),
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: icon == Icons.logout
                  ? Colors.red
                  : Theme.of(context).iconTheme.color,
              size: 18,
            ),
          if (icon != null) const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: icon == Icons.logout
                        ? Colors.red
                        : Theme.of(context).textTheme.headline5?.color,
                  ),
              overflow: TextOverflow.fade,
              softWrap: true,
              maxLines: 2,
            ),
          ),
        ],
      ),
    ),
  );
}
