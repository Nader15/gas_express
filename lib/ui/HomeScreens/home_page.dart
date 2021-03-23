import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/ui/HomeScreens/BannersModel.dart';
import 'package:gas_express/ui/HomeScreens/ProductsModel.dart';
import 'package:gas_express/ui/HomeScreens/new_products.dart';
import 'package:gas_express/ui/HomeScreens/products.dart';
import 'package:gas_express/ui/HomeScreens/recharge.dart';
import 'package:gas_express/ui/Cart/cart.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:gas_express/utils/static_ui.dart';


class HomePage extends StatefulWidget {
  final int currentIndex;

  HomePage({this.currentIndex});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  // Timer _timer;
   List<BannerItem> bannerItemList = List();
  BannersModel bannersModel;
  getBanners() {
    Api(context, _drawerKey).getBanners().then((value) {
      bannersModel = value;
      bannersModel.results.forEach((element) {
        setState(() {
          bannerItemList.add(element);
        });
      });
    });
  }
@override
  void initState() {
    // TODO: implement initState

  Future.delayed(Duration(milliseconds: 0), () {
    getBanners();
  });
updateCart();
    super.initState();
  }
  updateCart(){
// if(!mounted){
//   _timer= Timer.periodic(Duration(seconds: 1), (timer) {
//     setState(() {
//       cartList.length= cartList.length;
//     });
//   });
// }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerList(),
      key: _drawerKey,
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              getTranslated(context, "TheProducts"),
              style: TextStyle(fontWeight: FontWeight.w100),
            ),
            actions: [
             StaticUI().cartWidget(context)
            ],
            backgroundColor: primaryAppColor,
            leading: IconButton(
              onPressed: () => _drawerKey.currentState.openDrawer(),
              icon: Icon(Icons.menu),
            ),
            bottom: PreferredSize(
              preferredSize: Size.square(80),
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 80,
                color: whiteColor,
                child: TabBar(
                  unselectedLabelColor: blackColor.withOpacity(0.5),
                  indicatorColor: Colors.transparent,
                  labelColor: primaryAppColor,
                  tabs: [
                    Container(
                      height: 70,
                      child: Tab(
                        text: getTranslated(context, "Recharge"),
                        icon: Image.asset(
                          "assets/images/rechrge_tube.png",
                          width: 20,
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Tab(
                        icon: Image.asset(
                          "assets/images/new_tube.png",
                          width: 30,
                        ),
                        text: getTranslated(context, "New"),
                      ),
                    ),
                    Container(
                      height: 70,
                      child: Tab(
                        text: getTranslated(context, "Products"),
                        icon: Image.asset(
                          "assets/images/products.png",
                          width: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              Recharge(bannerItemList),
              NewProducts(bannerItemList),
              Products(bannerItemList),
            ],
          ),
        ),
      ),
    );
  }
}
