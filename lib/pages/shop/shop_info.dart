import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:map_launcher/map_launcher.dart';
import '../../core/core_widgets.dart';
import '../../model/shop_model.dart';
import '../../widgets/shop_widgets/shop_more_dialog.dart';
import 'admin_tool_bar/add_customer_toShop.dart';

class ShopInfo extends StatefulWidget {
  final Shop shop;

  const ShopInfo({Key? key, required this.shop}) : super(key: key);

  @override
  State<ShopInfo> createState() => _ShopInfoState();
}

class _ShopInfoState extends State<ShopInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Shop shop = widget.shop;
    return Scaffold(
      backgroundColor: const Color(0xffE2E2E2),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            overflow: TextOverflow.ellipsis),
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        title: InkWell(
          onTap: () {
            // if (person.id == shop.host?['id']) {

            // } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return FullScreenImage(
                    imageUrl: 'https://spiska.pythonanywhere.com/${shop.img}',
                    tag: "generate_a_unique_tag",
                  );
                },
              ),
            );
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Hero(
                  tag: 'image1',
                  child: CachedNetworkImage(
                    width: 50,
                    height: 50,
                    imageUrl: 'https://spiska.pythonanywhere.com/${shop.img}',
                    fit: BoxFit.cover,
                    progressIndicatorBuilder: (context, url, downloadProgress) {
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
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  shop.name!.toUpperCase(),
                  style: const TextStyle(overflow: TextOverflow.clip),
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          ElevatedButton(
              onPressed: () {
                dialogShop(context, shop);
              },
              child: Image.asset(
                'assets/images/filter.png',
                height: 22,
                width: 22,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                tileColor: const Color(0xffffffff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => AddCustomerPage(
                                  shopId: shop.id!,
                                )));
                  },
                  icon: const Icon(
                    Icons.person_add_alt_1_outlined,
                    color: Colors.blue,
                  ),
                ),
                title: Text(
                  "Haridor qo'shish",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.blue),
                ),
                subtitle: Text(
                  '16ta xaridor mavjud',
                  style: Theme.of(context).textTheme.headline6,
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: shop.members?.length,
                  itemBuilder: (ctx, index) {
                    var user = shop.members?[index];
                    return Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: tileWidget(
                          shop.members?[index].firstName ?? '...',
                          (shop.admins!.contains(user))
                              ? 'Admin'
                              : "Foydalanuvchi",
                          shop.members![index].img!),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  openMapsSheet(context) async {
    Shop shop = widget.shop;
    try {
      String? title = shop.name;
      String? description = shop.description;
      final coords = Coords(double.parse(shop.location!['lat']),
          double.parse(shop.location!['lon']));
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 10),
                    child: Text('Open with',
                        style: TextStyle(fontSize: 25, color: Colors.black)),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    alignment: Alignment.center,
                    child: Wrap(
                      children: <Widget>[
                        for (var map in availableMaps)
                          Container(
                            height: 70,
                            alignment: Alignment.center,
                            child: ListTile(
                              onTap: () => map.showMarker(
                                  coords: coords,
                                  title: title!,
                                  description: description!),
                              title: Text(
                                map.mapName,
                                style: const TextStyle(
                                    fontSize: 19, color: Colors.black),
                              ),
                              leading: SvgPicture.asset(
                                map.icon,
                                height: 40.0,
                                width: 40.0,
                              ),
                            ),
                          ),
                        const Divider(
                          height: 0.5,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Widget tileWidget(String title1, String subTitle1, String image,
      {IconData? icon, void fnk}) {
    return ListTile(
      tileColor: Colors.white,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: CachedNetworkImage(
          width: 50,
          height: 50,
          imageUrl: 'https://spiska.pythonanywhere.com/$image',
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) {
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
      title: Text(
        title1,
        style: Theme.of(context).textTheme.headline4,
      ),
      subtitle: Text(
        subTitle1,
        style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 15),
      ),
      trailing: IconButton(
        onPressed: () {
          fnk;
        },
        icon: Icon(icon),
      ),
    );
  }
}
