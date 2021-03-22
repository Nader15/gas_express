import 'package:flutter/material.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/custom_divider.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class MyWallet extends StatefulWidget {
  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerList(),
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(getTranslated(context, "MyWallet"),
            style: TextStyle(fontWeight: FontWeight.w100)),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: _mainForm(context),
      ),
    );
  }

  Form _mainForm(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(context, "YourBalance"),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w100),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "30",
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: greenAppColor,
                                      fontWeight: FontWeight.w100),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  getTranslated(context, "SR"),
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: greenAppColor,
                                      fontWeight: FontWeight.w100),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FlatButton(
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 22,
                                    width: 22,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: greenAppColor)),
                                    child: Icon(
                                      Icons.add,
                                      color: greenAppColor,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    getTranslated(context, "AddCredit"),
                                    style: TextStyle(
                                        color: greenAppColor,
                                        fontWeight: FontWeight.w100),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getTranslated(context, "DiscountCodes"),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w100),
                              ),
                              Text(
                                getTranslated(context, "ExpiryDate"),
                                style: TextStyle(
                                    color: greenAppColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100),
                              ),
                              Text(
                                getTranslated(context, "Value"),
                                style: TextStyle(
                                    color: greenAppColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w100),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "XKFON",
                                style: TextStyle(
                                    color: greenAppColor, fontSize: 20),
                              ),
                              Text(
                                "1/2/2022",
                                style: TextStyle(
                                    color: greenAppColor, fontSize: 20),
                              ),
                              Text(
                                "5%",
                                style: TextStyle(
                                    color: greenAppColor, fontSize: 20),
                              ),
                            ],
                          ),
                          CustomDivider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "BO2RT1",
                                style: TextStyle(
                                    color: greenAppColor, fontSize: 20),
                              ),
                              Text(
                                "1/2/2022",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                    color: greenAppColor, fontSize: 20),
                              ),
                              Text(
                                "10ريال",
                                style: TextStyle(
                                    color: greenAppColor, fontSize: 20),
                              ),
                            ],
                          ),
                          CustomDivider(),
                          FlatButton(
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 22,
                                    width: 22,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border:
                                            Border.all(color: greenAppColor)),
                                    child: Icon(
                                      Icons.add,
                                      color: greenAppColor,
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    getTranslated(context, "AddCodeOrCoupon"),
                                    style: TextStyle(
                                        color: greenAppColor,
                                        fontWeight: FontWeight.w100),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(context, "FreeExchange"),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w100),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "أحصل علي تبديل مجاني للاسطوانة عند استبدال عدد 7 اسطوانات خلال عام واحد",
                            style: TextStyle(fontWeight: FontWeight.w100),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "1/7",
                                  style: TextStyle(
                                      fontSize: 40,
                                      color: greenAppColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  getTranslated(context, "Balance"),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: greenAppColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
