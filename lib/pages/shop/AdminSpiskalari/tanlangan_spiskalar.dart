import 'package:flutter/material.dart';
class Tanlangan_Spiskalar extends StatefulWidget {
  const Tanlangan_Spiskalar({Key? key}) : super(key: key);
  @override
  State<Tanlangan_Spiskalar> createState() => _Tanlangan_SpiskalarState();
}
class _Tanlangan_SpiskalarState extends State<Tanlangan_Spiskalar> {
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
         Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Sotuvchi",
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "Spiska",
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            "08.09.2022 11:01",
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            height: 20,
            width: 80,
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(
              "ID:AA 0707",
              style: TextStyle(color: Colors.black, fontSize: 10),
            )),
          ),
          Text(
            "Xaridor",
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Alijonov Bekmirza",
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
          Text(
            "Nurmatov Abdurazzoq",
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
        ],
      ),
      Expanded(
        child: ListView.builder(
            itemCount: 100,
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
                      'assets/images/diamond.png',
                      height: 80,
                      width: 80,
                    ),
                     Column(children: [
                       Text(
                         "0.8lik 190x70 lik 1000 GulO",
                         style: TextStyle(color: Colors.black, fontSize: 13),
                       ),
                       Text(
                         "1 Kvadrat narxi:9 999 999 999 so'm",
                         style: TextStyle(color: Colors.black, fontSize: 9),
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children:const [
                           Text(
                             "Miqdori:9999 m²",
                             style: TextStyle(color: Colors.black, fontSize: 10),
                           ),
                           SizedBox(width: 20,),

                           Text(
                             "Yuklandi",
                             style: TextStyle(color: Colors.black, fontSize: 10),
                           ),
                           SizedBox(width: 20,),
                            Text(
                             "Yuklandi",
                             style: TextStyle(color: Colors.black, fontSize: 10),
                           ),
                         ],
                       ),
                       SizedBox(height: 10,),
                       const Text(
                         "Jami summa:9 999 999 999 so'm",
                         style: TextStyle(color: Colors.black, fontSize: 10),
                       ),
                     ],
                     )
                  ],
                ),
              );
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            "To'lov turi",
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
          Text(
            "Plastik karta",
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
          Text(
            "1\$=10100 so'm",
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),

        ],
      ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Pramocode",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
              const Text(
                "08080808008454545",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
             const Text(
                "Faol emas",
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),
            ],),
         const Text(
            "Xaridorda bor 9 999 999 999 so'm",
            style: TextStyle(color: Colors.blue, fontSize: 13),
          ),
          const  Text(
            "Qarzdorlik:9 999 999 999 so'm",
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
          const   Text(
            "Kelishilgan Jami summa",
            style: TextStyle(color: Colors.black, fontSize: 13),
          ),
          const Text(
            "9 999 999 999 so'm",
            style: TextStyle(color: Colors.red, fontSize: 13),
          ),
          Row(
            children:const [
              Text(
                "Jami foyda:9 999 999 999 so'm ",
                style: TextStyle(color: Colors.green, fontSize: 15),
              ),
              SizedBox(width: 50,),
              Text(
                "15%",
                style: TextStyle(color: Colors.green, fontSize: 10),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(onPressed: (){},
                  child: Container(width: 150,height: 50,
                decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width:1,
                        ),
                        borderRadius: BorderRadius.circular(5),color: Colors.red),
                  child: Center(
                    child: Text(
                      "Bekor qilish",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  )
              ),
              ElevatedButton(onPressed: (){},
                  child: Container(width: 150,height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                          width:1,
                        ),
                        borderRadius: BorderRadius.circular(5),color: Colors.blue),
                    child: Center(
                      child: Text(
                        "Tasdiqlash",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  )
              ),
            ],
          ),
    ]));
  }
}
