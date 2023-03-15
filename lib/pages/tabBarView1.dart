import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spiska_uz_loyihasi/pages/shop/my_shop_client.dart';
import '../service/api_response.dart';
import '../view_model/main_tabbar_vm/tab1_view_model.dart';
import 'company/company_client_page.dart';
class TabBar1 extends StatefulWidget {
  const TabBar1({Key? key}) : super(key: key);
  @override
  State<TabBar1> createState() => _TabBar1State();
}
class _TabBar1State extends State<TabBar1> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<TabBar1VM>(context, listen: false);
    provider.getApiResponse(context);
    Future.delayed(Duration.zero).then((value) => {
          provider.getShopAsUser(),
          provider.getShopAsAdmin(),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TabBar1VM>(builder: (context, data, child) {
      if (data.responseAsUser.status == Status.HAVE) {
        debugPrint("have");
        return Padding(
            padding: const EdgeInsets.only(top: 1.0),
            child: ListView.separated(
              itemCount: data.responseAsUser.data.length,
              itemBuilder: (ctx, index) => InkWell(
                onTap: () {
                  if (data.userShop[index].type == '1') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => MyShopClient(
                          shop: data.userShop[index],
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => CompanyClientPage(
                          shop: data.userShop[index],
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.black, width: 0.5)),
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                  'https://spiska.pythonanywhere.com/${data.responseAsUser.data[index].img}',
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
                          const SizedBox(width: 5),
                          Expanded(
                            child: SizedBox(
                              height: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Spacer(
                                    flex: 3,
                                  ),
                                  Container(
                                    height: 20,
                                    width: 250,
                                    child: Marquee(
                                      blankSpace: 10,
                                      velocity: 1,
                                      text:
                                        data.responseAsUser.data[index].name!
                                            .toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3
                                            ?.copyWith(
                                            fontSize: 13,

                                            fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  const Spacer(
                                    flex: 4,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          infoDialog(
                                              index,
                                              'Jami qarzdorlik',
                                              // 'Qarzdorlik: 20000 so\'m',
                                              Column(
                                                children: [
                                                  dialogActions(
                                                      context,
                                                      Colors.red,
                                                      'Qarzdorlik: 20000 so\'m'),
                                                  dialogActions(
                                                      context,
                                                      Colors.green,
                                                      'Qarzdorlik: Qarzdorlik dollarda mavjud emas!'),
                                                ],
                                              ));
                                        },
                                        child: textWithBorder(
                                            'Balans', Colors.blue),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          infoDialog(
                                            index,
                                            'Jami bonus: 999-o\'rin',
                                            // '30000 so\'m',
                                            dialogActions(context, Colors.green,
                                                'Miqdori: 999 999'),
                                          );
                                        },
                                        child: textWithBorder(
                                            'Bonus', Colors.green),
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
                      if (data.responseAsUser.data[index].type == '2')
                        Text(
                          "Korxona",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      if (data.responseAsUser.data[index].type == '1')
                        Text("Do'kon",
                            style: Theme.of(context).textTheme.headline5),
                    ],
                  ),
                ),
              ),
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 5);
              },
            ));
      } else if (data.responseAsUser.status == Status.HAVENOT) {
        debugPrint("not have");
        return Center(
          child: Shimmer.fromColors(
            highlightColor: Colors.green,
            baseColor: Colors.redAccent,
            child: Text(
              'Siz hali do\'konlarga a\'zo emassiz!',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        );
      } else if (data.responseAsUser.status == Status.ERROR) {
        debugPrint("error");
        return Center(
          child: Shimmer.fromColors(
            highlightColor: Colors.green,
            baseColor: Colors.redAccent,
            child: Text(
              data.responseAsUser.message ?? '',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        );
      } else {
        debugPrint("loading");
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
  Widget textWithBorder(String label, Color textColor) {
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

  void infoDialog(int index, String title, Widget actions) {
    final provider = Provider.of<TabBar1VM>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        titlePadding: const EdgeInsets.only(left: 10, top: 10),
        contentPadding: EdgeInsets.zero,
        title: Text(
          provider.userShop[index].name!.toUpperCase(),
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
}
