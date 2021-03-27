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

import 'SuccessPromoCodeModel.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  dynamic total = 0;
  dynamic priceAfterPromoCode ;
  int productNo = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String delivaryTime;
  String Timeofreceipt;
  String DaySelected = translator.translate('Day');
  bool FawreyCheck = false;
  List DaysList = [
    "${DateTime.now().toIso8601String().split("T")[0]}",
    "${DateTime.now().add(Duration(days: 1)).toIso8601String().split("T")[0]}",
    "${DateTime.now().add(Duration(days: 2)).toIso8601String().split("T")[0]}",
    "${DateTime.now().add(Duration(days: 3)).toIso8601String().split("T")[0]}"
  ];
  List DaysListStrings = [
    translator.translate('Today'),
    translator.translate('Tomorrow'),
    translator.translate('AfterTomorrow'),
    translator.translate('AfterAfterTomorrow'),
  ];
  TextEditingController promoCodeController = TextEditingController();
  PromoCodeModelSuccess promoCodeModelSuccess;

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
          : Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 3.5,
                    decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.circular(5)),
                    alignment: Alignment.center,
                    child: Text(" ${total} " + getTranslated(context, "SR"),
                        style: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 18,
                            color: whiteColor)),
                  ),
                  InkWell(
                    onTap: () {
                      print("DaySelected:: ${DaySelected}");
                      if (selectedAddressString.isEmpty) {
                        FN_showToast(getTranslated(context, "pleaseAddAddress"),
                            context, Colors.red, _scaffoldKey);
                      } else if (delivaryTime ==
                              getTranslated(context, "DelivaryTime") ||
                          Timeofreceipt ==
                              getTranslated(context, "Timeofreceipt")) {
                        FN_showToast(getTranslated(context, "pleaseSelectTime"),
                            context, Colors.red, _scaffoldKey);
                      } else if (DaySelected == translator.translate('Day') &&
                          FawreyCheck == false) {
                        print("DaySelected:enterded }");

                        FN_showToast(getTranslated(context, "pleaseSelectDay"),
                            context, Colors.red, _scaffoldKey);
                      } else {
                        List itemsList = List();
                        cartList.forEach((element) {
                          itemsList.add(
                              {"quantity": element.quantity, "id": element.id});
                        });
                        Map data;
                        if (promoCodeController.text==null||promoCodeController.text.isEmpty) {
                          data = {
                            "items": itemsList,
                            "date": FawreyCheck
                                ? "${DateTime.now().toIso8601String().split("T")[0]}"
                                : DaySelected,

                            "timeStarts": "${Timeofreceipt}",
                            "timeEnds": "${delivaryTime}",
                            // "timeEnds": "${delivaryTime}",
                            "mobile": BasePhone ?? "12312233333",
                            "addressid": selectedAddressId,
                            "location": selectedAddressString,
                            "expecteddeliverdatename": FawreyCheck
                                ? "${DateTime.now().toIso8601String().split("T")[0]}"
                                : DaySelected,

                            // "expecteddeliverdatename": "string"
                          };
                        } else {
                          data = {
                            "items": itemsList,
                            "date": FawreyCheck
                                ? "${DateTime.now().toIso8601String().split("T")[0]}"
                                : DaySelected,

                            "timeStarts": "${Timeofreceipt}",
                            "timeEnds": "${delivaryTime}",
                            // "timeEnds": "${delivaryTime}",
                            "mobile": BasePhone ?? "12312233333",
                            "addressid": selectedAddressId,
                            "location": selectedAddressString,
                            "expecteddeliverdatename": FawreyCheck
                                ? "${DateTime.now().toIso8601String().split("T")[0]}"
                                : DaySelected,
                            "coupon_code": "${promoCodeController.text}"

                            // "expecteddeliverdatename": "string"
                          };
                        }

                        print("data:::data ${data}");
                        Api(context, _scaffoldKey)
                            .addOrderApi(data)
                            .then((value) {
                          if (value) {
                            setState(() {
                              cartList.clear();
                            });
                            navigateAndKeepStack(context, OrdersScreen());
                          }
                        });
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      alignment: Alignment.center,
                      child: Text(getTranslated(context, "confirm"),
                          style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 18,
                              color: whiteColor)),
                    ),
                  ),
                ],
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
            priceAfterPromoCode==null? Container():   Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated(context, "Discount"),
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  " ${priceAfterPromoCode} " + getTranslated(context, "SR"),
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 5,),
            Divider(),
            InkWell(
              onTap: () {
                alertDialogPromoCodeWidget();
          
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
            promoCodeController.text.isEmpty
                ? Container()
                : Row(
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
                            priceAfterPromoCode=null;
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

          ],
        ),
      ),
    );
  }


  alertDialogPromoCodeWidget() {
    String errorMessage = "";
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (
          context,
        ) {
          return StatefulBuilder(
            builder: (context, State) {
              return AlertDialog(
                elevation: 4.0,
                shape: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.withOpacity(.5),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                titlePadding: EdgeInsets.all(15.0),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        translator.translate('addPromoCode'),
                        textScaleFactor: 1,
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    new Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: new Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: new TextField(

                        // textAlign: TextAlign.center,
                        controller: promoCodeController,
                        onChanged: (value) {
                          State(() {
                            errorMessage = "";
                            // promoCodeController.text = promoCodeController.text;
                          });
                        },
                        decoration: new InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20,right: 20),
                          hintText: translator.translate('promoCode'),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        alignment: translator.currentLanguage == 'ar'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Text(
                          errorMessage,
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          if (promoCodeController.text != null ||
                              promoCodeController.text.isNotEmpty) {
                            Map data = {
                              "coupon_code": promoCodeController.text
                            };
                            Api(context, _scaffoldKey)
                                .checkCouponApi(data)
                                .then((value) {
                              print("valuevalue ${value}");
                              if (value is PromoCodeModelSuccess) {
                                promoCodeModelSuccess=value;
                                setState(() {
                                  if(promoCodeModelSuccess.discountValue!=null){
                                    priceAfterPromoCode=total-promoCodeModelSuccess.discountValue;
                                  }
                                  else {
                                    priceAfterPromoCode=total-((total/100)*promoCodeModelSuccess.discountPercentage);

                                  }
                                  print("totaltotaltotal  ${priceAfterPromoCode}");

                                });
                                Navigator.of(context).pop();
                              } else {
                                State(() {

                                  errorMessage =
                                      translator.translate('inValidPromoCode');
                                });
                              }
                              // Navigator.of(context).pop();
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: promoCodeController.text == null ||
                                      promoCodeController.text.isEmpty
                                  ? grey
                                  : primaryAppColor),
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 40,
                          child: Center(
                              child: Text(
                            translator.translate('apply'),
                            textScaleFactor: 1,
                            style: TextStyle(color: Colors.white),
                          )),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: () {
setState(() {
  promoCodeController.clear();

});
                          Navigator.pop(context);
                        },
                        child: Text(
                          translator.translate('Cancel'),
                          textScaleFactor: 1,
                          style: TextStyle(
                              color: primaryAppColor,
                              decoration: TextDecoration.underline,
                              fontSize: 12),
                        ))
                  ],
                ),
              );
            },
          );
        });
  }

  selectDaySheet() {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            color: Colors.grey,
            width: MediaQuery.of(context).size.width / 2,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 4,
            child: ListView.builder(
                itemCount: DaysList.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        DaySelected = DaysList[index];
                        Navigator.of(context).pop();
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                              "${DaysListStrings[index]} ${DaysList[index]}"),
                        ),
                        Divider()
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget delivery() {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  translator.translate('Fawrey'),
                  style: TextStyle(color: Colors.black),
                ),
                Checkbox(
                    activeColor: greenAppColor,
                    checkColor: primaryAppColor,
                    value: FawreyCheck,
                    onChanged: (value) {
                      setState(() {
                        FawreyCheck = !FawreyCheck;
                        DaySelected = translator.translate('Day');
                      });
                    }),
              ],
            ),

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
                        if (FawreyCheck == false) {
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
                        width: MediaQuery.of(context).size.width / 1.55,
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
            SizedBox(
              height: 10,
            ),
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

                    Container(

                        child: Center(child: Text(translator.translate('from')))),

                    SizedBox(width: 5,),
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
                    Container(

                        child: Center(child: Text(translator.translate('to')))),
                    SizedBox(
                      width: 5,
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
                    width: MediaQuery.of(context).size.width / 1.55,

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
                              : selectedAddressString.length > 25
                                  ? selectedAddressString.substring(0, 25) +
                                      "..."
                                  : selectedAddressString,
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
