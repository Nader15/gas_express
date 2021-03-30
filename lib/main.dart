import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:gas_express/provider/cartProvider.dart';
import 'package:gas_express/ui/Orders/order_Details.dart';
 import 'package:gas_express/ui/splash.dart';
import 'package:flutter/material.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:provider/provider.dart';

main() async {
  // if your flutter > 1.7.8 :  ensure flutter activated
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance?.resamplingEnabled = true;

  await translator.init(
    localeDefault: LocalizationDefaultType.device,
    languagesList: <String>['ar', 'en'],
    assetsDirectory: 'assets/langs/',
    apiKeyGoogle: '<Key>', // NOT YET TESTED
  );

  runApp(
    LocalizedApp(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(primaryAppColor);

    return MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Gas Express",
        theme: ThemeData(
          fontFamily: translator.currentLanguage == "ar" ? 'Almarai' : "SourceSansPro",
        ),
        // home: HomePage(),
        // home: OrderStatus(),
        // home: OrdersList(),
        // home: HistoryOrdersList(),
        home: Splash(),
        localizationsDelegates: translator.delegates,
        // Android + iOS Delegates
        locale: translator.locale,
        // Active locale
        supportedLocales: translator.locals(), // Locals list
      ),
    );
  }
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}


