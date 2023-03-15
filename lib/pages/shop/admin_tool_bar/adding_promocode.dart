import 'package:flutter/material.dart';

class AddingPromocode extends StatefulWidget {
  const AddingPromocode({Key? key}) : super(key: key);

  @override
  State<AddingPromocode> createState() => _AddingPromocodeState();
}

class _AddingPromocodeState extends State<AddingPromocode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Promokod qo'shish"),
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Text('Promokodlar', style: Theme.of(context).textTheme.headline3),
            const SizedBox(height: 20),
            Expanded(
                child: GridView.builder(
                    itemCount: 12,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisExtent: 50,
                    ),
                    itemBuilder: (ctx, index) => Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 0.5)),
                        ))),
            TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  minimumSize:
                      Size(MediaQuery.of(context).size.width / 1.6, 52),
                  maximumSize:
                      Size(MediaQuery.of(context).size.width / 1.4, 55),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {},
                child: const Text('Tasdiqlash'))
          ],
        ));
  }
}
