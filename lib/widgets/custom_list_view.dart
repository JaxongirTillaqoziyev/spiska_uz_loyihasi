import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../model/product_model.dart';
class CustomListView extends StatelessWidget {
  final List<ProductModel> shopProducts;
  final String currency;
  CustomListView({Key? key, required this.shopProducts, required this.currency})
      : super(key: key);
  final ScrollController scrollCtrl = ScrollController();
  final List<String?> itemUnit = ['Kg', 'Kona', 'Litr', 'm²', 'Metr', 'm³'];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: scrollCtrl,
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: shopProducts.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey, width: 1)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      height: 120,
                      width: 120,
                      imageUrl:
                          'https://spiska.pythonanywhere.com/${shopProducts[index].images?.first}',
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text:
                                    '${shopProducts[index].name}'.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              )
                            ]),
                            maxLines: 1,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'O\'z.q.narx: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(fontSize: 20)),
                              TextSpan(
                                text: '${shopProducts[index].price} $currency',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                      fontWeight: FontWeight.normal,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              )
                            ]),
                            maxLines: 1,
                          ),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Sotish narxi: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(
                                          fontSize: 20, color: Colors.blue)),
                              TextSpan(
                                text:
                                    '${shopProducts[index].sellingPrice} $currency',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                        fontWeight: FontWeight.normal,
                                        overflow: TextOverflow.ellipsis,
                                        color: Colors.blue),
                              )
                            ]),
                            maxLines: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Jami: ',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            ?.copyWith(fontSize: 20)),
                                    TextSpan(
                                      text: '${shopProducts[index].count}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.copyWith(
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' ${itemUnit[int.parse(shopProducts[index].type.toString())]}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          ?.copyWith(
                                            fontWeight: FontWeight.normal,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    )
                                  ],
                                ),
                                maxLines: 1,
                              ),
                              Text(
                                '1-kategoriya',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
