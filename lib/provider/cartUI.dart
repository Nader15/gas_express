import 'package:flutter/material.dart';
import 'package:gas_express/ui/Cart/cart.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:provider/provider.dart';

import 'cartProvider.dart';


class CartUI extends StatefulWidget {

  @override
  _CartUIState createState() => _CartUIState();
}

class _CartUIState extends State<CartUI> {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartProvider>(context);
    return Stack(
      children: [
        IconButton(
            icon: Icon(
              Icons.shopping_cart,
              size: 20.0,
            ),
            onPressed: () {
              if (cartList.length != 0) {
                navigateAndKeepStack(context, Cart());
              }

              // navigateAndKeepStack(context, TestProducts());
            }),
        cartData.counter == 0
            ? Container()
            : Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white),
            width: 20,
            height: 20,
            child: Center(
                child: Text(
                  cartData.counter .toString(),
                  style: TextStyle(color: Colors.red),
                )),
          ),
        )
      ],
    );
  }
}
