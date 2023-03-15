import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spiska_uz_loyihasi/widgets/product_image.dart';
import '../core/apis.dart';
import '../model/product_model.dart';
import '../pages/shop/product_detail.dart';
import '../view_model/shop/shop_page_tools_view_model.dart';
class CustomGridView extends StatefulWidget {
  final List<ProductModel> shopProducts;
  final VoidCallback likeButton;
  final VoidCallback addCart;
  final String currency;
  const CustomGridView(
      {Key? key,
      required this.shopProducts,
      required this.addCart,
      required this.likeButton,
      required this.currency})
      : super(key: key);

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShopToolsPageVM>(context, listen: true);
    // final providerShop = Provider.of<GetShopVM>(context, listen: true);
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2),
        itemCount: widget.shopProducts.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ProductDetails(
                            product: widget.shopProducts[index],
                            products: widget.shopProducts,
                            currency: widget.currency,
                          )));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: ProductImage(
                            height: 200,
                            width: MediaQuery.of(context).size.width / 2,
                            image:
                                '${ApiUrl.baseUrl}${widget.shopProducts[index].images?[0]}'),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white10,
                                blurRadius: 5,
                                spreadRadius: 5),
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 15,
                                spreadRadius: 7,
                                offset: Offset(5.2, 6.2)),
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 15,
                                spreadRadius: 7,
                                offset: Offset(5.2, 6.2))
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                    onTap: () {},
                                    child: provider.isLiked
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : const Icon(Icons.favorite_border)),
                                Text(
                                  "${widget.shopProducts[index].likes?.length.toString()}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      ?.copyWith(color: Colors.red),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                            Text(
                              '-${widget.shopProducts[index].percent}%',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Spacer(),
                        Text(
                          widget.shopProducts[index].name?.toUpperCase() ??
                              '...',
                          style: Theme.of(context).textTheme.headline4,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          style: Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough),
                          '${widget.shopProducts[index].sellingPrice! + widget.shopProducts[index].percent! * widget.shopProducts[index].sellingPrice! / 100} ${widget.currency}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        Text(
                          style: Theme.of(context).textTheme.headline4,
                          '${widget.shopProducts[index].sellingPrice} ${widget.currency}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            //TODO mahsulotni savatga qoshishda savatga faqat id qashadigan qil keyin id boyicha mahsulotni savatda korsataverasan, 1ta mahsulot 2marta qoshishda ham muammo bolmaydi
                            // provider1.cartItems.add(SellingItem(
                            //   img: [...?provider.shopProducts[index].images],
                            //   name: provider.shopProducts[index].name,
                            //   price: provider.shopProducts[index].sellingPrice
                            //       .toString(),
                            //   proBarcode: '123423232',
                            //   productId: '',
                            //   shopId: providerShop.shop?.id.toString(),
                            //   type: provider.shopProducts[index].type,
                            //   sum: provider.shopProducts[index].sellingPrice
                            //       .toString(),
                            //   amount: '1',
                            // ));
                            // setState(() {});
                            // Utils.showToast('Mahsulot savatga qo\'shildi');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.shopProducts[index].count} ${widget.shopProducts[index].type}"
                                    .toString(),
                                style: Theme.of(context).textTheme.headline5,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Icon(
                                Icons.shopping_cart_outlined,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
