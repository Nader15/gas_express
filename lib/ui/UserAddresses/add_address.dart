import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/APiFunctions/sharedPref/SharedPrefClass.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/ui/drawer.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:location/location.dart';

class AddAddress extends StatefulWidget {
  double userLat, userLong;

  AddAddress(this.userLat, this.userLong);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String UserAddress = "";
  File _image;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _flatNoController = TextEditingController();
  TextEditingController _floorController = TextEditingController();
  TextEditingController _buildingNoController = TextEditingController();
  var location = new Location();

  Completer<GoogleMapController> _controller = Completer();
  bool cameraMoveStop = false;
  bool loader = false;
  List<String> data = new List();

  double lat;
  double long;
sendAddAddressRequest(Map data,BuildContext context){
  Api(context, _scaffoldKey)
      .addCustomersAddressesApi(data)
      .then((value) {
    if (value) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  });
}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!mounted) return;

    setState(() {
      lat = widget.userLat;
      long = widget.userLong;
    });
    location.onLocationChanged.listen((LocationData currentLocation) {
      lat = currentLocation.latitude;
      long = currentLocation.longitude;
      getLocationAddress(context);
    });
  }

  getLocationData() {
    return showDialog(
        context: context,
        builder: (BuildContext context1) => Dialog(
              child: Container(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30,right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      new Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: new Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: new TextField(

                          // textAlign: TextAlign.center,
                          controller: _buildingNoController,

                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20,right: 20),
                            hintText: translator.translate('buildingNo'),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width / 1.3,
                      //   child: TextField(
                      //     controller: _buildingNoController,
                      //     textAlign: translator.currentLanguage == 'ar'
                      //         ? TextAlign.right
                      //         : TextAlign.left,
                      //     keyboardType: TextInputType.number,
                      //     decoration: InputDecoration(
                      //       enabledBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: grey)),
                      //       focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: grey)),
                      //       labelText: getTranslated(context, "buildingNo"),
                      //       labelStyle: TextStyle(color: grey),
                      //     ),
                      //   ),
                      // ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      new Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: new Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: new TextField(

                          // textAlign: TextAlign.center,
                          controller: _flatNoController,

                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20,right: 20),
                            hintText: translator.translate('flatNo'),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width / 1.3,
                      //   child: TextField(
                      //     controller: _flatNoController,
                      //     textAlign: translator.currentLanguage == 'ar'
                      //         ? TextAlign.right
                      //         : TextAlign.left,
                      //     keyboardType: TextInputType.number,
                      //     decoration: InputDecoration(
                      //       enabledBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: grey)),
                      //       focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: grey)),
                      //       labelText: getTranslated(context, "flatNo"),
                      //       // labelText: "رقم الشقه",
                      //       labelStyle: TextStyle(color: grey),
                      //     ),
                      //   ),
                      // ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),

                      new Container(
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: new Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                        ),
                        child: new TextField(

                          // textAlign: TextAlign.center,
                          controller: _floorController,

                          decoration: new InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20,right: 20),
                            hintText: translator.translate('floorNo'),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width / 1.3,
                      //   child: TextField(
                      //     controller: _floorController,
                      //     textAlign: translator.currentLanguage == 'ar'
                      //         ? TextAlign.right
                      //         : TextAlign.left,
                      //     keyboardType: TextInputType.number,
                      //     decoration: InputDecoration(
                      //       enabledBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: grey)),
                      //       focusedBorder: UnderlineInputBorder(
                      //           borderSide: BorderSide(color: grey)),
                      //       labelText: getTranslated(context, "floorNo"),
                      //       // labelText: "رقم الطابق",
                      //       labelStyle: TextStyle(color: grey),
                      //     ),
                      //   ),
                      // ),
                      Padding(padding: EdgeInsets.only(top: 20.0)),
                      InkWell(
                        onTap: (){
                          Map data={};
                          if (_image == null) {
                            data = {
                              "name": "${UserAddress}",
                              "buildingno": _buildingNoController.text,
                              "floor": _floorController.text,
                              "flatno": _flatNoController.text,
                              "GPS": "${widget.userLat},${widget.userLong}",
                              "customerid": BaseUderId
                            };
                            sendAddAddressRequest(data,context1);

                          } else {

                            Api(context1,_scaffoldKey).uploadImageToApi(_image).then((value) {
                              data = {
                                "name": "${UserAddress}",
                                "buildingno": _buildingNoController.text,
                                "floor": _floorController.text,
                                "flatno": _flatNoController.text,
                                "GPS": "${widget.userLat},${widget.userLong}",
                                "buildingphotoid": "$value",
                                "customerid": BaseUderId
                              };
                              sendAddAddressRequest(data,context1);
                            });

                          }
                          print("datadata:: ${data}");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:  primaryAppColor),
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: 40,
                          child: Center(
                              child: Text(
                                translator.translate('save'),
                                textScaleFactor: 1,
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      )

                    ],
                  ),
                ),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 10,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: GoogleMap(
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      compassEnabled: true,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(widget.userLat, widget.userLong),
                        zoom: 15.8,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                      onCameraIdle: () {
                        print('idle');
                        cameraMoveStop = true;
                        print(cameraMoveStop);

                        lat = widget.userLat;
                        lat = widget.userLong;
                      },
                      onCameraMoveStarted: () {
                        print('start');
//                    cameraMoveStop = false;
                        print(cameraMoveStop);
                      },
                      onCameraMove: (postion) {
                        print('ssss   ${postion.target}');
                        if (cameraMoveStop) {
                          print('stooped at ${postion.target}');

                          setState(() {
                            lat = postion.target.latitude;
                            long = postion.target.longitude;
                            widget.userLat = postion.target.latitude;
                            widget.userLong = postion.target.longitude;
                          });
                        }
                      },
                      markers: Set<Marker>.of(
                        <Marker>[
                          Marker(
                              draggable: true,
                              markerId: MarkerId("1"),
                              position: LatLng(widget.userLat, widget.userLong),
                              //    icon: BitmapDescriptor.fromAsset("assets/marker.png"),
                              infoWindow: const InfoWindow(
                                title: "Ana",
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              _image == null
                  ? InkWell(
                      onTap: () {
                        Api(context, _scaffoldKey).getImage().then((value) {
                          setState(() {
                            _image = value;
                          });
                        });
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
                              height: MediaQuery.of(context).size.height / 6,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        TextButton(
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryAppColor, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      getLocationData();
                    },
                    child: Text("تأكيد")),
              )
            ],
          ),
        ),
      ),
    );
  }

  getLocationAddress(BuildContext context1) async {
    final coordinates = new Coordinates(widget.userLat, widget.userLong);
    debugPrint('coordinates is: $coordinates');

    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    UserAddress = "${first.featureName} : ${first.addressLine}";

//print other address names
  }
}
