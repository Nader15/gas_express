import 'package:flutter/material.dart';
import 'dart:async';

import 'package:gas_express/APiFunctions/sharedPref/SharedPrefClass.dart';
import 'package:gas_express/ui/HomeScreens/home_page.dart';
import 'package:gas_express/ui/LoginScreens/login.dart';
import 'package:gas_express/utils/image_file.dart';
import 'package:gas_express/utils/navigator.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromShared().then((value) {
      Future.delayed(Duration(seconds: 3), () {
        if(BaseToken!=null){
          navigateAndKeepStack(context, HomePage());

        }
        else {
          navigateAndClearStack(context, Login());

        }
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Image.asset(
      APP_LOGO,
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
    ));
  }
}
