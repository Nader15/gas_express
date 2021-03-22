// import 'dart:convert';
// import 'dart:io';
// import 'dart:ui' as ui;
// import 'package:geocoder/geocoder.dart';
//
//  import 'package:flutter/rendering.dart';
//   import 'package:http/http.dart' as http;
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:localize_and_translate/localize_and_translate.dart';
// import 'package:location/location.dart';
//
// import 'package:xs_progress_hud/xs_progress_hud.dart';
//
//
// class EditCoverdZoneLocationScreen extends StatefulWidget {
//
//
//   EditCoverdZoneLocationScreen();
//
//   @override
//   _EditCoverdZoneLocationScreenState createState() => _EditCoverdZoneLocationScreenState();
// }
//
// class _EditCoverdZoneLocationScreenState extends State<EditCoverdZoneLocationScreen> {
//   var filePath = '';
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   var location = new Location();
//
//    String UserAddress = ' ';
//   Completer<GoogleMapController> _controller = Completer();
//
//
//     double lat ;
//     double long ;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     if (!mounted) return;
//
//     setState(() {
//
//     });
//     location.onLocationChanged.listen((LocationData currentLocation) {
//       lat = currentLocation.latitude;
//       long = currentLocation.longitude;
//
//
//       });
//    }
//
//
//
//   bool cameraMoveStop = false;
//   bool loader = false;
//   List<String> data = new List();
//
//
//   @override
//   Widget build(BuildContext context) {
//      return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         centerTitle: true,
//          title: Text(translator.translate('coverdZone') ),
//       ),
//
//       body: Stack(
//         children: <Widget>[
//           Container(
//             color: Colors.white,
//             child: GoogleMap(
//               myLocationButtonEnabled: true,
//                   myLocationEnabled: true,
//                   compassEnabled: true,
// //              onCameraMove: (val){
// //                print(val.target.latitude);
// //              },
//               circles:  Set<Circle>.of([
//                 Circle(
//                     circleId: CircleId('1'),
//                     radius: 500.0,
//                     center: LatLng(lat, long),
//                     fillColor: Colors.red.withOpacity(.2),
//                     strokeColor: Colors.blue,
//                     strokeWidth: 2
//                 )
//               ]),
//               mapType: MapType.normal,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(widget.zoneItem.lat, widget.zoneItem.long),
//                 zoom:15.8,
//               ),
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//               onCameraIdle: () {
//                 print('idle');
//                 cameraMoveStop = true;
//                 print(cameraMoveStop);
//
//
//                 lat =widget.zoneItem.lat;
//                 lat = widget.zoneItem.long;
//               },
//               onCameraMoveStarted: () {
//                 print('start');
// //                    cameraMoveStop = false;
//                 print(cameraMoveStop);
//               },
//               onCameraMove: (postion) {
//                 print('ssss   ${postion.target}');
//                 if (cameraMoveStop) {
//                   print('stooped at ${postion.target}');
//
//                   setState(() {
//                     lat = postion.target.latitude;
//                     long = postion.target.longitude;
//                     widget.zoneItem.lat = postion.target.latitude;
//                     widget.zoneItem.long = postion.target.longitude;
//                   });
//                 }
//               },
//
//               markers: Set<Marker>.of(
//                 <Marker>[
//                   Marker(
//                       draggable: true,
//                       markerId: MarkerId("1"),
//                       position: LatLng(widget.zoneItem.lat, widget.zoneItem.long),
//                       //    icon: BitmapDescriptor.fromAsset("assets/marker.png"),
//                       infoWindow: const InfoWindow(
//                         title: "Ana",
//                       ))
//                 ],
//               ),
//             ),
//           ),
//
//           Column(
//             children: [
//               SizedBox(height: 20,),
//               Center(child: Container(padding: EdgeInsets.only(top: 10,bottom: 10),decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),width: 200,child: Text(UserAddress,textAlign: TextAlign.center,),)),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//
//     getLocation(BuildContext context1)  async {
//
//      final coordinates = new Coordinates(lat, long);
//      debugPrint('coordinates is: $coordinates');
//
//      var addresses =
//      await Geocoder.local.findAddressesFromCoordinates(coordinates);
//      var first = addresses.first;
//      UserAddress="${first.featureName} : ${first.addressLine}";
//
//
// //print other address names
//
//   }
// }
