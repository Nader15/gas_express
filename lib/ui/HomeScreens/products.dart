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

class Products extends StatefulWidget {
  List<BannerItem> bannersList;

  Products(this.bannersList);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ProductsModel productsModel;
  List<ProductItem> productsList = List();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(Duration(milliseconds: 0), () {
      if(baseProductsList.length==0){
        getProducts();

      }
    });
    super.initState();
  }

  getProducts() {
    Api(context, _scaffoldKey).getProducts(filterName: "product").then((value) {
      productsModel = value;
      productsModel.results.forEach((element) {
        setState(() {
          productsList.add(element);
          baseProductsList.add(element);
        });
      });

      print("productsList::: ${productsList}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: StaticUI().bottomNavWiget(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  enlargeCenterPage: true,
                  viewportFraction: 16 / 9,
                ),
                items: widget.bannersList.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          child: Image.network(
                            i.image,
                            fit: BoxFit.fill,
                          ));
                    },
                  );
                }).toList(),
              ),
              SizedBox(height: 5,),
              BaseStaticDataList[5].show==false||BaseStaticDataList[5].value.isEmpty?Container():  Container(
                color: primaryAppColor,
                child: ListTile(
                  leading: InkWell(
                    onTap: (){
                    setState(() {
                      BaseStaticDataList[5].show=!BaseStaticDataList[5].show;
                    });
                    },
                    child: Icon(
                      Icons.clear,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    "${translator.currentLanguage == 'ar' ? BaseStaticDataList[5].value : BaseStaticDataList[4].value}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 5,),

              baseProductsList.length == 0
                  ? StaticUI().NoDataFoundWidget(context)
                  : GridView.builder(
                      itemCount: baseProductsList.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .6,
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
                                    " ${baseProductsList[index].unitprice} " +
                                        getTranslated(context, "Currency"),
                                    // "15.5 " + getTranslated(context, "Currency"),
                                    style: TextStyle(color: greenAppColor),
                                  ),
                                ),
                                Center(
                                  child: baseProductsList[index].imageurl == null ||
                                      baseProductsList[index].imageurl.isEmpty
                                      ? Image.asset(
                                          "assets/images/tube.png",
                                          width: 90,
                                        )
                                      : Image.network(
                                    baseProductsList[index].photoUrl,
                                          height: 80,
                                        ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(translator.currentLanguage == 'ar'
                                        ? baseProductsList[index].productnameAr
                                        : "${baseProductsList[index].productnameEn}"),
                                    // Text("منظم غاز 50 مل بار"),

                                    Container(
                                        height: 40,
                                        margin: EdgeInsets.only(top: 20),
                                        child: AddButtonWidget(
                                            baseProductsList[index]))

                                    // Row(children: [
                                    //   Expanded(child: Container(color: Colors.green,width: 30,height: 30,child: Center(child: Text("-")),)),
                                    //
                                    //   Expanded(child: Container(width: 50,height: 50,child: Center(child: Text("2")),)),
                                    //   Expanded(child: Container(color: Colors.green,width: 30,height: 30,child: Center(child: Text("+")),)),
                                    //
                                    // ],),
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
        ));
  }
}
