import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerList(),
      appBar: AppBar(
        backgroundColor: primaryAppColor,
        title: Text(
          getTranslated(context, "Notifications"),
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
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(context, "AlertTitle"),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w100),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "أحصل علي تبديل مجاني للاسطوانة عند استبدال عدد 7 اسطوانات خلال عام واحد",
                            style: TextStyle(fontWeight: FontWeight.w100),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    getTranslated(context, "Delete"),
                                    style: TextStyle(
                                        color: greenAppColor,
                                        fontWeight: FontWeight.w100),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getTranslated(context, "AlertTitle"),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w100),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "أحصل علي تبديل مجاني للاسطوانة عند استبدال عدد 7 اسطوانات خلال عام واحد",
                            style: TextStyle(),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    getTranslated(context, "Delete"),
                                    style: TextStyle(
                                        color: greenAppColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      FlatButton(
                          onPressed: () {},
                          child: Text(
                            getTranslated(context, "DeleteAll"),
                            style: TextStyle(
                                color: greenAppColor,
                                fontWeight: FontWeight.w100),
                          )),
                      FlatButton(
                          onPressed: () {},
                          child: Text(
                            getTranslated(context, "DeleteSelected"),
                            style: TextStyle(
                                color: greenAppColor,
                                fontWeight: FontWeight.w100),
                          )),
                    ],
                  )
                ],
              )),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
