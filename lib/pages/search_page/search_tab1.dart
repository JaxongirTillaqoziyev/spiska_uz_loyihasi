import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/search_view_model.dart';
import '../shop/my_shop_client.dart';
class SearchProduct extends StatelessWidget {
  const SearchProduct({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchVM>(context, listen: true);
    return GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
        ),
        itemCount: provider.searchProductList.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              enterShop(index, context);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    height: 180,
                    width: MediaQuery.of(context).size.width / 2,
                    imageUrl:
                        'https://spiska.pythonanywhere.com/${provider.searchProductList[index].images?.first}',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          '${provider.searchProductList[index].name}',
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )),
                    ],
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${provider.searchProductList[index].sellingPrice}',
                          style: Theme.of(context).textTheme.headline5,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Icon(Icons.shopping_cart),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void enterShop(int index, context) {
    final provider = Provider.of<SearchVM>(context, listen: false);
    provider
        .getShop(provider.searchProductList[index].shopId!)
        .then((value) => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => MyShopClient(
                            shop: value,
                          )))
            });
  }
}
