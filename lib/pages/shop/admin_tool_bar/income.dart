import 'package:flutter/material.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline4
            ?.copyWith(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        title: const Text('Kirim daftar'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '08.12.2021 dan',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                '31.12.2021 gacha',
                style: Theme.of(context).textTheme.headline4,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade300),
                  onPressed: () {},
                  child: Text(
                    'Filter',
                    style: Theme.of(context).textTheme.headline5,
                  ))
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (ctx, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kompyuter',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black,
                                width: 0.5,
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '08 lik 190x70 lik 1000 gulo  ',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Text(
                                    '1\$=10100',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.copyWith(
                                          backgroundColor: Colors.white24,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '1 Kvadirati:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      Text(
                                        '999,999,999 so’m',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                              backgroundColor: Colors.white24,
                                            ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '9,999',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      Text(
                                        'Kvadirat',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5
                                            ?.copyWith(
                                              backgroundColor: Colors.white24,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(
                                    'Jami summa:',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  Text(
                                    '999,999,999,999 so’m',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5
                                        ?.copyWith(
                                          backgroundColor: Colors.white24,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '3000 dona',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(color: Colors.red),
                            ),
                            Text(
                              'Jami :300 000 000 so’m',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    )),
          )
        ],
      ),
    );
  }
}
