import 'dart:convert';
import 'dart:io';

import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/ui/UserAddresses/UserAddresses_Model.dart';
import 'package:gas_express/ui/add_address.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class MyAddresses extends StatefulWidget {
  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  UserAddresses userAddresses;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () {
      setState(() {
        gettingData();
      });
    });
  }

  gettingData() {
    setState(() {
      Api(context,_scaffoldKey).customersAddressesApi(_scaffoldKey,"1");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawerList(),
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(
          getTranslated(context, "MyAddresses"),
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
        actions: [
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: _mainForm(context),
      ),
    );
  }

  Form _mainForm(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  address("البيت",
                      "268 Ibn Bakkar, As Safa District, Jedda 234526651,Saudi Arabia"),
                  address("البيت",
                      "268 Ibn Bakkar, As Safa District, Jedda 234526651,Saudi Arabia"),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                navigateAndKeepStack(context, AddAddress());
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Text(
                    getTranslated(context, "AddAddress"),
                    style: _titleTextStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ))
        ],
      ),
    );
  }

  bool defaultAddress = false;

  Card address(String title, String location) {
    return Card(
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    defaultAddress == true
                        ? Text(
                            "(${getTranslated(context, "Default")})",
                            style: _titleTextStyle,
                          )
                        : Container(),
                  ],
                ),
                defaultAddress == false
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            defaultAddress = !defaultAddress;
                          });
                        },
                        child: Text(
                          getTranslated(context, "MakeDefault"),
                          style: _titleTextStyle,
                        ),
                      )
                    : Container()
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              location,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    getTranslated(context, "Edit"),
                    style: _bttnTextStyle,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    getTranslated(context, "Delete"),
                    style: _bttnTextStyle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle _bttnTextStyle =
    TextStyle(color: greenAppColor, fontSize: 15, fontWeight: FontWeight.w100);
TextStyle _titleTextStyle =
    TextStyle(color: greenAppColor, fontSize: 15, fontWeight: FontWeight.w100);
