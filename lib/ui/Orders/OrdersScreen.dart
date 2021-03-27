import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/APiFunctions/sharedPref/SharedPrefClass.dart';
import 'package:gas_express/ui/Cart/cart.dart';
 import 'package:gas_express/ui/Orders/OrdersModel.dart';
 import 'package:gas_express/ui/UserAddresses/my_addresses.dart';
import 'package:gas_express/ui/Orders/order_status.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/custom_divider.dart';
import 'package:gas_express/ui/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:gas_express/utils/static_ui.dart';
import 'package:gas_express/utils/toast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OrdersModel OrderModel;
  List<OrderItem> currentOrdersList = List();
  List<OrderItem> HistoryOrdersList = List();

  gettingHistoryData() {
    setState(() {
      HistoryOrdersList.clear();

      Api(context, _scaffoldKey).ordersHistoryListApi().then((value) {
        OrderModel = value;
        OrderModel.results.forEach((element) {
          setState(() {
            HistoryOrdersList.add(element);
          });
        });
        // ordersList=ordersList.reversed.toList();
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        gettingCurrentOrders();
      });
    });
  }

  gettingCurrentOrders() {
    setState(() {
      currentOrdersList.clear();

      Api(context, _scaffoldKey).ordersListApi().then((value) {
        OrderModel = value;
        OrderModel.results.forEach((element) {
          setState(() {
            currentOrdersList.add(element);
          });
        });
        // ordersList=ordersList.reversed.toList();
      });
      gettingHistoryData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawerList(),
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(
          getTranslated(context, "orders"),
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
        actions: [StaticUI().cartWidget(context)],
      ),
      body: currentOrdersList.length == 0
          ? StaticUI().NoDataFoundWidget(context)
          : Container(
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration.zero, () {
                    setState(() {
                      currentOrdersList = List();

                      gettingCurrentOrders();
                    });
                  });
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: currentOrdersList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemWidget(currentOrdersList[index]);
                          }),
SizedBox(height: 30,),
                      Container(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        alignment:translator.currentLanguage=='ar'? Alignment.centerRight:Alignment.centerLeft,
                        child: Text(getTranslated(context, "PreviousOrders"),
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 20,
                            )),
                      ),
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
                                width: MediaQuery.of(context).size.width / 1.45,
                                padding: const EdgeInsets.only(left: 20,right: 20),

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
                                height: 20,
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: HistoryOrdersList.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 20,right: 20),
                                      child: recentOrders(HistoryOrdersList[index].orderstatus=='canceled'?false:true,HistoryOrdersList[index]),
                                    );
                                  }),

                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
    );
  }
  Widget recentOrders(bool status,OrderItem orderItem) {
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
                  Text("${orderItem.id}",
                      style: TextStyle(
                        color: status == true ? greenAppColor : redColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 15,
                      )),
                  Text("${  orderItem.orderdatetime.toString().split("T")[0]}",
                      style: TextStyle(
                        color: status == true ? greenAppColor : redColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 15,
                      )),
                  Text(
                      // status == true
                      //     ?
                      orderItem.orderstatus,
                          // : getTranslated(context, "Canceled"),
                      style: TextStyle(
                        color: status == true ? greenAppColor : redColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 15,
                      )),
                  // orderItem.discountValue==null?Text("${orderItem.totalprice}"):   Text("${((orderItem.totalprice)-(orderItem.discountValue.toString()=="null"?0:orderItem.discountValue)) }",
                  Text("${ ((orderItem.totalprice??0)-( orderItem.discountValue??0))}",
                      style: TextStyle(
                        color: status == true ? greenAppColor : redColor,
                        fontWeight: FontWeight.w100,
                        fontSize: 15,
                      )),
                ],
              ),
            ),
            InkWell(onTap: (){
              navigateAndKeepStack(context, OrderDetails(orderItem));

            },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: status == true ? greenAppColor : redColor,
                ),
                child: Text(
                  getTranslated(context, "Details"),
                  style: TextStyle(color: whiteColor),
                ),
              ),
            )
          ],
        ),
        CustomDivider(),
      ],
    );
  }
  Widget ItemWidget(OrderItem orderItem){
    print("orderstatus:: ${ orderItem.orderstatus }");
 return   Card(
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
                Text("${orderItem.id}",
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
                Text(orderItem.orderstatus,
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
                  onTap: () {

                    navigateAndKeepStack(context, OrderDetails(orderItem));
                    // navigateAndClearStack(context, OrderDetailsScreen(orderItem));

                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: greenAppColor,
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    child: Text(
                        getTranslated(
                            context, "OrderDetails"),
                        style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 13,
                            color: whiteColor)),
                  ),
                ),
                Row(
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     navigateAndKeepStack(context, Cart());
                    //   },
                    //   child: Container(
                    //     padding: EdgeInsets.all(7),
                    //     decoration: BoxDecoration(
                    //         borderRadius:
                    //         BorderRadius.circular(5),
                    //         border:
                    //         Border.all(color: Colors.blue)),
                    //     alignment: Alignment.center,
                    //     child: Text(
                    //         getTranslated(context, "EditOrder"),
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w100,
                    //             fontSize: 13,
                    //             color: Colors.blue)),
                    //   ),
                    // ),
                    SizedBox(
                      width: 10,
                    ),
               orderItem.orderstatus != "done"&&    orderItem.orderstatus != "canceled"?
                    InkWell(
                      onTap: () {
                        Api(context, _scaffoldKey).cancelOrder(orderItem.id).then((value) {

                          if(value){

                            currentOrdersList.clear();
                            gettingCurrentOrders();

                          }
                        });

                      },
                      child: Icon(
                        Icons.delete_forever,
                        color: redColor,
                      ),
                    ):Container(),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        launch("tel:" + "${BaseStaticDataList[1].value}");


                      },
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
    );
  }


}
