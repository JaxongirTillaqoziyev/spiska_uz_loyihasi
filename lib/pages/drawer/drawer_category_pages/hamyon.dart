import 'package:flutter/material.dart';

class Hamyon extends StatefulWidget {
  const Hamyon({Key? key}) : super(key: key);
  @override
  State<Hamyon> createState() => _HamyonState();
}

class _HamyonState extends State<Hamyon> {
  List<String> items = ['Olmos', 'atir', 'sham'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bonus va olmos sotib olish'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/phone1.png',
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        '2000',
                        style: TextStyle(color: Colors.blue, fontSize: 40),
                      ),
                    ],
                  ),
                  Text(
                    '23:59:59',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print('salom');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            border: Border.all(width: 2, color: Colors.blue),
                            borderRadius: BorderRadius.circular(10)),
                        width: 400,
                        height: 40,
                        child: const Center(
                          child: Text(
                            'Kunlik bonus Olish',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 1000,
                child: GridView.count(
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  children: List.generate(20, (index) {
                    return Container(
                        height: 200,
                        width: 300,
                        decoration: BoxDecoration(
                            border: Border.all(width: 3, color: Colors.black12),
                            borderRadius: BorderRadius.circular(20)),
                        child: Card(
                          color: Colors.black45,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/phone1.png',
                                height: 118,
                                fit: BoxFit.cover,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('120'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('60'),
                                ],
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    print('salom');
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        border: Border.all(
                                            width: 2, color: Colors.blue),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    width: 400,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        '\$0.99',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ));
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
