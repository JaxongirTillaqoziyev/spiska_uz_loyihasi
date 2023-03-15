import 'package:flutter/material.dart';

import 'adding_promocode.dart';

class PromoCodePage extends StatefulWidget {
  const PromoCodePage({Key? key}) : super(key: key);

  @override
  State<PromoCodePage> createState() => _PromoCodePageState();
}

class _PromoCodePageState extends State<PromoCodePage> {
  List proms = [1, 2, 3, 4];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Promokodlar ro\'yhati'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => AddingPromocode()));
                  },
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      maximumSize: const Size(100, 80),
                      minimumSize: const Size(50, 50)),
                  child: const Icon(Icons.add),
                ),
                const SizedBox(width: 10),
                Text(
                  'Promokod Qo\'shish',
                  style: Theme.of(context).textTheme.headline4,
                )
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
                child: ListView.builder(
                    itemCount: proms.length,
                    itemBuilder: (ctx, index) => Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                      color: Colors.grey, width: 1)),
                              tileColor: Colors.white,
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Promokod ${index + 1}',
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.grey, width: 1)),
                                    child: Text(
                                      '568426',
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  ),
                                  const Icon(Icons.delete, color: Colors.red),
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (ctx) =>
                                                    const AddingPromocode()));
                                      },
                                      child: const Icon(Icons.edit,
                                          color: Colors.blue)),
                                ],
                              )),
                        )))
          ],
        ),
      ),
    );
  }
}
