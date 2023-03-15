import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:spiska_uz_loyihasi/pages/shop/my_shop_client.dart';
import '../model/person_model.dart';
import '../service/api_response.dart';
import '../service/hive_service.dart';
import '../view_model/main_tabbar_vm/tab2_view_model.dart';
class TabBar2 extends StatefulWidget {
  const TabBar2({Key? key}) : super(key: key);

  @override
  State<TabBar2> createState() => _TabBar2State();
}

class _TabBar2State extends State<TabBar2> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<Tab2VM>(context, listen: false);
    Future.delayed(Duration.zero).then((value) => {
          provider.getNearShops(),
        });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Tab2VM>(context, listen: true);
    final numFormat = NumberFormat("###,###,###,##0.0");
    Person person = HiveDB.loadPerson();
    return Container(
      padding: const EdgeInsets.only(left: 1, right: 1),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<Tab2VM>(builder: (context, data, child) {
              if (data.apiResponse.status == Status.HAVE) {
                return ListView.separated(
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: provider.nearShops.length,
                  itemBuilder: (ctx, index) {
                    print(provider.nearShops[index].distance);
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => MyShopClient(
                                      shop: provider.nearShops[index],
                                    )));
                      },
                      child: Container(
                        height: 120,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    width: 120,
                                    height: 120,
                                    imageUrl:
                                        'https://spiska.pythonanywhere.com/${provider.nearShops[index].img}',
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      child: Container(
                                        height: 30,
                                        width: 250,
                                        child: Marquee(
                                          velocity: 5,
                                          blankSpace: 50,
                                          text:
                                            provider.nearShops[index].name ?? '..',
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                      ),
                                      ),

                                    const SizedBox(height: 15),
                                    if (provider.nearShops[index].distance !=
                                        null)
                                      Text(
                                        provider.nearShops[index].distance! < 1
                                            ? '${numFormat.format(provider.nearShops[index].distance! * 1000)} metr'
                                            : '${numFormat.format(provider.nearShops[index].distance)} km',
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            overflow: TextOverflow.clip),
                                      )
                                  ],
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  provider.nearShops[index].type == "1"
                                      ? "Do\'kon"
                                      : "Korxona",
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      overflow: TextOverflow.clip),
                                ),
                                if (((provider.nearShops[index].members as List)
                                        .map((e) => Person.fromJson(e)))
                                    .toList()
                                    .contains(person))
                                  Image.asset(
                                    "assets/images/member_icon.png",
                                    height: 30,
                                    width: 30,
                                    alignment: Alignment.bottomRight,
                                  )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                );
              } else if (data.apiResponse.status == Status.HAVENOT) {
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
              } else if (data.apiResponse.status == Status.ERROR) {
                return Center(
                  child: Shimmer.fromColors(
                    highlightColor: Colors.green,
                    baseColor: Colors.redAccent,
                    child: Text(
                      data.apiResponse.message ?? '',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
