import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../core/apis.dart';
import '../../core/core_widgets.dart';
import '../../model/product_model.dart';
import '../../service/utils.dart';
import '../../view_model/cart_view_model.dart';
import '../../widgets/custom_gridview.dart';

class ProductDetails extends StatefulWidget {
  final ProductModel product;
  final List<ProductModel> products;
  final String currency;

  const ProductDetails(
      {Key? key,
      required this.product,
      required this.products,
      required this.currency})
      : super(key: key);

  @override
  State<ProductDetails> createState() => _ShopProductsState();
}

class _ShopProductsState extends State<ProductDetails> {
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CartVM>(context, listen: false);
  }

  final List<String> _images = [];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartVM>(context, listen: true);
    var formatter = NumberFormat('###,###,###,##0.000');
    _images.clear();
    for (int i = 0; i < widget.product.images!.length; i++) {
      if (widget.product.images![i] != "") {
        _images.add(widget.product.images![i]);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.product.name?.toUpperCase()}",
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                  itemCount: _images.length,
                  options: CarouselOptions(
                    autoPlay: true,
                    autoPlayAnimationDuration: const Duration(seconds: 2),
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    initialPage: 2,
                  ),
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return InkWell(
                      onTap: () {
                        _showImage(context, itemIndex);
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              width: MediaQuery.of(context).size.width,
                              imageUrl:
                                  "${ApiUrl.baseUrl}${_images[itemIndex]}",
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Text(
                              '${widget.product.percent} %',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    backgroundColor: Colors.yellow,
                                  ),
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
              Text(
                widget.product.name ?? '...',
                style: Theme.of(context).textTheme.headline4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Eski Narxi: ${widget.product.sellingPrice! + widget.product.percent! * widget.product.sellingPrice! / 100} ${widget.currency}',
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.red),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      '-${widget.product.percent}%',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  const Spacer(flex: 3),
                ],
              ),
              Text(
                'Narxi: ${widget.product.sellingPrice.toString()} ${widget.currency}',
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 10),
              Text(
                'Barkodi: ${widget.product.barcode.toString()}',
                style: Theme.of(context).textTheme.headline5,
              ),
              const SizedBox(height: 5),
              PriceWidget(isCart: false),
              Container(
                height: 40,
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                color: Colors.grey.shade300,
                child: Text(
                  'Jami: UZS ${formatter.format(provider.summa)}',
                  style: const TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
              const Divider(
                color: Colors.grey,
                height: 20,
                thickness: 2,
                endIndent: 20,
                indent: 20,
              ),
              CustomGridView(
                currency: widget.currency,
                shopProducts: widget.products,
                likeButton: () {},
                addCart: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showImage(BuildContext context, index) {
    final provider = Provider.of<CartVM>(context, listen: true);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: CarouselSlider.builder(
                itemCount: widget.product.images?.length,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.width / 1.2,
                  autoPlay: false,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  enlargeCenterPage: true,
                  viewportFraction: 0.9,
                  initialPage: 2,
                ),
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: InteractiveViewer(
                      panEnabled: false,
                      // Set it to false to prevent panning.
                      boundaryMargin: const EdgeInsets.all(50),
                      minScale: 1,
                      maxScale: 4,
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        imageUrl: widget.product.images![itemIndex],
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  void modalSheet1() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white,
              child: Wrap(
                direction: Axis.vertical,
                children: [
                  const Text(
                    'Shikoyat qilish',
                    style: TextStyle(fontSize: 22, color: Colors.red),
                  ),
                  const SizedBox(height: 10),
                  modalText('Spam'),
                  modalText('Giyohvand moddalar'),
                  modalText('Shaxsiy ma’lumotlar '),
                  modalText('Pornografiya'),
                  modalText('Zo’ravonlik'),
                  modalText('Bolalar pornografiyasi'),
                  modalText('Boshqa'),
                ],
              ),
            ));
  }

  Widget modalText(String title) {
    return InkWell(
      onTap: () {
        debugPrint('modal sheet');
        reportApi(title).then((value) => {
              debugPrint(value.toString()),
              if (value == 200)
                {
                  Navigator.pop(context),
                }
            });
      },
      child: Card(
        elevation: 2,
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Colors.black),
          ),
        ),
      ),
    );
  }

  Future reportApi(String title) async {
    try {
      Uri url = Uri.parse('https://spiska.pythonanywhere.com/api/report/');
      var res = await http.post(url,
          body: {'type': title, 'product_id': widget.product.id.toString()});
      debugPrint(res.statusCode.toString());
      if (res.statusCode == 200) {
        Utils.showToast('Shikoyatiz adminlarga yetkazildi!');
        return 200;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
