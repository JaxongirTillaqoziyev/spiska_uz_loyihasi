import 'package:flutter/material.dart';
import '../../model/outcome_model.dart';
import '../../model/shop_model.dart';
import '../../pages/shop/admin_tool_bar/add_admin.dart';
import '../../pages/shop/admin_tool_bar/add_customer_toShop.dart';
import '../../pages/shop/admin_tool_bar/income.dart';
import '../../pages/shop/admin_tool_bar/outcome.dart';
import '../../pages/shop/admin_tool_bar/promocode.dart';
import '../warning_dialog.dart';
void dialogShop(BuildContext context, Shop shop) {
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
                title: 'Admin qo\'shish ',
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
                  title: 'Do\'kon nomiga sotib olish',
                  func: () {},
                  icon: Icons.monetization_on_sharp,
                  context),
              adminShopToolBarDialog(
                  title: 'Do\'konni Tahrirlash',
                  func: () {},
                  icon: Icons.edit,
                  context),
              adminShopToolBarDialog(title: 'Chiqim', func: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => OutcomePage(
                              outcomes: (shop.output as List)
                                  .map((e) => OutcomeModel.fromJson(e))
                                  .toList(),
                              currency: shop.currency.toString(),
                            )));
              }, icon: Icons.money_off_csred_outlined, context),
              adminShopToolBarDialog(title: 'Kirim', func: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const IncomePage()));
              }, context, icon: Icons.monetization_on),
              adminShopToolBarDialog(title: 'Promokod qo\'shish', func: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const PromoCodePage()));
              }, icon: Icons.discount, context),
              adminShopToolBarDialog(
                title: 'Bonus berish',
                func: () {},
                icon: Icons.local_atm_sharp,
                context,
              ),
              adminShopToolBarDialog(
                title: 'Naqd pul miqdori',
                func: () {},
                icon: Icons.local_atm_sharp,
                context,
              ),
              adminShopToolBarDialog(
                title: 'Do\'kon faol 08.12.2022',
                func: () {},
                context,
              ),
              adminShopToolBarDialog(title: 'Do\'konni o\'chirish', func: () {
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
