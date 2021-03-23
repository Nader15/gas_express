import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/APiFunctions/sharedPref/SharedPrefClass.dart';
import 'package:gas_express/ui/Orders/OrderDetails.dart';
import 'package:gas_express/ui/Orders/OrdersModel.dart';
import 'package:gas_express/ui/TestLocalCart/CartModel.dart';
import 'package:gas_express/ui/UserAddresses/my_addresses.dart';
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

      Api(context, _scaffoldKey).ordersListApi(_scaffoldKey).then((value) {
        OrderModel = value;
        OrderModel.results.forEach((element) {
          setState(() {
            ordersList.add(element);
          });
        });
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
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: ordersList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OrderWidget(ordersList[index]);
                  }),
            ),
    );
  }
  Widget OrderWidget(OrderItem orderItem){
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20),
      child: Card(
        child: Container(
          child: Column(
            children: [
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

              Text(getTranslated(context, 'orderNo'),style: TextStyle(color: Colors.red),),Text("${orderItem.id}",style: TextStyle(color: Colors.green),),
        ],),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [                  Text(getTranslated(context, 'orderState'),style: TextStyle(color: Colors.green,),),

                  Text("${orderItem.orderstatus}",style: TextStyle(color: Colors.red,fontSize: 20),),
                ],),

              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(onTap: (){
                    navigateAndClearStack(context, OrderDetailsScreen(orderItem));

                  },
                    child: Container(
                        width: 100,height: 30,color: Colors.green,
                        child: Center(child: Text(getTranslated(context, 'OrderDetails'),style: TextStyle(color: Colors.white),))),
                  ),

                  Icon(Icons.delete)
                ],),

              SizedBox(height: 10,),
            ],
          ),),
      ),
    );
  }
  // Widget OrderWidget(OrderItem orderItem) {
  //   return Card(
  //     child: ListTile(
  //       title: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             orderItem.id.toString(),
  //             style: TextStyle(color: Colors.red),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Text(
  //             orderItem.addressname.toString(),
  //             style: TextStyle(color: Colors.green),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           InkWell(
  //             onTap: () {
  //               launch("tel:" + "${orderItem.mobile}");
  //             },
  //             child: Row(
  //               children: [
  //                 Icon(Icons.call),
  //                 Text(
  //                   orderItem.mobile ?? "".toString(),
  //                   style: TextStyle(color: Colors.black),
  //                 ),
  //               ],
  //             ),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Row(
  //             children: [
  //               Text(
  //                 getTranslated(context, "DelivaryTime"),
  //                 style: TextStyle(color: Colors.red),
  //               ),
  //               Text(
  //                 orderItem.orderdatetime.toString(),
  //                 style: TextStyle(color: Colors.red),
  //               ),
  //             ],
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Row(
  //             children: [
  //               Container(
  //                 width: 100,height: 50,
  //                 decoration: BoxDecoration(color: Colors.green),
  //                 child: Text(
  //                   getTranslated(context, "OrderDetails"),
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //               ),
  //               SizedBox(width: 20,),
  //               Container(
  //                 width: 50,height: 50,
  //                 decoration: BoxDecoration(color: Colors.red),
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                       orderItem.totalprice.toString(),
  //                       style: TextStyle(color: Colors.white),
  //                     ),
  //                     Text(
  //                       getTranslated(context, "SR"),
  //                       style: TextStyle(color: Colors.white),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //
  //             ],
  //           ),
  //         ],
  //       ),
  //       leading: Image.asset(
  //         "assets/images/googlemap.jpeg",
  //         width: 100,
  //         height: 100,
  //         fit: BoxFit.cover,
  //       ),
  //     ),
  //   );
  // }
}
