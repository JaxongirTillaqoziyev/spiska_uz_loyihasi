import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/search_view_model.dart';
import '../company/company_client_page.dart';
import '../shop/my_shop_client.dart';
class SearchShop extends StatelessWidget {
  const SearchShop({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchVM>(context, listen: true);
    return ListView.separated(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      itemCount: provider.searchShopList.length,
      itemBuilder: (ctx, index) => InkWell(
        onTap: () {
          if (provider.searchShopList[index].type == '1') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => MyShopClient(
                  shop: provider.searchShopList[index],
                ),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => CompanyClientPage(
                  shop: provider.searchShopList[index],
                ),
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1)),
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      width: 120,
                      height: 120,
                      imageUrl:
                          'https://spiska.pythonanywhere.com/${provider.searchShopList[index].img}',
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            color: Colors.grey[350],
                            strokeWidth: 3,
                          ),
                        );
                      },
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Colors.grey[350],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: SizedBox(
                      height: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(
                            flex: 3,
                          ),
                          Text(
                            provider.searchShopList[index].name!.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(
                            flex: 4,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  infoDialog(
                                      index,
                                      'Jami qarzdorlik',
                                      // 'Qarzdorlik: 20000 so\'m',
                                      Column(
                                        children: [
                                          dialogActions(context, Colors.red,
                                              'Qarzdorlik: 20000 so\'m'),
                                          dialogActions(context, Colors.green,
                                              'Qarzdorlik: Qarzdorlik dollarda mavjud emas!'),
                                        ],
                                      ),
                                      context);
                                },
                                child: textWithBorder(
                                    'Balans', Colors.blue, context),
                              ),
                              InkWell(
                                onTap: () {
                                  infoDialog(
                                      index,
                                      'Jami bonus: 999-o\'rin',
                                      // '30000 so\'m',
                                      dialogActions(context, Colors.green,
                                          'Miqdori: 999 999'),
                                      context);
                                },
                                child: textWithBorder(
                                    'Bonus', Colors.green, context),
                              ),
                            ],
                          ),
                          const Spacer()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (provider.searchShopList[index].type == '0')
                Text(
                  "Korxona",
                  style: Theme.of(context).textTheme.headline5,
                ),
              if (provider.searchShopList[index].type == '1')
                Text("Do'kon", style: Theme.of(context).textTheme.headline5),
            ],
          ),
        ),
      ),
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 5);
      },
    );
  }

  void infoDialog(
      int index, String title, Widget actions, BuildContext context) {
    final provider = Provider.of<SearchVM>(context, listen: true);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: const EdgeInsets.only(left: 10, top: 10),
        contentPadding: EdgeInsets.zero,
        title: Text(
          provider.searchShopList[index].name!.toUpperCase(),
          style: Theme.of(context).textTheme.headline4,
        ),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 10),
            actions,
          ],
        ),
      ),
    );
  }

  Widget dialogActions(BuildContext context, Color color, String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: color, width: 2)),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline5?.copyWith(color: color),
      ),
    );
  }
  Widget textWithBorder(String label, Color textColor, BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width / 4,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .headline5
            ?.copyWith(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
