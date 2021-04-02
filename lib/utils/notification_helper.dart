//  import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class NotificationCenter {
//   BuildContext context ;
//   final FirebaseMessaging _fcm = FirebaseMessaging();
//   NotificationCenter(BuildContext context){
//     this.context = context;
//   }
//   initConfigure(){
//     print("enterrrrrrd");
//     _fcm.configure(
//       onMessage: (Map<String, dynamic> message) async {
//     print('onMessage11 : $message');
//
//         showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               content: ListTile(
//                 title: Text(
//                   message['notification']['title'],
//                   textAlign: TextAlign.end,
//                 ),
//                 subtitle: Text(message['notification']['body'],
//                     textAlign: TextAlign.end),
//               ),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('Ok'),
//                   onPressed: () {
// //                        print('Tappped');
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ));
//       },
//       onResume: (Map<String, dynamic> message) async {
// //        print('onMessage : $message');
//         print('onMessage22 : $message');
//
//         showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               content: ListTile(
//                 title: Text(
//                   message['notification']['title'],
//                   textAlign: TextAlign.end,
//                 ),
//                 subtitle: Text(message['notification']['body'],
//                     textAlign: TextAlign.end),
//               ),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('Ok'),
//                   onPressed: () {
// //                        print('Tappped');
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ));
//       },
//       onLaunch: (Map<String, dynamic> message) async {
// //        print('onMessage : $message');
//         print('onMessage33 : $message');
//
//         showDialog(
//             context: context,
//             builder: (context) => AlertDialog(
//               content: ListTile(
//                 title: Text(
//                   message['notification']['title'],
//                   textAlign: TextAlign.end,
//                 ),
//                 subtitle: Text(message['notification']['body'],
//                     textAlign: TextAlign.end),
//               ),
//               actions: <Widget>[
//                 FlatButton(
//                   child: Text('Ok'),
//                   onPressed: () {
// //                        print('Tappped');
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ));
//       },
//     );
//   }
//
// }