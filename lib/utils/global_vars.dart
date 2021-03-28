import 'package:flutter/material.dart';
import 'package:gas_express/ui/Cart/CartModel.dart';
import 'package:gas_express/ui/HomeScreens/ProductsModel.dart';
import 'package:gas_express/ui/Orders/OrdersModel.dart';
import 'package:gas_express/ui/StaticDataModel.dart';
 import 'package:localize_and_translate/localize_and_translate.dart';

String imageUrl = 'http://18.188.206.243:8001';
List<CartModel> cartList=List();
int selectedAddressId;
String  selectedAddressString="";
List<OrderItem> BaseOrdersList = List();
List<ProductItem> baseProductsList = List();
List<ProductItem> baseNewProductsList = List();
List<ProductItem> baseReshargeProductsList = List();

List<StaticDataItem> BaseStaticDataList=List();
String getTranslated(BuildContext context, String key) {
  return translator.translate(key);
}
