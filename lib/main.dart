import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:spiska_uz_loyihasi/pages/home_page.dart';
import 'package:spiska_uz_loyihasi/pages/introPages/login_with_phone.dart';
import 'package:spiska_uz_loyihasi/service/barcode_service.dart';
import 'package:spiska_uz_loyihasi/service/hive_service.dart';
import 'package:spiska_uz_loyihasi/service/themes.dart';
import 'package:spiska_uz_loyihasi/view_model/add_shop_vm/add_shop_page_vm.dart';
import 'package:spiska_uz_loyihasi/view_model/add_shop_vm/pickImage_vm.dart';
import 'package:spiska_uz_loyihasi/view_model/app_settings_view_model.dart';
import 'package:spiska_uz_loyihasi/view_model/cart_view_model.dart';
import 'package:spiska_uz_loyihasi/view_model/drawer_view_model.dart';
import 'package:spiska_uz_loyihasi/view_model/entry_view_model.dart';
import 'package:spiska_uz_loyihasi/view_model/get_products_vm.dart';
import 'package:spiska_uz_loyihasi/view_model/like_vm.dart';
import 'package:spiska_uz_loyihasi/view_model/main_tabbar_vm/tab1_view_model.dart';
import 'package:spiska_uz_loyihasi/view_model/main_tabbar_vm/tab2_view_model.dart';
import 'package:spiska_uz_loyihasi/view_model/main_tabbar_vm/tab3_view_model.dart';
import 'package:spiska_uz_loyihasi/view_model/pick_regions_vm.dart';
import 'package:spiska_uz_loyihasi/view_model/search_view_model.dart';
import 'package:spiska_uz_loyihasi/view_model/shop/delete_shop_vm.dart';
import 'package:spiska_uz_loyihasi/view_model/shop/edit_product_vm.dart';
import 'package:spiska_uz_loyihasi/view_model/shop/get_shop_by_id.dart';
import 'package:spiska_uz_loyihasi/view_model/shop/shop_page_tools_view_model.dart';
import 'package:spiska_uz_loyihasi/view_model/shop_info_and_add_customer_view_model.dart';
void main() async {
  await Hive.initFlutter();
  await Hive.openBox('spiskaUz');
  await Hive.openBox('boolValue');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShopToolsPageVM()),
        ChangeNotifierProvider(create: (_) => DrawerViewModal()),
        ChangeNotifierProvider(create: (_) => TabBar1VM()),
        ChangeNotifierProvider(create: (_) => CartVM()),
        ChangeNotifierProvider(create: (_) => EntryPageVM()),
        ChangeNotifierProvider(create: (_) => ShopInfoVM()),
        ChangeNotifierProvider(create: (_) => TabBar1VM()),
        ChangeNotifierProvider(create: (_) => Tab2VM()),
        ChangeNotifierProvider(create: (_) => Tab3VM()),
        ChangeNotifierProvider(create: (_) => SearchVM()),
        ChangeNotifierProvider(create: (_) => AddShopVM()),
        ChangeNotifierProvider(create: (_) => PickImageVM()),
        ChangeNotifierProvider(create: (_) => PickRegionsVM()),
        ChangeNotifierProvider(create: (_) => GetProductsVM()),
        ChangeNotifierProvider(create: (_) => LikeVM()),
        ChangeNotifierProvider(create: (_) => BarcodeService()),
        ChangeNotifierProvider(create: (_) => GetShopVM()),
        ChangeNotifierProvider(create: (_) => EditProductVM()),
        ChangeNotifierProvider(create: (_) => DeleteVM()),
      ],
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ru', 'RU'),
          Locale('uz', 'UZ'),
        ],
        fallbackLocale: const Locale('uz', 'UZ'),
        child: const MyApp(),
      ),
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _callStartPage() {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          User? newData = snapshot.data;
          if (snapshot.hasData && newData != null) {
            return const HomePage();
          } else {
            return const LoginWithPhone();
          }
        });
  }

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
    HiveDB.storeCurrency();
  }
  AppSettingsVM themeChangeProvider = AppSettingsVM();
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreference.isDarkMode();
    themeChangeProvider.language;
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return themeChangeProvider;
      },
      child: Consumer<AppSettingsVM>(
          builder: (BuildContext context, value, Widget? child) {
        return MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          title: 'Spiska Uz',
          themeMode:
              themeChangeProvider.darkTheme ? ThemeMode.dark : ThemeMode.light,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: _callStartPage(),
        );
      }),
    );
  }
}
