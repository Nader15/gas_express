import 'package:flutter/material.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/ui/Wallet/BallanceModel.dart';
import 'package:gas_express/ui/Wallet/PointsModel.dart';
import 'package:gas_express/ui/Wallet/PromoCodeModel.dart';
import 'package:gas_express/utils/bottomSheet.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/custom_divider.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/static_ui.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class MyWallet extends StatefulWidget {
  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  PromoCodeModel promoCodeModel;
  List<PromoCodeItem> promoCodeList=List();
  List<PointItem> pointItemList=List();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController promoCodeController = TextEditingController();
  BallanceModel ballanceModel;
  PointsModel pointsModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        XsProgressHud.show(context);

        gettingData();
      });
    });
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
                    Container(
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

                          if(promoCodeController.text.isEmpty){
                            Navigator.of(context).pop();
                          }
                          else {
                            Map data ={
                              "coupon_code":promoCodeController.text
                            };
                            Api(context, _scaffoldKey).addPromoCodeApi(data).then((value) {
                              if(value){
                                setState(() {
                                  promoCodeList.clear();
                                  promoCodeController.clear();
                                });
                                Navigator.of(context).pop();
                                gettingData();
                              }
                              else {
                                Navigator.of(context).pop();

                              }
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
                                translator.translate('addPromoCode'),
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

  gettingData() {
    setState(() {
      promoCodeList.clear();

      Api(context, _scaffoldKey)
          .getUserPromoCodeApi()
          .then((value) {
        promoCodeModel = value;
        promoCodeModel.results.forEach((element) {
          setState(() {
            promoCodeList.add(element);


          });
        });
        gettingBallance();
      });
    });
  }
  gettingBallance() {
    setState(() {

      Api(context, _scaffoldKey)
          .getBallanceApi()
          .then((value) {
setState(() {
  ballanceModel = value;

});
gettingPoints();
      });
    });
  }
  gettingPoints() {
    setState(() {

      Api(context, _scaffoldKey)
          .getUserCountApi()
          .then((value) {
setState(() {
  pointsModel = value;
pointsModel.data.forEach((element) {
  setState(() {
    pointItemList.add(element);
  });
});
});
XsProgressHud.hide();
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
        title: Text(getTranslated(context, "MyWallet"),
            style: TextStyle(fontWeight: FontWeight.w100)),
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
  Api(context, _scaffoldKey).addPromoCodeApi(data).then((value) {
    if(value){
    setState(() {
      promoCodeList.clear();
      promoCodeController.clear();
    });
      Navigator.of(context).pop();
      gettingData();
    }
    else {
      Navigator.of(context).pop();

    }
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
  Form _mainForm(BuildContext context) {
    return Form(
      key: _key,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getTranslated(context, "YourBalance"),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w100),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      ballanceModel==null?"":   "${ballanceModel.balance??""}",
                                      style: TextStyle(
                                          fontSize: 40,
                                          color: greenAppColor,
                                          fontWeight: FontWeight.w100),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      getTranslated(context, "SR"),
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: greenAppColor,
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              // FlatButton(
                              //     onPressed: () {},
                              //     child: Row(
                              //       crossAxisAlignment: CrossAxisAlignment.start,
                              //       mainAxisAlignment: MainAxisAlignment.start,
                              //       children: [
                              //         Container(
                              //           height: 22,
                              //           width: 22,
                              //           alignment: Alignment.center,
                              //           decoration: BoxDecoration(
                              //               shape: BoxShape.circle,
                              //               border:
                              //                   Border.all(color: greenAppColor)),
                              //           child: Icon(
                              //             Icons.add,
                              //             color: greenAppColor,
                              //             size: 20,
                              //           ),
                              //         ),
                              //         SizedBox(
                              //           width: 10,
                              //         ),
                              //         Text(
                              //           getTranslated(context, "AddCredit"),
                              //           style: TextStyle(
                              //               color: greenAppColor,
                              //               fontWeight: FontWeight.w100),
                              //         ),
                              //       ],
                              //     )),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      getTranslated(context, "DiscountCodes"),
                                      style: TextStyle(
                                          fontSize: 20, fontWeight: FontWeight.w100),
                                    ),
                                    Text(
                                      getTranslated(context, "ExpiryDate"),
                                      style: TextStyle(
                                          color: greenAppColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w100),
                                    ),
                                    Text(
                                      getTranslated(context, "Value"),
                                      style: TextStyle(
                                          color: greenAppColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              promoCodeList.length==0?Text( getTranslated(context, "noDataFound")):     ListView.builder(physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,itemCount: promoCodeList.length,itemBuilder: (BuildContext context,int index){
                              return Column(children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${promoCodeList[index].couponCode}",
                                      style: TextStyle(
                                          color: greenAppColor, fontSize: 20),
                                    ),
                                    Text(
                                    promoCodeList[index].expiryDate==null?"----":  promoCodeList[index].expiryDate.split("T")[0],
                                      // "${promoCodeList[index].expiryDate.split("T")[0]}",
                                      style: TextStyle(
                                          color: greenAppColor, fontSize: 20),
                                    ),
                                    Text(
                                      promoCodeList[index].discountPercentage==null? "${promoCodeList[index].discountValue} ${translator.translate('Currency')}":
                                      "${promoCodeList[index].discountPercentage}%",
                                      style: TextStyle(
                                          color: greenAppColor, fontSize: 20),
                                    ),
                                  ],
                                ),
                                CustomDivider(),
                              ],);
                            }),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //   crossAxisAlignment: CrossAxisAlignment.end,
                                //   children: [
                                //     Text(
                                //       "BO2RT1",
                                //       style: TextStyle(
                                //           color: greenAppColor, fontSize: 20),
                                //     ),
                                //     Text(
                                //       "1/2/2022",
                                //       textDirection: TextDirection.rtl,
                                //       style: TextStyle(
                                //           color: greenAppColor, fontSize: 20),
                                //     ),
                                //     Text(
                                //       "10ريال",
                                //       style: TextStyle(
                                //           color: greenAppColor, fontSize: 20),
                                //     ),
                                //   ],
                                // ),
                                // CustomDivider(),
                                TextButton(
                                    onPressed: () {
                                      alertDialogPromoCodeWidget();
                                      // showRoundedModalBottomSheet(
                                      //     autoResize: true,
                                      //     dismissOnTap: false,
                                      //     context: context,
                                      //     radius: 30.0,
                                      //     // This is the default
                                      //     color: Colors.white,
                                      //     // Also default
                                      //     builder: (context) => addPromoCode());

                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 22,
                                          width: 22,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border:
                                                  Border.all(color: greenAppColor)),
                                          child: Icon(
                                            Icons.add,
                                            color: greenAppColor,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          getTranslated(context, "AddCodeOrCoupon"),
                                          style: TextStyle(
                                              color: greenAppColor,
                                              fontWeight: FontWeight.w100),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),

                      pointItemList.length==0?Container():     ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: pointItemList.length,
                        itemBuilder: (context, index) {
                          return   Card(
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    getTranslated(context, "FreeExchange"),
                                    style: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w100),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "${translator.translate('message1')} ${pointItemList[index].countToReach} ${translator.translate('message2')} ${(pointItemList[index].duration/30).round()} ${translator.translate('message3')} ",
                                    style: TextStyle(fontWeight: FontWeight.w100),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${pointItemList[index].userUsage}/${pointItemList[index].countToReach}",
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: greenAppColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          getTranslated(context, "Balance"),
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: greenAppColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
