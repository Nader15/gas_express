import 'package:flutter/material.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/provider/cartProvider.dart';
import 'package:gas_express/ui/HomeScreens/ProductsModel.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:provider/provider.dart';

class AddButtonWidget extends StatefulWidget {
  ProductItem productItem;

  AddButtonWidget(this.productItem);

  @override
  _AddButtonWidgetState createState() => _AddButtonWidgetState();
}

class _AddButtonWidgetState extends State<AddButtonWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool inCart = false;
  @override
  void initState() {
    checkInCart();

    super.initState();
  }

  checkInCart() {
    for (int x = 0; x < cartList.length; x++) {
      if (cartList[x].id == widget.productItem.id) {
        setState(() {
          inCart = true;
          widget.productItem.quantity = cartList[x].quantity;
        });
        return;
      }
      setState(() {
        inCart = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: inCart
          ? Row(
        children: [
          Expanded(
              child: InkWell(
                  onTap: () {
                    setState(() {
                      cartData.getDecreaseCounter();
                      cartList.removeWhere((element) =>
                      element.id == widget.productItem.id);
                      widget.productItem.quantity=1;
                      inCart = false;
                    });
                  },
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ))),
          Expanded(
              child: InkWell(
                  onTap: () {
                    if(widget.productItem.quantity>1){
                      setState(() {
                        widget.productItem.quantity -= 1;
                        cartListLength.value-- ;
                      });
                    }
                    else {
                      setState(() {
                        cartData.getDecreaseCounter();
                        cartList.removeWhere((element) =>
                        element.id == widget.productItem.id);
                        widget.productItem.quantity=1;
                        inCart = false;
                      });
                    }

                  },
                  child: Container(
                    color: Colors.green,
                    width: 30,
                    height: 30,
                    child: Center(
                        child: Text("-",
                            style: TextStyle(color: Colors.white))),
                  ))),
          Expanded(
              child: Container(
                width: 50,
                height: 50,
                child: Center(child: Text("${widget.productItem.quantity}")),
              )),
          Expanded(
              child: InkWell(
                  onTap: () {
                    Api(context, _scaffoldKey)
                        .checkItemsInCart(widget.productItem);

                    setState(() {
                      widget.productItem.quantity += 1;
                      cartListLength.value ++ ;
                    });
                  },
                  child: Container(
                    color: Colors.green,
                    width: 30,
                    height: 30,
                    child: Center(
                        child: Text("+",
                            style: TextStyle(color: Colors.white))),
                  ))),
        ],
      )
          : Container(
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all<Color>(greenAppColor),
          ),
          onPressed: () {
            cartData.getIncreaseCounter();
            setState(() {
              inCart = true;
            });
            Api(context, _scaffoldKey)
                .checkItemsInCart(widget.productItem);
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Text(
              getTranslated(context, "Add"),
              style: TextStyle(fontWeight: FontWeight.w100),
            ),
          ),
        ),
      ),
    );
  }
}

// class _AddButtonWidgetState extends State<AddButtonWidget> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   bool inCart = false;
//   @override
//   void initState() {
//     checkInCart();
//     super.initState();
//   }
//
//   checkInCart() {
//     for (int x = 0; x < CartProvider().cart.length; x++) {
//       if (CartProvider().cart[x].id == widget.productItem.id) {
//         setState(() {
//           inCart = true;
//           widget.productItem.quantity = CartProvider().cart[x].quantity;
//         });
//         return;
//       }
//       setState(() {
//         inCart = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print("hchchhchchchchchhc${CartProvider().cart}");
//     return Scaffold(
//       key: _scaffoldKey,
//       body: inCart
//           ? Row(
//               children: [
//                 Expanded(
//                     child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             CartProvider().cart.removeWhere((element) =>
//                                 element.id == widget.productItem.id);
//                             widget.productItem.quantity=1;
//                             inCart = false;
//                           });
//                         },
//                         child: Icon(
//                           Icons.delete,
//                           color: Colors.red,
//                         ))),
//                 Expanded(
//                     child: InkWell(
//                         onTap: () {
//                           if(widget.productItem.quantity>1){
//                             setState(() {
//                               widget.productItem.quantity -= 1;
//                             });
//                           }
//                           else {
//                             setState(() {
//                               CartProvider().cart.removeWhere((element) =>
//                               element.id == widget.productItem.id);
//                               widget.productItem.quantity=1;
//                               inCart = false;
//                             });
//                           }
//
//                         },
//                         child: Container(
//                           color: Colors.green,
//                           width: 30,
//                           height: 30,
//                           child: Center(
//                               child: Text("-",
//                                   style: TextStyle(color: Colors.white))),
//                         ))),
//                 Expanded(
//                     child: Container(
//                   width: 50,
//                   height: 50,
//                   child: Center(child: Text("${widget.productItem.quantity}")),
//                 )),
//                 Expanded(
//                     child: InkWell(
//                         onTap: () {
//                           setState(() {
//                             widget.productItem.quantity += 1;
//                           });
//                           CartProvider()
//                               .checkItemsInCart(widget.productItem);
//
//                         },
//                         child: Container(
//                           color: Colors.green,
//                           width: 30,
//                           height: 30,
//                           child: Center(
//                               child: Text("+",
//                                   style: TextStyle(color: Colors.white))),
//                         ))),
//               ],
//             )
//           : Container(
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor:
//                       MaterialStateProperty.all<Color>(greenAppColor),
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     inCart = true;
//                   });
//                   CartProvider()
//                       .checkItemsInCart(widget.productItem);
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   width: MediaQuery.of(context).size.width,
//                   child: Text(
//                     getTranslated(context, "Add"),
//                     style: TextStyle(fontWeight: FontWeight.w100),
//                   ),
//                 ),
//               ),
//             ),
//     );
//   }
// }
