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
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:gas_express/utils/static_ui.dart';
import 'package:gas_express/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OrdersModel OrderModel;
  List<OrderItem> ordersList = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        gettingData();
      });
    });
  }

  gettingData() {
    setState(() {
      ordersList.clear();

      Api(context, _scaffoldKey).ordersListApi().then((value) {
        OrderModel = value;
        OrderModel.results.forEach((element) {
          setState(() {
            ordersList.add(element);
          });
        });
        // ordersList=ordersList.reversed.toList();
      });
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
      body: ordersList.length == 0
          ? StaticUI().NoDataFoundWidget(context)
          : Container(
              child: RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration.zero, () {
                    setState(() {
                      ordersList = List();

                      gettingData();
                    });
                  });
                },
                child: ListView.builder(
                    // physics: NeverScrollableScrollPhysics(),
                    // shrinkWrap: true,
                    itemCount: ordersList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ItemWidget(ordersList[index]);
                    }),
              ),
            ),
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
                    orderItem.orderstatus =="new"?
                    InkWell(
                      onTap: () {
                        Api(context, _scaffoldKey).cancelOrder(orderItem.id).then((value) {

                          if(value){

                            ordersList.clear();
                            gettingData();

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
                    // InkWell(
                    //   onTap: () {},
                    //   child: Icon(
                    //     Icons.alternate_email,
                    //     color: Colors.blue,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  // Widget OrderWidget(OrderItem orderItem){
  //   return Padding(
  //     padding: EdgeInsets.only(left: 20,right: 20),
  //     child: Card(
  //       child: Container(
  //         child: Column(
  //           children: [
  //             Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //
  //             Text(getTranslated(context, 'orderNo'),style: TextStyle(color: Colors.red),),Text("${orderItem.id}",style: TextStyle(color: Colors.green),),
  //       ],),
  //
  //             SizedBox(height: 10,),
  //
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [                  Text(getTranslated(context, 'orderState'),style: TextStyle(color: Colors.green,),),
  //
  //                 Text("${orderItem.orderstatus}",style: TextStyle(color: Colors.red,fontSize: 20),),
  //               ],),
  //
  //             SizedBox(height: 10,),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 InkWell(onTap: (){
  //                   navigateAndClearStack(context, OrderDetailsScreen(orderItem));
  //
  //                 },
  //                   child: Container(
  //                       width: 100,height: 30,color: Colors.green,
  //                       child: Center(child: Text(getTranslated(context, 'OrderDetails'),style: TextStyle(color: Colors.white),))),
  //                 ),
  //
  //                 Icon(Icons.delete)
  //               ],),
  //
  //             SizedBox(height: 10,),
  //           ],
  //         ),),
  //     ),
  //   );
  // }

}
