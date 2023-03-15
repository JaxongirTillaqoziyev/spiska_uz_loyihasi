import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/person_model.dart';
import '../../../../service/hive_service.dart';
import '../../../../service/pref_service.dart';
import '../../../../service/utils.dart';
import '../../../../view_model/add_shop_vm/pickImage_vm.dart';
import '../../../../view_model/app_settings_view_model.dart';
import '../../../../view_model/entry_view_model.dart';
import '../../../home_page.dart';
import '../../../introPages/login_with_phone.dart';
import '../../../introPages/registration.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppSettingsVM>(context, listen: false);
    final provider2 = Provider.of<EntryPageVM>(context, listen: false);
    final provider3 = Provider.of<PickImageVM>(context, listen: false);

    Person person = HiveDB.loadPerson();
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          elevation: 0,
          title: Text(
            'Sozlamalar',
            style: Theme.of(context).textTheme.headline5,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showLogOutLabel();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                )),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //profil data edit
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: Column(children: [
                person.img!.isEmpty
                    ? const Icon(
                        Icons.image,
                        color: Colors.black,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          width: 120,
                          height: 120,
                          imageUrl:
                              'https://spiska.pythonanywhere.com/${person.img}',
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
                const SizedBox(height: 10),
                Text(
                  "${person.firstName} ${person.lastName}",
                  style: Theme.of(context).textTheme.headline4,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  '${person.phone}',
                  style: Theme.of(context).textTheme.headline4,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 20),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 55,
                    minHeight: 45,
                    minWidth: MediaQuery.of(context).size.width / 2,
                    maxWidth: MediaQuery.of(context).size.width / 1.8,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => Registration(
                                    nameCtrl: person.firstName!,
                                    famCtrl: person.lastName!,
                                    buttonTitle: 'Yangilash',
                                    onPressed: () {
                                      if (provider2
                                              .nameController.text.isNotEmpty &&
                                          provider2
                                              .famController.text.isNotEmpty &&
                                          provider3.imagePerson != null) {
                                        Utils.loadingDialog(context);
                                        provider2
                                            .changeUserInfo(context)
                                            .then((value) => {
                                                  if (value == "1")
                                                    {
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (ctx) =>
                                                                  const HomePage()),
                                                          (route) => false),
                                                    }
                                                });
                                      } else {
                                        Utils.showToast(
                                            'Hamma ma\'lumotlarni to\'ldiring');
                                      }
                                    },
                                    title: "Profil Tahrirlash",
                                  )));
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        alignment: Alignment.center,
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Profilni tahrirlash'),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 17,
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Qo'shimcha imkoniyatlar",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  InkWell(
                      onTap: () {
                        dialogLang();
                      },
                      child: listTile1(
                        'Til',
                        Icons.language_outlined,
                        provider.language,
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 17,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      )),
                  InkWell(
                      onTap: () {
                        dialogCurrency();
                      },
                      child: listTile1(
                        'Valyuta',
                        Icons.currency_exchange_rounded,
                        HiveDB.loadCurrency(),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 17,
                          color: Theme.of(context).iconTheme.color,
                        ),
                      )),
                ],
              ),
            )
          ],
        ));
  }

  void toggleSwitch(bool value) {
    final provider = Provider.of<AppSettingsVM>(context, listen: false);
    if (provider.darkTheme == false) {
      setState(() {
        provider.darkTheme = true;
      });
    } else {
      setState(() {
        provider.darkTheme = false;
      });
    }
  }

  void showLogOutLabel() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Rostan ham dasturdan chiqmoqchimisiz?',
              style: Theme.of(context).textTheme.headline6,
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Yo'q",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.green, fontSize: 20),
                  )),
              TextButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginWithPhone()),
                        (Route<dynamic> route) => false);
                    Prefs.removePhone();
                  },
                  child: Text(
                    'Ha',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.red, fontSize: 20),
                  )),
            ],
          );
        });
  }

  Widget listTile1(String title, IconData titleIcon, String suffixText, icon) {
    return ListTile(
      leading: Icon(titleIcon, color: Theme.of(context).iconTheme.color),
      minLeadingWidth: 5,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      trailing: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(suffixText, style: Theme.of(context).textTheme.headline6),
            const SizedBox(width: 10),
            icon,
          ],
        ),
      ),
    );
  }

  void dialogLang() {
    final provider = Provider.of<AppSettingsVM>(context, listen: false);
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Column(
              children: [
                TextButton(
                    onPressed: () {
                      context.setLocale(const Locale('uz', 'UZ'));
                      setState(() {
                        provider.language = "O'zbekcha";
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('O\'zbekcha')),
                TextButton(
                    onPressed: () {
                      context.setLocale(const Locale('en', 'US'));
                      setState(() {
                        provider.language = "EngLish";
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('English')),
                TextButton(
                    onPressed: () {
                      context.setLocale(const Locale('ru', 'RU'));
                      setState(() {
                        provider.language = "Русский";
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('Русский'))
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
        });
  }

  void dialogCurrency() {
    final provider = Provider.of<AppSettingsVM>(context, listen: false);
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Column(
              children: [
                TextButton(
                    onPressed: () {
                      HiveDB.storeCurrency('So\'m');
                      Navigator.pop(context);
                    },
                    child: const Text('So\'m')),
                TextButton(
                    onPressed: () {
                      HiveDB.storeCurrency('Dollar');
                      Navigator.pop(context);
                    },
                    child: const Text('Dollar')),
              ],
            ),
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
        });
  }
}
