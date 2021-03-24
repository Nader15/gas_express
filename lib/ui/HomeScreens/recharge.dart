import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/ui/HomeScreens/AddButtonWidget.dart';
import 'package:gas_express/ui/HomeScreens/BannersModel.dart';
import 'package:gas_express/ui/HomeScreens/ProductsModel.dart';
import 'package:gas_express/ui/Orders/OrdersScreen.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:gas_express/utils/static_ui.dart';

import 'package:localize_and_translate/localize_and_translate.dart';

class Recharge extends StatefulWidget {
  List<BannerItem> bannersList;


  Recharge(this.bannersList);
  @override
  _RechargeState createState() => _RechargeState();
}

class _RechargeState extends State<Recharge> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProductsModel productsModel;
  List<ProductItem> productsList = List();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(Duration(milliseconds: 0), () {
      getProducts();
    });
    super.initState();
  }

  getProducts() {
    Api(context, _scaffoldKey).getProducts(filterName: "refill").then((value) {
      productsModel = value;
      productsModel.results.forEach((element) {
        setState(() {
          productsList.add(element);
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: InkWell(
            onTap: (){
              navigateAndKeepStack(context, OrdersScreen());

            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: redColor, borderRadius: BorderRadius.circular(5)),
              alignment: Alignment.center,
              child: Text(getTranslated(context, "OrderStatus"),
                  style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 18,
                      color: whiteColor)),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [

                CarouselSlider(
                  options: CarouselOptions(height: 200.0),
                  items: widget.bannersList.map((i) {
                    return Builder(
                      builder: (BuildContext context) {

                        print("imageimage:: ${i.image}");
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),

                            child: Image.network(i.image,fit: BoxFit.cover,)
                        );
                      },
                    );
                  }).toList(),
                ),
                productsList.length==0?StaticUI().NoDataFoundWidget(context):    GridView.builder(
                  itemCount: productsList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .7,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border: Border.all(color: greenAppColor)),
                              child: Text(
                                " ${productsList[index].unitprice} " +
                                    getTranslated(context, "Currency"),
                                // "15.5 " + getTranslated(context, "Currency"),
                                style: TextStyle(color: greenAppColor),
                              ),
                            ),
                            Center(
                              child: productsList[index].imageurl == null ||
                                  productsList[index].imageurl.isEmpty
                                  ? Image.asset(
                                "assets/images/tube.png",
                                width: 90,
                              )
                                  : Image.network(
                                productsList[index].photoUrl,
                                height: 90,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(translator.currentLanguage == 'ar'
                                    ? productsList[index].productnameAr
                                    : "${productsList[index].productnameEn}"),
                                // Text("منظم غاز 50 مل بار"),
                                // ElevatedButton(
                                //   style: ButtonStyle(
                                //     backgroundColor: MaterialStateProperty.all<Color>(
                                //         greenAppColor),
                                //   ),
                                //   onPressed: () {
                                //     Api(context, _scaffoldKey).   checkItemsInCart(productsList[index]);
                                //
                                //   },
                                //   child: Container(
                                //     alignment: Alignment.center,
                                //     width: MediaQuery.of(context).size.width,
                                //     child: Text(
                                //       getTranslated(context, "Add"),
                                //       style: TextStyle(fontWeight: FontWeight.w100),
                                //     ),
                                //   ),
                                // ),
                                Container(
                                    height: 40,
                                    margin: EdgeInsets.only(top: 20),
                                    child: AddButtonWidget(productsList[index]))
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ));  }
}
