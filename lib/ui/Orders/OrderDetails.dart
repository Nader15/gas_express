import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/APiFunctions/sharedPref/SharedPrefClass.dart';
import 'package:gas_express/ui/Orders/OrdersModel.dart';
 import 'package:gas_express/ui/UserAddresses/my_addresses.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/custom_divider.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:gas_express/utils/static_ui.dart';
import 'package:gas_express/utils/toast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class OrderDetailsScreen extends StatefulWidget {
  OrderItem orderItem;

  OrderDetailsScreen(this.orderItem);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        color: Colors.red,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(right: 20, left: 20, top: 20),
              alignment: Alignment.centerRight,
              child: Text(
                getTranslated(context, 'Total'),
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              widget.orderItem.totalprice.toString(),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
      key: _scaffoldKey,
      drawer: drawerList(),
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(
          getTranslated(context, "OrderDetails"),
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
        actions: [StaticUI().cartWidget(context)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              color: Colors.red,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 20, left: 20, top: 20),
                    alignment: Alignment.centerRight,
                    child: Text(
                      getTranslated(context, 'orderState'),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.orderItem.orderstatus,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  getTranslated(context, 'orderNo'),
                  style: TextStyle(color: Colors.red),
                ),
                Text(
                  "${widget.orderItem.id}",
                  style: TextStyle(color: Colors.green),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.orderItem.orderproductDetails.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      OrderWidget(widget.orderItem.orderproductDetails[index]),
                      Divider()
                    ],
                  );
                }),

SizedBox(height: 130,)

          ],
        ),
      ),
    );
  }

  Widget OrderWidget(OrderproductDetails orderproductDetails){
return Container(
  padding: EdgeInsets.only(left: 20,right: 20),
  child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,crossAxisAlignment: CrossAxisAlignment.center,children: [
  Expanded(child: Text(translator.currentLanguage=='ar'?orderproductDetails.productnameAr:orderproductDetails.productnameEn)),

  Expanded(child: Text(orderproductDetails.quantity.toString())),
  Expanded(child:Image.network(orderproductDetails.photo,height: 100,width: 20,)),
],),);
  }
}
