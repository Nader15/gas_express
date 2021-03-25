import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/APiFunctions/sharedPref/SharedPrefClass.dart';
import 'package:gas_express/ui/Cart/CartModel.dart';
import 'package:gas_express/ui/Orders/OrdersScreen.dart';
import 'package:gas_express/ui/UserAddresses/my_addresses.dart';
import 'package:gas_express/utils/bottomSheet.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/custom_divider.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:gas_express/utils/static_ui.dart';
import 'package:gas_express/utils/toast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var total = 0;
  int productNo = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String delivaryTime;
  String Timeofreceipt;
  String DaySelected=translator.translate('Day');
bool FawreyCheck=false;
  List DaysList=["${DateTime.now().toIso8601String().split("T")[0]}","${DateTime.now().add(Duration(days: 1)).toIso8601String().split("T")[0]}","${DateTime.now().add(Duration(days: 2)).toIso8601String().split("T")[0]}","${DateTime.now().add(Duration(days: 3)).toIso8601String().split("T")[0]}"];
  List DaysListStrings=[translator.translate('Today'),
    translator.translate('Tomorrow'),
    translator.translate('AfterTomorrow'),
    translator.translate('AfterAfterTomorrow'),

  ];
  TextEditingController promoCodeController = TextEditingController();


  @override
  void initState() {
    
    print("DaysList:: ${DaysList}");
    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        delivaryTime = getTranslated(context, "DelivaryTime");
        Timeofreceipt = getTranslated(context, "Timeofreceipt");
      });
    });

    gettotoalCost();
    super.initState();
  }

  gettotoalCost() {
    productNo = 0;
    total = 0;
    cartList.forEach((element) {
      setState(() {
        productNo += element.quantity;
        total += (element.price * element.quantity);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: cartList.length == 0
          ? Container()
          : ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(greenAppColor),
              ),
              onPressed: () {
                if (selectedAddressString.isEmpty) {
                  FN_showToast(getTranslated(context, "pleaseAddAddress"),
                      context, Colors.red, _scaffoldKey);
                } else if (delivaryTime ==
                        getTranslated(context, "DelivaryTime") ||
                    Timeofreceipt == getTranslated(context, "Timeofreceipt")) {
                  FN_showToast(getTranslated(context, "pleaseSelectTime"),
                      context, Colors.red, _scaffoldKey);
                } else if (  DaySelected!=translator.translate('Day') ||
                        FawreyCheck==false) {
                  FN_showToast(getTranslated(context, "pleaseSelectDay"),
                      context, Colors.red, _scaffoldKey);
                }
                else {
                  List itemsList = List();
                  cartList.forEach((element) {
                    itemsList
                        .add({"quantity": element.quantity, "id": element.id});
                  });
                  Map data;
                  if(promoCodeController.text.isEmpty){
                    data    = {
                      "items": itemsList,
                      "date":                     FawreyCheck?  "${DateTime.now().toIso8601String().split("T")[0]}":DaySelected,

                      "timeStarts": "${Timeofreceipt}",
                      "timeEnds": "${delivaryTime}",
                      // "timeEnds": "${delivaryTime}",
                      "mobile": BasePhone ?? "12312233333",
                      "addressid": selectedAddressId,
                      "location": selectedAddressString,
                      "expecteddeliverdatename":
                      FawreyCheck?  "${DateTime.now().toIso8601String().split("T")[0]}":DaySelected,

                      // "expecteddeliverdatename": "string"
                    };
                  }
                  else {
                    data    = {
                      "items": itemsList,
                      "date":                     FawreyCheck?  "${DateTime.now().toIso8601String().split("T")[0]}":DaySelected,

                      "timeStarts": "${Timeofreceipt}",
                      "timeEnds": "${delivaryTime}",
                      // "timeEnds": "${delivaryTime}",
                      "mobile": BasePhone ?? "12312233333",
                      "addressid": selectedAddressId,
                      "location": selectedAddressString,
                      "expecteddeliverdatename":
                      FawreyCheck?  "${DateTime.now().toIso8601String().split("T")[0]}":DaySelected,
                      "coupon_code": "${promoCodeController.text.isEmpty}"

                      // "expecteddeliverdatename": "string"
                    };
                  }


                  print("data:::data ${data}");
                  Api(context, _scaffoldKey).addOrderApi(data).then((value) {

                    if(value){
                      setState(() {
                        cartList.clear();
                      });
                      navigateAndClearStack(context, OrdersScreen());

                    }
                  });
                }
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Text(
                  getTranslated(context, "confirm"),
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
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
            cartList.length == 0
                ? StaticUI().NoDataFoundWidget(context)
                : Align(
                    alignment: Alignment.topRight,
                    child: Column(
                      children: [
                        Card(
                          elevation: 10,
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
              height: 120,
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
                                  cartModel.quantity += 1;
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
                                if (cartModel.quantity == 0) {
                                  setState(() {
                                    cartList.remove(cartModel);
                                    gettotoalCost();
                                  });
                                } else if (cartModel.quantity > 0) {
                                  setState(() {
                                    cartModel.quantity -= 1;
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
                "${(cartModel.price) * cartModel.quantity} " +
                    getTranslated(context, "Currency"),
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
            InkWell(
              onTap: () {
                showRoundedModalBottomSheet(
                    autoResize: true,
                    dismissOnTap: false,
                    context: context,
                    radius: 30.0,
                    // This is the default
                    color: Colors.white,
                    // Also default
                    builder: (context) => addPromoCode());
              },
              child: Row(
                children: [
                  Container(
                    height: 22,
                    width: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: greenAppColor)),
                    child: Icon(
                      Icons.add,
                      color: greenAppColor,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(getTranslated(context, "AddCodeOrCoupon"),
                      style: _titleTextStyle),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            promoCodeController.text.isEmpty?Container():    Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${promoCodeController.text}",
                  style: TextStyle(color: greenAppColor, fontSize: 20),
                ),
                InkWell(
                  onTap: () {

                    setState(() {
                      promoCodeController.clear();
                    });
                  },
                  child: Icon(
                    Icons.delete_forever,
                    color: redColor,
                  ),
                ),
              ],
            ),
            CustomDivider(),
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
  Widget addPromoCode(){
    return Container(
      height: MediaQuery.of(context).size.height/3,
      child: Column(children: [
        SizedBox(height: 10,),
        Container(height: 1,color: Colors.grey,width: MediaQuery.of(context).size.width/2,),
        SizedBox(height: 10,),
        TextFormField(
          controller: promoCodeController,
          // enabled: false,
          decoration: InputDecoration(

              alignLabelWithHint: false,
              contentPadding: EdgeInsets.zero,
              hintStyle: TextStyle(color: Colors.black),
              hintText:  translator.translate('promoCode'),
              border: OutlineInputBorder()),
        ),
        SizedBox(height: 10,),

        TextButton(
            onPressed: () {

              if(promoCodeController.text.isEmpty){
                Navigator.of(context).pop();
              }
              else {
                Map data ={
                  "coupon_code":promoCodeController.text
                };
                Api(context, _scaffoldKey).checkCouponApi(data).then((value) {

if(value==false){
setState(() {
  promoCodeController.clear();

});}
                    Navigator.of(context).pop();
                    // Navigator.of(context).pop();


                });
              }
            },
            child: Text(
              getTranslated(context, "AddCodeOrCoupon"),
              style: TextStyle(
                  color: greenAppColor,
                  fontWeight: FontWeight.w100),
            )),
      ],),);
  }
  selectDaySheet(){
    return Container(
      height: MediaQuery.of(context).size.height/3,
      child: Column(children: [
        SizedBox(height: 10,),
      Container(height: 1,color: Colors.grey,width: MediaQuery.of(context).size.width/2,),
        SizedBox(height: 10,),

      Container(
        height: MediaQuery.of(context).size.height/4,
        child: ListView.builder(itemCount: DaysList.length,itemBuilder: (BuildContext context,int index){
          return InkWell(
            onTap: (){
              setState(() {
                DaySelected=DaysList[index];
                Navigator.of(context).pop();
              });
            },
            child: Column(
              children: [
                Container(child: Text("${DaysListStrings[index]} ${DaysList[index]}"),),
                Divider()
              ],
            ),
          );
        }),
      )

    ],),);
  }
  Widget delivery() {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
Row(children: [


  Checkbox(activeColor: greenAppColor,checkColor: primaryAppColor,value: FawreyCheck, onChanged: (value){
setState(() {
  FawreyCheck=!FawreyCheck;
    DaySelected=translator.translate('Day');

});
  }),
  Text(translator.translate('Fawrey'),style: TextStyle(color: Colors.black),),

],),
            SizedBox(height: 10,),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, "Day"),
                  style: TextStyle(color: greenAppColor, fontSize: 15),
                ),
                Row(
                  children: [


                    InkWell(
                      onTap: () {
                        if(FawreyCheck==false){
                          showRoundedModalBottomSheet(
                              autoResize: true,
                              dismissOnTap: false,
                              context: context,
                              radius: 30.0,
                              // This is the default
                              color: Colors.white,
                              // Also default
                              builder: (context) => selectDaySheet());
                        }


                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 30,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Center(child: Text(DaySelected))),
                      ),
                    ),
                  ],
                ),

              ],
            ),
SizedBox(height: 10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, "Time"),
                  style: TextStyle(color: greenAppColor, fontSize: 15),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        ).then((value) {
                          print(
                              "Timeofreceiptvalue::: ${value.format(context)}");
                          setState(() {
                            Timeofreceipt = value.format(context).split(" ")[0];
                          });
                        });
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        height: 30,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Center(child: Text(Timeofreceipt))),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        ).then((value) {
                          print(
                              "Timeofreceiptvalue::: ${value.format(context)}");
                          setState(() {
                            delivaryTime = value.format(context).split(" ")[0];
                          });
                        });
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        height: 30,
                        child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Center(child: Text(delivaryTime))),
                      ),
                    ),
                  ],
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

                InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyAddresses(false),
                      ),
                    ).then((value) {
                      setState(() {
                        selectedAddressId = selectedAddressId;
                        selectedAddressString = selectedAddressString;
                      });
                    });
                    // navigateAndKeepStack(context, AddAddress(value.latitude,value.longitude));
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: greenAppColor,
                        ),
                        Text(
                          selectedAddressString == null ||
                                  selectedAddressString.isEmpty
                              ? getTranslated(context, "pleaseAddAddress")
                              : selectedAddressString.length>25?selectedAddressString.substring(0,25)+"...":selectedAddressString,
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
