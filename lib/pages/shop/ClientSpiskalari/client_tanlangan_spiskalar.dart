import 'package:flutter/material.dart';
class Client_Tanlangan_Spisklar extends StatefulWidget {
  const Client_Tanlangan_Spisklar({Key? key}) : super(key: key);
  @override
  State<Client_Tanlangan_Spisklar> createState() => _Client_Tanlangan_SpisklarState();
}

class _Client_Tanlangan_SpisklarState extends State<Client_Tanlangan_Spisklar> {
  int _counter = 99999;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _deincrementCounter() {
    setState(() {
      _counter--;
    });
  }
  double sliderValue = 0.2;

  TextEditingController hozirgi_holatingizdagi_summangiz = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/phone1.png',
                          height:15,
                          width: 15,
                        ),
                        Column(children: [
                          Text(
                            "0.8lik 190x70 lik 1000 GulO",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            "1 Kvadrat narxi:9 999 999 999 so'm",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),

                          const Text(
                            "Jami summa:9 999 999 999 so'm",
                            style: TextStyle(color: Colors.black, fontSize: 13),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              ElevatedButton(onPressed:(){
                                 _deincrementCounter();
                              },
                                child: Container(width: 30,height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.red,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                child: Center(child: Text("-")),
                              )),
                            _counter<=0?
                              Text(
                                "$_counter",
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ):
                            Text(
                              "$_counter",
                              style: TextStyle(color: Colors.black, fontSize: 15),
                            ),
                              ElevatedButton(onPressed:(){
                                _deincrementCounter();
                              },
                                child: Container(width: 30,height: 30,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(child: Text("+")),
                                )),
                           Column(children: [
                             const Text(
                               "Kvadrat",
                               style: TextStyle(color: Colors.black, fontSize: 9),
                             ),
                             Slider(
                               value: sliderValue,
                               onChanged: (double value) {
                                 setState(() {
                                   sliderValue = value;
                                 });
                               },
                             ),
                           ],)
                            ],
                          ),

                        ],
                        )
                      ],
                    ),
                  );
                }),
          ),
          Row(
            children: const [
              SizedBox(width: 50,),
              Text(
                "Promocode",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            SizedBox(width: 50,),
              Text(
                "0808080880",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Jami summa",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
              SizedBox(width: 50,),
              const Text(
                "9 999 999 999 so'm",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ],),
          const Text(
            "Hozirgi holatingizda bera oladigan summangiz",
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
          const Text(
            "9 999 999 999 so'm",
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
          ElevatedButton(onPressed: (){},
              child: Container(width: 350,height: 50,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueGrey,
                      width:1,
                    ),
                    borderRadius: BorderRadius.circular(5),color: Colors.blue),
                child: Center(
                  child: Text(
                    "Buyurtma berish",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              )
          ),
        ]));
  }
}


