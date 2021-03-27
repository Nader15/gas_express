import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/ui/HomeScreens/home_page.dart';
import 'package:gas_express/ui/Orders/OrdersModel.dart';
import 'package:gas_express/ui/orders_list.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/custom_divider.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OrderDetails extends StatefulWidget {
  OrderItem orderItem;

  OrderDetails(this.orderItem);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawerList(),
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(
          getTranslated(context, "OrderStatus2"),
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
        actions: [
          // IconButton(
          //     icon: Icon(Icons.directions_car),
          //     onPressed: () {
          //       navigateAndKeepStack(context, OrdersList());
          //     })
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
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(getTranslated(context, "OrderStatus2"),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 18,
                                      color: whiteColor)),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(widget.orderItem.orderstatus,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w100,
                                        fontSize: 30,
                                        color: whiteColor)),
                              ),
                            ],
                          ),
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
                                Text(getTranslated(context, "OrderNumber"),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                      fontSize: 20,
                                    )),
                                Text("${widget.orderItem.id}",
                                    style: TextStyle(
                                      fontSize: 20,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    widget.orderItem.orderproductDetails.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      OrderWidget(widget.orderItem
                                          .orderproductDetails[index]),
                                      Divider()
                                    ],
                                  );
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // InkWell(
                                //   onTap: () {},
                                //   child: Container(
                                //     padding: EdgeInsets.all(8),
                                //     decoration: BoxDecoration(
                                //         color: greenAppColor,
                                //         borderRadius: BorderRadius.circular(5)),
                                //     alignment: Alignment.center,
                                //     child: Text(
                                //         getTranslated(
                                //             context, "InvoiceDetails"),
                                //         style: TextStyle(
                                //             fontWeight: FontWeight.w100,
                                //             fontSize: 12,
                                //             color: whiteColor)),
                                //   ),
                                // ),
                                Row(
                                  children: [
                                    // InkWell(
                                    //   onTap: () {},
                                    //   child: Container(
                                    //     padding: EdgeInsets.all(7),
                                    //     decoration: BoxDecoration(
                                    //         borderRadius:
                                    //             BorderRadius.circular(5),
                                    //         border:
                                    //             Border.all(color: Colors.blue)),
                                    //     alignment: Alignment.center,
                                    //     child: Text(
                                    //         getTranslated(context, "EditOrder"),
                                    //         style: TextStyle(
                                    //             fontWeight: FontWeight.w100,
                                    //             fontSize: 12,
                                    //             color: Colors.blue)),
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    widget.orderItem.orderstatus == "new"
                                        ? InkWell(
                                            onTap: () {
                                              Api(context, _scaffoldKey)
                                                  .cancelOrder(
                                                      widget.orderItem.id)
                                                  .then((value) {
                                                if (value) {
                                                  navigateAndKeepStack(
                                                      context, HomePage());
                                                }
                                              });
                                            },
                                            child: Icon(
                                              Icons.delete_forever,
                                              color: redColor,
                                            ),
                                          )
                                        : Container(),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    // Icon(
                                    //   Icons.alternate_email,
                                    //   color: Colors.blue,
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Text(
                            //   getTranslated(context, "DeliveryLocation"),
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.w100,
                            //       fontSize: 18,
                            //       color: greenAppColor),
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Container(
                            //   height: 120,
                            //   decoration: BoxDecoration(
                            //       color: greyPrimaryColor.withOpacity(.3),
                            //       borderRadius: BorderRadius.circular(5)),
                            // )
                          ],
                        ),
                      ),
                    ),
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
                                Text("${(widget.orderItem.totalprice??0)-(widget.orderItem.discountValue??0)}",
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
                    SizedBox(
                      height: 40,
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

  Widget OrderWidget(OrderproductDetails orderproductDetails) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Text(translator.currentLanguage == 'ar'
                  ? orderproductDetails.productnameAr
                  : orderproductDetails.productnameEn)),
          Expanded(child: Text(orderproductDetails.quantity.toString())),
          Expanded(
              child: Image.network(
            orderproductDetails.photo,
            height: 100,
            width: 40,
          )),
        ],
      ),
    );
  }
}

TextStyle _titleTextStyle =
    TextStyle(color: greenAppColor, fontSize: 15, fontWeight: FontWeight.w100);
