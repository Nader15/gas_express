import 'dart:convert';
import 'dart:io';

import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/APiFunctions/sharedPref/SharedPrefClass.dart';
import 'package:gas_express/ui/UserAddresses/UserAddresses_Model.dart';
import 'package:gas_express/ui/UserAddresses/add_address.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/ui/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';
import 'package:gas_express/utils/static_ui.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class MyAddresses extends StatefulWidget {
  bool fromSideMenu;

  MyAddresses(this.fromSideMenu);

  @override
  _MyAddressesState createState() => _MyAddressesState();
}

class _MyAddressesState extends State<MyAddresses> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  UserAddresses userAddresses;
  List<AddressItem> addressList = List();
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
      addressList.clear();

      Api(context, _scaffoldKey)
          .getCustomersAddressesApi(_scaffoldKey)
          .then((value) {
        userAddresses = value;
        userAddresses.results.forEach((element) {
          setState(() {
            addressList.add(element);

            if(selectedAddressId!=null&&element.id==selectedAddressId){
              element.isDefault=true;
            }
          });
        });
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
        title: Text(
          getTranslated(context, "MyAddresses"),
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
        actions: [StaticUI().cartWidget(context)],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: addressList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return address(addressList[index]);
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    XsProgressHud.show(context);

                    Location().getLocation().then((value) async {
                      XsProgressHud.hide();

                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AddAddress(value.latitude, value.longitude),
                        ),
                      ).then((value) {
                        gettingData();
                      });
                      // navigateAndKeepStack(context, AddAddress(value.latitude,value.longitude));
                    });
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
        ),
      ),
    );
  }

  Card address(AddressItem addressItem) {
    return Card(
      elevation: 10,
      child: InkWell(onTap: (){



        selectedAddressId=addressItem.id;
        selectedAddressString=addressItem.name;

        Navigator.of(context).pop();
      },
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
                        addressItem.name,
                        style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      addressItem.isDefault == true
                          ? Text(
                        "(${getTranslated(context, "Default")})",
                        style: _titleTextStyle,
                      )
                          : Container(),
                    ],
                  ),
                  addressItem.isDefault == false
                      ? TextButton(
                    onPressed: () {
                      addressList.forEach((element) {
                        setState(() {
                          element.isDefault = false;
                        });
                      });
                      setState(() {
                        selectedAddressId=addressItem.id;
                        selectedAddressString=addressItem.name;
                        setAddressToShared(selectedAddressString,selectedAddressId);
                        addressItem.isDefault = !addressItem.isDefault;
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
                addressItem.description??"",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // TextButton(
                  //   onPressed: () {},
                  //   child: Text(
                  //     getTranslated(context, "Edit"),
                  //     style: _bttnTextStyle,
                  //   ),
                  // ),
                  SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      Api(context, _scaffoldKey)
                          .deleteCustomersAddressesApi(addressItem.id)
                          .then((value) {
                            if(value){
                              setState(() {
                                addressList.remove(addressItem);
                              });
                            }

                      });
                    },
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
      ),
    );
  }
}

TextStyle _bttnTextStyle =
TextStyle(color: greenAppColor, fontSize: 15, fontWeight: FontWeight.w100);
TextStyle _titleTextStyle =
TextStyle(color: greenAppColor, fontSize: 15, fontWeight: FontWeight.w100);

