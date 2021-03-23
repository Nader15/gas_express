import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/APiFunctions/sharedPref/SharedPrefClass.dart';
import 'package:gas_express/ui/Cart/CartModel.dart';
 import 'package:gas_express/ui/UserAddresses/my_addresses.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/custom_divider.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:gas_express/utils/static_ui.dart';
import 'package:gas_express/utils/toast.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var total=0;
  int productNo=0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String delivaryTime;
  String Timeofreceipt;
  @override
  void initState() {
    setState(() {
      delivaryTime=getTranslated(context, "DelivaryTime");
      Timeofreceipt=getTranslated(context, "Timeofreceipt");
    });
    gettotoalCost();
    super.initState();
  }

  gettotoalCost(){
    productNo=0;
    total=0;
  cartList.forEach((element) {
    setState(() {

      productNo+=element.quantity;
      total+=  (  element.price* element.quantity);

    });
  });

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton:  cartList.length==0?Container(): ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              greenAppColor),
        ),
        onPressed: () {
if(selectedAddressString.isEmpty){
  FN_showToast(
      getTranslated(context, "pleaseAddAddress"), context, Colors.red, _scaffoldKey);
}else if(delivaryTime==getTranslated(context, "DelivaryTime")|| Timeofreceipt==getTranslated(context, "Timeofreceipt")){


  FN_showToast(
      getTranslated(context, "pleaseSelectTime"), context, Colors.red, _scaffoldKey);
}

else {  List itemsList=List();
cartList.forEach((element) {
  itemsList.add({"quantity":element.quantity,
    "id":element.id
  });

});

Map data={
  "items": itemsList,
  "date": "${DateTime.now().toIso8601String().split("T")[0]}",
  "timeStarts": "${Timeofreceipt}",
  "timeEnds": "${delivaryTime}",
  // "timeEnds": "${delivaryTime}",
  "mobile": BasePhone??"12312233333",
  "addressid": selectedAddressId,
  "location": selectedAddressString,
  "expecteddeliverdatename": "string"
};

print("data:::data ${data}");
Api(context, _scaffoldKey).addOrderApi(data).then((value) {


});
}
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 75,
          child: Text(
            getTranslated(context, "confirm"),
            style: TextStyle(fontWeight: FontWeight.w400,fontSize: 20),
          ),
        ),
      ),
      drawer: drawerList(),
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(
          getTranslated(context, "cart"),
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
        actions: [
          StaticUI().cartWidget(context)
        ],
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
            cartList.length==0?StaticUI().NoDataFoundWidget(context):   Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: [
                    Card(
                      elevation:10,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: cartList.length,
                          itemBuilder: (context, index) {
                            return order(cartList[index]);
                          },
                        ),
                      ),
                    ),
                    details(),
                    delivery()
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
  Widget order(CartModel cartModel) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/new_tube.png",
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartModel.name,
                  style: TextStyle(color: greenAppColor),
                ),
                Row(
                  children: [
                    Container(
                        height: 22,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: greenAppColor)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
setState(() {
  cartModel.quantity+=1;
  gettotoalCost();
});
                              },
                              child: Icon(
                                Icons.add,
                                color: greenAppColor,
                                size: 20,
                              ),
                            ),
                            Text(
                              "${cartModel.quantity}",
                              style: TextStyle(color: greenAppColor),
                            ),
                            InkWell(
                              onTap: () {
                                if(cartModel.quantity==0){
                                  setState(() {
                                    cartList.remove(cartModel);
                                    gettotoalCost();
                                  });
                                }
                                else if(cartModel.quantity>0){
                                  setState(() {
                                    cartModel.quantity-=1;
                                    gettotoalCost();
                                  });
                                }

                              },
                              child: Icon(
                                Icons.remove,
                                color: greenAppColor,
                                size: 20,
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          cartList.remove(cartModel);
                        });
                      },
                      child: Icon(
                        Icons.delete_forever,
                        color: redColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(5),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: greenAppColor)),
              child: Text(
                "${(cartModel.price)*cartModel.quantity} " + getTranslated(context, "Currency"),
                style: TextStyle(color: greenAppColor),
              ),
            ),
          ],
        ),
        CustomDivider()
      ],
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
                  "${total} " + getTranslated(context, "SR"),
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
                  " ${total} " + getTranslated(context, "SR"),
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            // InkWell(
            //   onTap: () {},
            //   child: Row(
            //     children: [
            //       Container(
            //         height: 22,
            //         width: 22,
            //         alignment: Alignment.center,
            //         decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             border: Border.all(color: greenAppColor)),
            //         child: Icon(
            //           Icons.add,
            //           color: greenAppColor,
            //           size: 20,
            //         ),
            //       ),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Text(getTranslated(context, "AddCodeOrCoupon"),
            //           style: _titleTextStyle),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "XKFON",
            //       style: TextStyle(color: greenAppColor, fontSize: 20),
            //     ),
            //     InkWell(
            //       onTap: () {},
            //       child: Icon(
            //         Icons.delete_forever,
            //         color: redColor,
            //       ),
            //     ),
            //   ],
            // ),
            // CustomDivider(),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         Icon(
            //           Icons.radio_button_unchecked,
            //           color: greenAppColor,
            //         ),
            //         SizedBox(
            //           width: 10,
            //         ),
            //         Text(
            //           getTranslated(context, "AvailableBalance"),
            //           style: TextStyle(color: greenAppColor, fontSize: 20),
            //         ),
            //       ],
            //     ),
            //     Text(
            //       "7.86 " + getTranslated(context, "SR"),
            //       style: TextStyle(color: greenAppColor, fontSize: 20),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget delivery() {
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
                  getTranslated(context, "Appointment"),
                  style: TextStyle(color: greenAppColor, fontSize: 15),
                ),
                Row(
                  children: [
                    InkWell(onTap: ()async{
                  showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      ).then((value) {
                        print("Timeofreceiptvalue::: ${value.format(context)}");
setState(() {
  Timeofreceipt=value.format(context).split(" ")[0];
});
                  });
                    },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        height: 30,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child: Text(Timeofreceipt)),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(onTap: (){
                      showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      ).then((value) {
                        print("Timeofreceiptvalue::: ${value.format(context)}");
                        setState(() {
                          delivaryTime=value.format(context).split(" ")[0];
                        });
                      });
                    },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 4,
                        height: 30,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)
                            ),
                            child: Text(delivaryTime)),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.check_box,
                  color: greenAppColor,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, "Location"),
                  style: TextStyle(color: greenAppColor, fontSize: 15),
                ),

                InkWell(onTap: (){
                  navigateAndKeepStack(context, MyAddresses());

                },
                  child: Container(
                     decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                    ),
                    child: Row(
                      children: [
                    Icon(
                              Icons.location_on,
                              color: greenAppColor,
                            ),

                        Text(
                          selectedAddressString.isEmpty?getTranslated(context, "pleaseAddAddress"):selectedAddressString,
                          style: TextStyle(color: greenAppColor, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width / 1.7,
                //   height: 30,
                //   child: TextFormField(
                //     onTap: (){
                //       if(selectedAddressString.isEmpty){
                //         navigateAndKeepStack(context, MyAddresses());
                //       }
                //     },
                //     // enabled: false,
                //     decoration: InputDecoration(
                //         prefixIcon: selectedAddressString.isEmpty?Container():
                //         Icon(
                //           Icons.location_on,
                //           color: greenAppColor,
                //         ),
                //         alignLabelWithHint: false,
                //         contentPadding: EdgeInsets.zero,
                //         hintStyle: TextStyle(color: Colors.black),
                //         hintText: selectedAddressString.isEmpty?getTranslated(context, "pleaseAddAddress"):selectedAddressString,
                //         border: OutlineInputBorder()),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle _titleTextStyle =
TextStyle(color: greenAppColor, fontSize: 15, fontWeight: FontWeight.w100);


