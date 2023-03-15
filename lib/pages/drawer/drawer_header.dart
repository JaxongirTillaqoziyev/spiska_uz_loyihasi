import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/person_model.dart';
import '../../service/hive_service.dart';
import '../../service/http_service.dart';

class CustomDrawerHeader extends StatelessWidget {
  const CustomDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Person person = HiveDB.loadPerson();
    return DrawerHeader(
        margin: const EdgeInsets.all(0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: person.img == null
                  ? const Icon(
                      Icons.image,
                      color: Colors.white,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        width: 100,
                        height: 100,
                        imageUrl: '${HttpService.baseUrl}${person.img}',
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
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${person.firstName} ${person.lastName}",
                    style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 15),
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${person.phone}',
                    style: Theme.of(context).textTheme.headline4?.copyWith(fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
