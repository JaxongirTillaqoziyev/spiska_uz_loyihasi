// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:spiska_uz/model/product_model.dart';
// import 'package:spiska_uz/view_model/modal_sheet_vm.dart';
// import 'package:spiska_uz/widgets/product_image.dart';
//
// import '../pages/shop/product_detail.dart';
//
// class SearchedProduct extends StatelessWidget {
//   final ProductModel product;
//   final List<ProductModel> list;
//   final String currency;
//   const SearchedProduct({Key? key,required this.product,required this.currency,required this.list}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(itemBuilder: (ctx,index){
//       return InkWell(
//         onTap: () {
//           Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                   builder: (ctx) => ProductDetails(
//                     product:product,
//                     products:list,
//                     currency: currency,
//                   )));
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white10,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 alignment: Alignment.bottomCenter,
//                 children: [
//                   ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                         top: Radius.circular(10)),
//                     child: ProductImage(
//                         height: 200,
//                         width: MediaQuery.of(context).size.width / 2,
//                         image:
//                         'https://spiska.pythonanywhere.com/${list[index].images?[0]}'),
//                   ),
//                   Container(
//                     decoration: const BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                             color: Colors.white10,
//                             blurRadius: 5,
//                             spreadRadius: 5),
//                         BoxShadow(
//                             color: Colors.white,
//                             blurRadius: 15,
//                             spreadRadius: 7,
//                             offset: Offset(5.2, 6.2)),
//                         BoxShadow(
//                             color: Colors.white,
//                             blurRadius: 15,
//                             spreadRadius: 7,
//                             offset: Offset(5.2, 6.2))
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             InkWell(
//                                 onTap: () {},
//                                 child: const Icon(Icons.favorite_border)),
//                             Text(
//                               "${list[index].likes?.length.toString()}",
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headline4
//                                   ?.copyWith(color: Colors.red),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                         Text(
//                           '-${list[index].percent}%',
//                           style: Theme.of(context)
//                               .textTheme
//                               .headline4
//                               ?.copyWith(color: Colors.red),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     const Spacer(),
//                     Text(
//                       list[index].name?.toUpperCase() ??
//                           '...',
//                       style: Theme.of(context).textTheme.headline4,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const Spacer(),
//                     Text(
//                       style: Theme.of(context)
//                           .textTheme
//                           .headline4
//                           ?.copyWith(
//                           color: Colors.red,
//                           decoration: TextDecoration.lineThrough),
//                       '${list[index].sellingPrice! + list[index].percent! * list[index].sellingPrice! / 100} $currency',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const Spacer(),
//                     Text(
//                       style: Theme.of(context).textTheme.headline4,
//                       '${list[index].sellingPrice} $currency',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const Spacer(),
//                     InkWell(
//                       onTap: () {
//                         //TODO mahsulotni savatga qoshishda savatga faqat id qashadigan qil keyin id boyicha mahsulotni savatda korsataverasan, 1ta mahsulot 2marta qoshishda ham muammo bolmaydi
//                         // provider1.cartItems.add(SellingItem(
//                         //   img: [...?provider.shopProducts[index].images],
//                         //   name: provider.shopProducts[index].name,
//                         //   price: provider.shopProducts[index].sellingPrice
//                         //       .toString(),
//                         //   proBarcode: '123423232',
//                         //   productId: '',
//                         //   shopId: providerShop.shop?.id.toString(),
//                         //   type: provider.shopProducts[index].type,
//                         //   sum: provider.shopProducts[index].sellingPrice
//                         //       .toString(),
//                         //   amount: '1',
//                         // ));
//                         // setState(() {});
//                         // Utils.showToast('Mahsulot savatga qo\'shildi');
//                       },
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "${widget.shopProducts[index].count} ${widget.shopProducts[index].type}"
//                                 .toString(),
//                             style: Theme.of(context).textTheme.headline5,
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const Icon(
//                             Icons.shopping_cart_outlined,
//                             color: Colors.black,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
