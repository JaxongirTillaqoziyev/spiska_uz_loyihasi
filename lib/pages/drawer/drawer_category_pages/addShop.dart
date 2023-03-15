import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../view_model/add_shop_vm/add_shop_page_vm.dart';
import '../../../view_model/add_shop_vm/pickImage_vm.dart';
import '../../../widgets/add_shop/pickImage_widget.dart';
import '../../../widgets/custom_textfield.dart';
import '../../home_page.dart';

class AddShop extends StatefulWidget {
  AddShop({
    Key? key,
  }) : super(key: key);

  @override
  State<AddShop> createState() => _AddShopState();
}

class _AddShopState extends State<AddShop> {
  @override
  void initState() {
    print("initState");
    final provider = Provider.of<AddShopVM>(context, listen: false);
    super.initState();
    provider.getRegionsAPI(context);
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    final provider = Provider.of<AddShopVM>(context, listen: true);
    final provider2 = Provider.of<AddShopVM>(context, listen: false);
    final imageProvider = Provider.of<PickImageVM>(context, listen: true);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'newShopCreate'.tr(),
              style: Theme.of(context).textTheme.headline3,
            ).tr(),
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: SingleChildScrollView(
              controller: provider.scrollController,
              child: Form(
                key: provider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //shop image
                    PickImageTile(
                      onPressed: () {
                        imageProvider.pickImageShop();
                      },
                      title: 'Do\'kon logotipi',
                      image: imageProvider.imageShop,
                    ),
                    const SizedBox(height: 15),

                    ///shop name
                    CustomTextfield(
                      hintText: 'shopName'.tr(),
                      controller: provider.shopNameController,
                      validator: (input) =>
                          input!.isEmpty ? "enterShopName".tr() : null,
                    ),
                    const SizedBox(height: 15),

                    ///shop details
                    CustomTextfield(
                      controller: provider.descrController,
                      hintText: 'Do\'kon tasnifi ...',
                      validator: (input) =>
                          input!.isEmpty ? "Do\'kon tasnifini kiriting" : null,
                      minLine: 4,
                      maxLine: 6,
                    ),
                    const SizedBox(height: 15),

                    ///shop password
                    CustomTextfield(
                      controller: provider.passController,
                      hintText: 'Do\'kon parolini kiriting ...',
                      validator: (input) => input!.isEmpty
                          ? "Do\'kon uchun parol kiriting"
                          : null,
                    ),
                    const SizedBox(height: 15),

                    ///reenter shop password
                    CustomTextfield(
                      controller: provider.passConfirmController,
                      hintText: 'Do\'kon parolini qayta kiriting ...',
                      validator: (input) =>
                          input != provider.passController.text.trim()
                              ? "Bir xil parol kiriting"
                              : null,
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        provider.getLocation(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            alignment: Alignment.center,
                            height: 100,
                            width: 110,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: const Color(0xff2084E9), width: 1),
                                borderRadius: BorderRadius.circular(20)),
                            child: provider.lati == null &&
                                    provider.long == null
                                ? const Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.black,
                                    size: 32,
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Lat:${provider.lati}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                      Text(
                                        'Long: ${provider.long}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ],
                                  ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                'Do\'kon Joylashuvi',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField(
                            validator: (input) =>
                                input == null ? "Viloyatni tanlang" : null,
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: Color(0xff2084E9), width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: Color(0xff2084E9), width: 1)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 1)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 1)),
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20)),
                            items: provider.viloyat?.map((e) {
                              return DropdownMenuItem(
                                value: e.id,
                                child: Text(
                                  '${e.name}',
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                              );
                            }).toList(),
                            onChanged: (dynamic input) {
                              setState(() {
                                provider.vil_index = input;
                              });
                              provider2.getTuman();
                              print(provider.vil_index);
                            },
                            hint: const Text('Viloyat'),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: !provider.loader1
                              ? DropdownButtonFormField(
                                  validator: (input) =>
                                      input == null ? "Tumanni tanlang" : null,
                                  isDense: true,
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                              color: Color(0xff2084E9),
                                              width: 1)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                              color: Color(0xff2084E9),
                                              width: 1)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 1)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: const BorderSide(
                                              color: Colors.red, width: 1)),
                                      border: InputBorder.none,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 20)),
                                  items: provider.tuman?.map((e) {
                                    return DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        '${e.name}',
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (dynamic input) {
                                    setState(() {
                                      print('tuman: ${input}');
                                      provider.tum_id = input;
                                    });
                                  },
                                  hint: const Text('Tuman'),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Hisob kitob uchun pul birligi ',
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        radioButton('So\'m', '0'),
                        const SizedBox(width: 5),
                        radioButton('Dollar', '1'),
                      ],
                    ),
                    ListTile(
                      leading: IconButton(
                        onPressed: () {
                          setState(() {
                            provider.isCheck = !provider.isCheck;
                          });
                        },
                        icon: !provider.isCheck
                            ? const Icon(Icons.check_box_outline_blank)
                            : const Icon(
                                Icons.check_box,
                                color: Colors.blue,
                              ),
                      ),
                      title: InkWell(
                        onTap: () {
                          securePolicy();
                        },
                        child: Text(
                          'Mahfiylik siyosatimizga rozilik berish',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        creatingButton(context, 'Korxona yaratish', "2"),
                        creatingButton(context, 'Do\'kon yaratish', "1"),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget creatingButton(BuildContext context, String title, String type) {
    final provider = Provider.of<AddShopVM>(context, listen: false);
    final providerImage = Provider.of<PickImageVM>(context, listen: false);
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width / 2.3,
      child: TextButton(
          onPressed: () {
            if (providerImage.imageShop == null) return;
            if (!provider.isCheck) return;
            if (provider.lati == null && provider.long == null) return;
            if (provider.formKey.currentState!.validate()) {
              setState(() {
                provider.type = type;
              });
              newDialog(title);
            }
          },
          style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              alignment: Alignment.center,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          child: Text(
            title,
            style: const TextStyle(
                fontSize: 19,
                color: Colors.white,
                fontWeight: FontWeight.normal),
          )),
    );
  }

  Expanded radioButton(String title, String value) {
    final provider = Provider.of<AddShopVM>(context, listen: false);
    return Expanded(
      child: RadioListTile(
        dense: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: Colors.blue, width: 1)),
        title: Text(title),
        value: value,
        groupValue: provider.radioValue,
        onChanged: (value) {
          setState(() {
            provider.radioValue = value.toString();
          });
        },
      ),
    );
  }

  void securePolicy() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (_) => Container(
              padding: EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height / 1.2,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text('Maxfiylik siyosati',
                        style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 20),
                    Text(
                      "Bugungi kunda IIOlarning aynan shunday sharoitdagi shaxslarni reabilitatsiya markaziga joylashtirish to‘g‘risidagi iltimosnomalariga doir ishlar tumanlararo maʼmuriy sudlar tomonidan ko‘rib chiqilmoqda."
                      "Shu bois qonun bilan O‘zbekiston Respublikasining Maʼmuriy javobgarlik to‘g‘risidagi hamda Maʼmuriy sud ishlarini yuritish to‘g‘risidagi kodekslariga tegishli qo‘shimcha va o‘zgartishlar kiritilmoqda.",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      "Bugungi kunda IIOlarning aynan shunday sharoitdagi shaxslarni reabilitatsiya markaziga joylashtirish to‘g‘risidagi iltimosnomalariga doir ishlar tumanlararo maʼmuriy sudlar tomonidan ko‘rib chiqilmoqda."
                      "Shu bois qonun bilan O‘zbekiston Respublikasining Maʼmuriy javobgarlik to‘g‘risidagi hamda Maʼmuriy sud ishlarini yuritish to‘g‘risidagi kodekslariga tegishli qo‘shimcha va o‘zgartishlar kiritilmoqda.",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      "Bugungi kunda IIOlarning aynan shunday sharoitdagi shaxslarni reabilitatsiya markaziga joylashtirish to‘g‘risidagi iltimosnomalariga doir ishlar tumanlararo maʼmuriy sudlar tomonidan ko‘rib chiqilmoqda."
                      "Shu bois qonun bilan O‘zbekiston Respublikasining Maʼmuriy javobgarlik to‘g‘risidagi hamda Maʼmuriy sud ishlarini yuritish to‘g‘risidagi kodekslariga tegishli qo‘shimcha va o‘zgartishlar kiritilmoqda.",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(
                      "Bugungi kunda IIOlarning aynan shunday sharoitdagi shaxslarni reabilitatsiya markaziga joylashtirish to‘g‘risidagi iltimosnomalariga doir ishlar tumanlararo maʼmuriy sudlar tomonidan ko‘rib chiqilmoqda."
                      "Shu bois qonun bilan O‘zbekiston Respublikasining Maʼmuriy javobgarlik to‘g‘risidagi hamda Maʼmuriy sud ishlarini yuritish to‘g‘risidagi kodekslariga tegishli qo‘shimcha va o‘zgartishlar kiritilmoqda.",
                      style: Theme.of(context).textTheme.headline5,
                    )
                  ],
                ),
              ),
            ));
  }

  void newDialog(String title) {
    final provider = Provider.of<AddShopVM>(context, listen: false);
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(
                "$title uchun 400 olmosinggizdan yechiladi",
                style: Theme.of(context).textTheme.headline4,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Bekor qilish')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      loadingDialog(context);
                      provider.addShopButton(context);
                    },
                    child: const Text('Davom etish')),
              ],
            ),);
  }

  void gotoHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (ctx) => const HomePage()),
        (route) => false);
  }

  void loadingDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: SizedBox(
              width: 100,
              height: 100,
              child: Center(child: CircularProgressIndicator())),
        );
      },
    );
  }
}
