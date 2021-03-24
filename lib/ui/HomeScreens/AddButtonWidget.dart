import 'package:flutter/material.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/ui/HomeScreens/ProductsModel.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/global_vars.dart';

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
    return Scaffold(
      key: _scaffoldKey,
      body: inCart
          ? Row(
              children: [
                Expanded(
                    child: InkWell(
                        onTap: () {
                          setState(() {
                            cartList.removeWhere((element) =>
                                element.id == widget.productItem.id);
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
                          setState(() {
                            widget.productItem.quantity -= 1;
                          });
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
