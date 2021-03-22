import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localize_and_translate/localize_and_translate.dart';



import 'package:xs_progress_hud/xs_progress_hud.dart';

//fluttertoast: ^6.0.1
//FN_showToast(String message,BuildContext context,Color color)
//{
//  FlutterToast flutterToast;
//  flutterToast = FlutterToast(context);
//  flutterToast.showToast(
//    child: Card(
//     color: Colors.white,
//      elevation: 4.0,
//      shape: OutlineInputBorder(
//          borderSide: BorderSide(
//            color: Colors.grey.withOpacity(0.2), width: 1,),
//          borderRadius:
//          BorderRadius.circular(10)),
//      child: Container(
//        alignment: Alignment.center,
//        padding: EdgeInsets.all(10.0),
//        child: Text(
//          '${message}',
//          style: TextStyle(
//              color: color,
//              fontSize: 16,
//            fontFamily: "Nunito"
//          ),
//          textAlign: TextAlign.center,
//        ),
//      ),
//    ),
//    gravity: _keyboardIsVisible(context)?ToastGravity.CENTER:ToastGravity.BOTTOM,
//    toastDuration: Duration(seconds: 5),
//  );
//}

FN_showToast(String message,BuildContext context,Color color,GlobalKey<ScaffoldState> _scaffoldKey)
{
  final snackBar = SnackBar(
    backgroundColor: color,
    content: Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        message,
        style: TextStyle(
            color: Colors.white,
            fontFamily: "Nunito"
        ),
      ),
    ),
    duration: Duration(milliseconds: 1500),
  );
  _scaffoldKey.currentState.showSnackBar(snackBar);
}

bool _keyboardIsVisible(BuildContext context) {
  return !(MediaQuery
      .of(context)
      .viewInsets
      .bottom == 0.0);
}

Future<bool> FN_showDetails_Dialog(BuildContext context,String title,String body)
async {
  return (await showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text(title),
      content: new Text(body),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text(translator.currentLanguage=="en"?'Okay':"حسنا"),
          ),
//          new FlatButton(
//            onPressed: () => Navigator.of(context).pop(true),
//            child: new Text('Yes'),
//          ),
          ],
    ),
  )) ?? false;
}

//
//Future<bool> Fn_ChooseDetails_Dialog(BuildContext context,String body)
//async {
//  return (await showDialog(
//    context: context,
//    builder: (context) => new AlertDialog(
//      // title: new
//      content: Container(
//        height: SizeConfig.screenHeight*0.3,
//        child: Column(
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.only(bottom: 12),
//              child: Image.asset("assets/images/green_message.png"),
//            ),
//            Text(body,style: TX_STYLE_black_normal_14Point5,),
//          ],
//        ),
//      ),
//      actions: <Widget>[
//        new FlatButton(
//          onPressed: () => Navigator.of(context).pop(false),
//          child: new Text(
//            translator.currentLanguage=="en"?'No':"لا",
//            style: TX_STYLE_black_normal_15.copyWith(
//                color: red
//            ),
//          ),
//        ),
//        new FlatButton(
//          onPressed: () => ,
//          child: new Text(
//            translator.currentLanguage=="en"?'Yes':"حسنا",
//            style: TX_STYLE_black_normal_15.copyWith(
//                color: green
//            ),
//          ),
//        ),
////          new FlatButton(
////            onPressed: () => Navigator.of(context).pop(true),
////            child: new Text('Yes'),
////          ),
//      ],
//    ),
//  )) ?? false;
//}


Future<bool> FN_onWillPop(BuildContext context) async {
  XsProgressHud.hide;
   showDialog(
    context: context,
    builder: (context) => new AlertDialog(
      title: new Text(
          translator.currentLanguage == "en"?
          'Are you sure?':"هل انت متاكد ؟"),
      content: new Text(
          translator.currentLanguage == "en"?
              'Do you want to exit an App':"تريد الخروج من التطبيق"),
      actions: <Widget>[
        new FlatButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text(
              translator.currentLanguage == "en"?'No':"لا"),
        ),
        new FlatButton(
          onPressed: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');

          },
          child: new Text( translator.currentLanguage == "en"?'Yes':"نعم"),
        ),
      ],
    ),
  );
}

