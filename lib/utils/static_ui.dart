import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_express/ui/HomeScreens/BannersModel.dart';
import 'package:gas_express/ui/HomeScreens/home_page.dart';
import 'package:gas_express/ui/Cart/cart.dart';
import 'package:gas_express/ui/Orders/OrdersScreen.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:gas_express/utils/size_config.dart';

import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:gas_express/utils/colors_file.dart' as colorsValues;
import 'package:gas_express/utils/image_file.dart' as imagesfile;

class StaticUI {

  Widget cartWidget(BuildContext context){
    return  Stack(
      children: [
        IconButton(icon: Icon(
          Icons.shopping_cart,
          size: 20.0,
        ), onPressed: () {
            if(cartList.length!=0){
            navigateAndKeepStack(context, Cart());

          }

          // navigateAndKeepStack(context, TestProducts());
        }),


        cartList.length==0?Container():     Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(    borderRadius: BorderRadius.circular(10),color: Colors.white)
            ,width: 20,height: 20,child: Center(child: Text(cartList.length.toString(),style: TextStyle(color: Colors.red),)),),
        )
      ],
    );
  }
  Decoration containerDecoration({
    Color colorValue,
    double borderRidusValue,
  }) {
    return BoxDecoration(
        borderRadius: BorderRadius.circular(borderRidusValue),
        color: colorValue,
        border: Border.all(color: colorsValues.primaryAppColor));
  }

  bottomNavBarWidget(BuildContext context) {
    return Row(
      children: [
        StaticUI().BuildNavBar(context, "images/ic_home.svg", 'Home', true, 0),
        // BuildNavBar("images/ic_program.svg", 'Programs', false, 1),
        StaticUI().BuildNavBar(
            context, "images/trophy_4.svg", 'Competitions', false, 1),
        StaticUI()
            .BuildNavBar(context, "images/ic_media.svg", 'Media', false, 2),
        StaticUI().BuildNavBar(context, "images/ic_more.svg", 'More', false, 3),
      ],
    );
  }

  dividerContainer(BuildContext context) {
    return Container(
      height: .5,
      color: Colors.grey,
      width: SizeConfig.safeBlockHorizontal * 70,
    );
  }

  dividerContainer2(BuildContext context) {
    return Container(
      height: .5,
      color: Color(0xffe7e7e7),
      width: SizeConfig.safeBlockHorizontal * 90,
    );
  }

  Widget appBarWidget(String appBArName) {
    return AppBar(
      elevation: 0,
      backgroundColor: colorsValues.whiteColor,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: colorsValues.blackColor, //change your color here
      ),
      title: Center(
        child: Text(
          appBArName,
          style: TextStyle(color: colorsValues.blackColor, fontSize: 18),
        ),
      ),
    );
  }

  progressIndicatorWidget() {
    return Center(
        child: Container(
      child: CircularProgressIndicator(
        backgroundColor: colorsValues.primaryAppColor,
        valueColor: AlwaysStoppedAnimation(colorsValues.whiteColor),
      ),
    ));
  }

  onWillPop(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                title: Text(
                  "Are you sure to logOut",
                  style: TextStyle(fontFamily: "BoutrosAsma_Regular"),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(
                              width: 1,
                              color: Colors
                                  .grey //                   <--- border width here
                              ),
                        ),
                        child: Text(
                          "Exit",
                          style: TextStyle(color: Colors.white),
                        )),
                    onTap: () {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                  ),
                  GestureDetector(
                    child: Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          border: Border.all(
                              width: 1,
                              color: Colors
                                  .grey //                   <--- border width here
                              ),
                        ),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        )),
                    onTap: () {
                      print('Tappped');
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget BuildNavBar(BuildContext context, String icon, String name,
      bool isActive, int index) {
    return GestureDetector(
      onTap: () {
        navigateAndKeepStack(
            context,
            HomePage(
              currentIndex: index,
            ));
      },
      child: Container(
          alignment: Alignment.center,
          height: 70,
          width: MediaQuery.of(context).size.width / 4,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 4, color: Colors.grey),
            ),
            color: Color(0xff204561),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                color: Colors.grey,
                width: 22,
                height: 22,
              ),
              SizedBox(height: 10),
              Text(
                name,
                style: TextStyle(color: Colors.grey),
              )
            ],
          )),
    );
  }

  NoDataFoundWidget(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 20),
        child: Container(
            height: MediaQuery.of(context).size.height,
            child: Center(child: Text(  getTranslated(context, "noDataFound")))));
  }


bottomNavWiget(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(onTap: (){
        if(cartList.length==0){
          navigateAndKeepStack(context, OrdersScreen());

        }
        else {
          navigateAndKeepStack(context, Cart());

        }

      },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: cartList.length==0?redColor:greenAppColor, borderRadius: BorderRadius.circular(5)),
          alignment: Alignment.center,
          child: cartList.length!=0?Text(getTranslated(context, "continueBuying"),   style: TextStyle(
              fontWeight: FontWeight.w100,
              fontSize: 18,
              color: whiteColor)):Text(getTranslated(context, "OrderStatus"),
              style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: 18,
                  color: whiteColor)),
        ),
      ),
    );
}
  closeApp(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(17),
                child: AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(17))),
                  elevation: 5.0,
                  backgroundColor: Colors.white,
                  titlePadding: EdgeInsets.all(16.0),
                  title: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(17)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                            child: Text(
                          "Are you sure you want to exit?",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(0xff707070),
                              fontWeight: FontWeight.w700),
                        )),
                        SizedBox(
                          height: 25.0,
                        ),
                        Image.asset(
                          "images/logOutImage.jpeg",
                          height: 100,
                          width: 100,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: 75,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    gradient: new LinearGradient(
                                      colors: [
                                        colorsValues.azure,
                                        colorsValues.vibrantBlue,
                                      ],
                                      begin: FractionalOffset.topCenter,
                                      end: FractionalOffset.bottomCenter,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.5)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'No',
                                    style: TextStyle(
                                        color: colorsValues.whiteColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800),
                                  )),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  SystemChannels.platform
                                      .invokeMethod('SystemNavigator.pop');
                                },
                                child: Container(
                                  width: 75,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    gradient: new LinearGradient(
                                      colors: [
                                        Color(0xfffa9f42),
                                        Color(0xffee752a),
                                      ],
                                      begin: FractionalOffset.topLeft,
                                      end: FractionalOffset.bottomRight,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.5)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: colorsValues.whiteColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
