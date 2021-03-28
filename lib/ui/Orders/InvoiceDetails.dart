import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/APiFunctions/sharedPref/SharedPrefClass.dart';
import 'package:gas_express/ui/Cart/CartModel.dart';
import 'package:gas_express/ui/Orders/OrdersModel.dart';
import 'package:gas_express/ui/Orders/OrdersScreen.dart';
import 'package:gas_express/ui/UserAddresses/my_addresses.dart';
import 'package:gas_express/utils/bottomSheet.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/custom_divider.dart';
import 'package:gas_express/ui/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:gas_express/utils/static_ui.dart';
import 'package:gas_express/utils/toast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class InvoiceDetails extends StatefulWidget {
  OrderItem orderItem;

  InvoiceDetails(this.orderItem);

  @override
  _InvoiceDetailsState createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var productNo=0;

  @override
  void initState() {
    for (int x = 0; x < widget.orderItem.orderproductDetails.length; x++) {
      setState(() {
        productNo += widget.orderItem.orderproductDetails[x].quantity;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawerList(),
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(
          getTranslated(context, "InvoiceDetails"),
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
        actions: [StaticUI().cartWidget(context)],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
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
                    details(),
                  ],
                )),
            SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }

  Widget details() {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, "ProductsValue"),
                  style: TextStyle(color: greenAppColor, fontSize: 20),
                ),
                Text(
                  "${productNo}",
                  style: TextStyle(color: greenAppColor, fontSize: 20),
                ),
                Text(
                  "${widget.orderItem.totalprice} " +
                      getTranslated(context, "SR"),
                  style: TextStyle(color: greenAppColor, fontSize: 20),
                ),
              ],
            ),
            CustomDivider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, "deliveryValue"),
                  style: TextStyle(color: greenAppColor, fontSize: 20),
                ),
                Text(
                  "0 " + getTranslated(context, "SR"),
                  style: TextStyle(color: greenAppColor, fontSize: 20),
                ),
              ],
            ),
            CustomDivider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, "Tax"),
                  style: TextStyle(color: greenAppColor, fontSize: 20),
                ),
                Text(
                  "0 %",
                  style: TextStyle(color: greenAppColor, fontSize: 20),
                ),
                Text(
                  "0 " + getTranslated(context, "SR"),
                  style: TextStyle(color: greenAppColor, fontSize: 20),
                ),
              ],
            ),
            CustomDivider(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, "Total"),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  " ${widget.orderItem.totalprice} " +
                      getTranslated(context, "SR"),
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            widget.orderItem.discountValue==null||  widget.orderItem.discountValue==0?Container():

            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, "promoCode"),
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      " ${widget.orderItem.couponCode } "  ,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getTranslated(context, "Discount"),
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      " ${(widget.orderItem.totalprice ?? 0) - (widget.orderItem.discountValue ?? 0)} " +
                          getTranslated(context, "SR"),
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            CustomDivider(),
          ],
        ),
      ),
    );
  }
}

TextStyle _titleTextStyle =
    TextStyle(color: greenAppColor, fontSize: 15, fontWeight: FontWeight.w100);
