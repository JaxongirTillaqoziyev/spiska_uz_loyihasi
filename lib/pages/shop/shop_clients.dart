import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../model/Member_model.dart';
import '../../service/utils.dart';
import 'AdminSpiskalari/admin_spiskalari.dart';
import 'admin_tool_bar/add_customer_toShop.dart';

class Shop_Clients extends StatefulWidget {
  const Shop_Clients({Key? key, required this.members}) : super(key: key);
  final List<MemberModel> members;

  @override
  State<Shop_Clients> createState() => _Shop_ClientsState();
}

class _Shop_ClientsState extends State<Shop_Clients> {
  @override
  void initState() {
    Utils.showToast("Clients");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Do'kon xaridorlari"),
          actions: [
            InkWell(
                onTap: () {
                  Utils.showToast("Jami qarzdorliklar");
                },
                child: Icon(Icons.account_balance_sharp))
          ],
        ),
        body: Column(children: [
          Container(
            height: 73,
            width: 400,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => AddCustomerPage(
                            shopId: 1, // id qo'yish kerak
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.person_add_sharp,
                      color: Colors.blue,
                    )),
                SizedBox(
                  width: 10,
                ),
                const Text(
                  "Xaridor qo'shish",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                SizedBox(
                  width: 40,
                ),
                Text(
                  "${widget.members.length}  ta xaridor",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: widget.members.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => Admin_Spiskalari(),
                      ),
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(3)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                width: 90,
                                height: 90,
                                imageUrl:
                                    "https://spiska.pythonanywhere.com/${widget.members[index].img}",
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${widget.members[index].firstName}  ${widget.members[index].lastName} ",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                ),
                                Container(
                                    height: 30,
                                    width: 230,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.green,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "Qarzdorlik:999 999 999 so'm",
                                      style: TextStyle(
                                          fontSize: 13, color: Colors.blue),
                                    ))),
                                Container(
                                    height: 30,
                                    width: 230,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.green,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "Qarzdorlik: so'mda mavjud emas",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.blue),
                                    ))),
                                SizedBox(
                                  width: 1,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Admin",
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.blue,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      "5",
                                      style: TextStyle(
                                          fontSize: 15, color: Colors.blue),
                                    ))),
                              ],
                            ),
                          ])),
                )),
          )
        ]));
  }
}
