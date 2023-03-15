import 'dart:io';
import 'package:flutter/material.dart';
class PickImageTile extends StatelessWidget {
  String title;
  VoidCallback onPressed;
  File? image;
  PickImageTile(
      {Key? key,
      required this.onPressed,
      required this.title,
      required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xff2084E9), width: 1),
                  borderRadius: BorderRadius.circular(20)),
              child: image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        image!,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.image_outlined)),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        )
      ],
    );
  }
}
