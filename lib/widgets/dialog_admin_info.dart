import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/utils.dart';
import '../view_model/shop/get_shop_by_id.dart';
void dialogAdminInfo(BuildContext context, String title, String type) {
  final providerShop = Provider.of<GetShopVM>(context, listen: false);
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
            title: Text(
              title,
              style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 13),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.width * 0.5,
              child: ListView.builder(
                  itemCount: providerShop.shop?.admins?.length,
                  itemBuilder: (ctx, index) => ListTile(
                        onTap: () {
                          Utils.jumpedUrl(
                              "$type${providerShop.shop?.admins?[index]['phone']}");
                        },
                        leading: Icon(Icons.phone,size: 40,color: Colors.blue,),
                        title: Text(
                          "${index + 1}.${providerShop.shop?.admins?[index]['first_name']} ${providerShop.shop?.admins?[index]['last_name']}",
                          style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 13),
                        ),
                        subtitle: Text(
                          '${providerShop.shop?.admins?[index]["phone"]}',
                          style: Theme.of(context).textTheme.headline5?.copyWith(fontSize: 13),
                        ),
                      )),
            ),
          ));
}
