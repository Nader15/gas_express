import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_express/ui/order_status.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerList(),
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(
          getTranslated(context, "Payment"),
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    Card(
                      color: redColor,
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getTranslated(context, "RequiredAmount"),
                              style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 18,
                                  color: whiteColor),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("60",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 50,
                                        color: whiteColor)),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(getTranslated(context, "SR"),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 30,
                                        color: whiteColor)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  getTranslated(context, "PaymentMethods"),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w100,
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  // width: MediaQuery.of(context).size.width / 4,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.asset(
                                        "assets/images/mada_card.jpg",
                                        width: 40,
                                      ),
                                      Image.asset(
                                        "assets/images/master_card.png",
                                        width: 30,
                                      ),
                                      Image.asset(
                                        "assets/images/visa_card.png",
                                        width: 30,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        // contentPadding: EdgeInsets.zero,
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Image.asset(
                                            "assets/images/wallet.png",
                                            width: 30,
                                          ),
                                        ),
                                        hintStyle:
                                            TextStyle(color: greyPrimaryColor),
                                        hintText: "4520 5123 9854 8542"),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        // contentPadding: EdgeInsets.zero,
                                        hintStyle:
                                            TextStyle(color: greyPrimaryColor),
                                        hintText: "CVS"),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 6,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        // contentPadding: EdgeInsets.zero,
                                        hintStyle:
                                            TextStyle(color: greyPrimaryColor),
                                        hintText: "07/22"),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        // contentPadding: EdgeInsets.zero,

                                        hintStyle:
                                            TextStyle(color: greyPrimaryColor),
                                        hintText: "محمد أحمد علي"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 10,
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "assets/images/cash.png",
                                    width: 30,
                                    color: greenAppColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    getTranslated(context, "PayWhenReceiving"),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                Icons.library_add_check_outlined,
                                color: greenAppColor,
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        navigateAndKeepStack(context, OrderStatus());
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: redColor,
                            borderRadius: BorderRadius.circular(5)),
                        alignment: Alignment.center,
                        child: Text(
                            getTranslated(context, "CompleteThePurchase"),
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 18,
                                color: whiteColor)),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle _titleTextStyle =
    TextStyle(color: greenAppColor, fontSize: 15, fontWeight: FontWeight.w100);
