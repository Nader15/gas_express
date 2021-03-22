import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';

import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class AddAddress extends StatefulWidget {
  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerList(),
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(
          "أضافة عنوان",
          style: TextStyle(fontWeight: FontWeight.w100),
        ),
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
      child: Align(
        alignment: Alignment.topRight,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 10,
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Center(
                        child: Text("Map"),
                      ),
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              _image == null
                  ? InkWell(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 40,
                              color: primaryAppColor,
                            ),
                            Text("أضافة صورة"),
                          ],
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        Card(
                          elevation: 10,
                          child: Center(
                            child: Image.file(
                              _image,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height/6,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        FlatButton(
                            child: Text(
                              "حذف",
                              style: TextStyle(color: primaryAppColor),
                            ),
                            onPressed: () {
                              setState(() {
                                _image = null;
                              });
                            }),
                      ],
                    ),
              SizedBox(
                height: 100,
              ),

              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   child: ElevatedButton(
              //       style: ElevatedButton.styleFrom(
              //         primary: primaryAppColor, // background
              //         onPrimary: Colors.white, // foreground
              //       ),
              //       onPressed: () {},
              //       child: Text("تأكيد")),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
