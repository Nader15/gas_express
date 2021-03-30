import 'package:flutter/cupertino.dart';
import 'package:gas_express/ui/Cart/CartModel.dart';
import 'package:gas_express/ui/HomeScreens/ProductsModel.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:gas_express/utils/global_vars.dart';

class CartProvider extends ChangeNotifier {
 int counter = 0;


 getIncreaseCounter(){
   counter++;
   notifyListeners();
 }

 getDecreaseCounter(){
   counter--;
   notifyListeners();
 }

  // @override
  // void notifyListeners() {
  //   counter++;
  //   super.notifyListeners();
  // }
  // // Map<String,ProductItem> cartProductItems = {} ;
  // //
  // // Map<String,ProductItem> get cartProduct {
  // //   return {...cartProductItems};
  // // }
  //
  // List<CartModel> cart = [];
  //
  // List<CartModel> get getCartList {
  //   return [...cart];
  // }
  //
  // checkItemsInCart(ProductItem productItem) {
  //   // if (cartProduct.containsKey(productItem.id)) {
  //   //   cartProduct.update(
  //   //       productItem.id,
  //   //           (existingItem) =>
  //   //               CartModel(price:productItem.unitprice ,name:translator.currentLanguage == 'ar'
  //   //                   ?productItem.productnameAr
  //   //                   : "${productItem.productnameEn}",id: productItem.id,image:  productItem.photoUrl,quantity: 1 )
  //   //   );
  //   // } else {
  //   //   priceToUser.putIfAbsent(
  //   //       user.userId,
  //   //           () =>
  //   //           TotalPriceUser(
  //   //               userId: user.userId,
  //   //               userName: user.userName,
  //   //               counterOfDone: 1,
  //   //               totalPrice: product.commission
  //   //           )
  //   //   );
  //   // }
  //   // List<CartModel> cartList= [];
  //   List<CartModel> cartListItems = cart;
  //   for (int x = 0; x < cartListItems.length; x++) {
  //     print("elementname  ${cartListItems[x].name}");
  //     if (cartListItems.contains(productItem.id)) {
  //       print("increseeee");
  //       cartListItems[x].quantity += 1;
  //       return;
  //     }
  //   }
  //
  //   print("add new ");
  //   cartListItems.add(CartModel(
  //       price: productItem.unitprice,
  //       name: translator.currentLanguage == 'ar'
  //           ? productItem.productnameAr
  //           : "${productItem.productnameEn}",
  //       id: productItem.id,
  //       image: productItem.photoUrl,
  //       quantity: 1));
  //
  //   notifyListeners();
  //   print("heeeeeeeeeeeeeeeeeere${cart}");
  // }
}
