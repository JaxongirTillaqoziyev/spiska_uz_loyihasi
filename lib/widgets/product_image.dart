import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
class ProductImage extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  const ProductImage({
    Key? key,
    required this.image,
    required this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: image,
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
    );
  }
}
