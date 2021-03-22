import 'package:flutter/material.dart';
import 'package:gas_express/ui/TestLocalCart/CartModel.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

String imageUrl = 'http://18.188.206.243:8001';
List<CartModel> cartList=List();



String getTranslated(BuildContext context, String key) {
  return translator.translate(key);
}
