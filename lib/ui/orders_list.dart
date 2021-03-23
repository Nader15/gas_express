import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/custom_divider.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/static_ui.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OrdersList extends StatefulWidget {
  @override
  _OrdersListState createState() => _OrdersListState();
}

class _OrdersListState extends State<OrdersList> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerList(),
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(
          getTranslated(context, "Orders"),
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
        actions: [
          StaticUI().cartWidget(context)
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(getTranslated(context, "ExistingOrder"),
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 20,
                        )),
                    SizedBox(
                      height: 10,
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
                                Text(getTranslated(context, "OrderNumber"),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 20,
                                    )),
                                Text("12012121",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(getTranslated(context, "OrderStatus2"),
                                    style: TextStyle(
                                      color: greenAppColor,
                                      fontWeight: FontWeight.w100,
                                      fontSize: 20,
                                    )),
                                Text(getTranslated(context, "OrderWithDriver"),
                                    style: TextStyle(
                                      color: redColor,
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: greenAppColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    alignment: Alignment.center,
                                    child: Text(
                                        getTranslated(
                                            context, "InvoiceDetails"),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w100,
                                            fontSize: 13,
                                            color: whiteColor)),
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(7),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border:
                                                Border.all(color: Colors.blue)),
                                        alignment: Alignment.center,
                                        child: Text(
                                            getTranslated(context, "EditOrder"),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w100,
                                                fontSize: 13,
                                                color: Colors.blue)),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.delete_forever,
                                        color: redColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Icon(
                                        Icons.alternate_email,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(getTranslated(context, "PreviousOrders"),
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 20,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 1.6,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(getTranslated(context, "Number"),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15,
                                      )),
                                  Text(getTranslated(context, "Date"),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15,
                                      )),
                                  Text(getTranslated(context, "Status"),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15,
                                      )),
                                  Text(getTranslated(context, "Value"),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 15,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            recentOrders(true),
                            recentOrders(true),
                            recentOrders(false),
                            recentOrders(true),
                            recentOrders(true),
                            recentOrders(true),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
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

  Widget recentOrders(bool status) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 1.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("12500",
                      style: TextStyle(
                        color: status == true ? greenAppColor : redColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 15,
                      )),
                  Text("1/2/2022",
                      style: TextStyle(
                        color: status == true ? greenAppColor : redColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 15,
                      )),
                  Text(
                      status == true
                          ? getTranslated(context, "Received")
                          : getTranslated(context, "Canceled"),
                      style: TextStyle(
                        color: status == true ? greenAppColor : redColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 15,
                      )),
                  Text("45",
                      style: TextStyle(
                        color: status == true ? greenAppColor : redColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 15,
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: status == true ? greenAppColor : redColor,
              ),
              child: Text(
                getTranslated(context, "Details"),
                style: TextStyle(color: whiteColor),
              ),
            )
          ],
        ),
        CustomDivider(),
      ],
    );
  }
}

TextStyle _titleTextStyle =
    TextStyle(color: greenAppColor, fontSize: 15, fontWeight: FontWeight.w100);
