import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/ui/Notifications/NotificationModel.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/custom_widgets/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/static_ui.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  NotificationModel notificationModel;
  List<NotificationItem> notificationsList=List();


  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Future.delayed(Duration(milliseconds: 0), () {
      getNotifications();
    });
    super.initState();
  }

  getNotifications() {
    Api(context, _scaffoldKey).getNotifications().then((value) {
      notificationModel = value;
      notificationModel.results.forEach((element) {
        setState(() {
          notificationsList.add(element);
        });
      });
    });
  }
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
          StaticUI().cartWidget(context)

           // IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child:    Container(
          child: notificationsList.length==0?StaticUI().NoDataFoundWidget(context):ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: notificationsList.length,
              itemBuilder: (BuildContext context, int index) {
                return  Column(
                  children: [
                    Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notificationsList[index].messagetitle,
                              // getTranslated(context, "AlertTitle"),
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w100),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              notificationsList[index].messagedetails,
                              style: TextStyle(fontWeight: FontWeight.w100),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [

                                Container()
                                // TextButton(
                                //     onPressed: () {},
                                //     child: Text(
                                //       getTranslated(context, "Delete"),
                                //       style: TextStyle(
                                //           color: greenAppColor,
                                //           fontWeight: FontWeight.w100),
                                //     )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   children: [
                    //     FlatButton(
                    //         onPressed: () {},
                    //         child: Text(
                    //           getTranslated(context, "DeleteAll"),
                    //           style: TextStyle(
                    //               color: greenAppColor,
                    //               fontWeight: FontWeight.w100),
                    //         )),
                    //     FlatButton(
                    //         onPressed: () {},
                    //         child: Text(
                    //           getTranslated(context, "DeleteSelected"),
                    //           style: TextStyle(
                    //               color: greenAppColor,
                    //               fontWeight: FontWeight.w100),
                    //         )),
                    //   ],
                    // )
                  ],
                );
              }),
        ),

      ),
    );
  }

}
