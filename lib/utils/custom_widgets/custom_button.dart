import 'package:flutter/material.dart';
import 'package:gas_express/utils/colors_file.dart';

class CustomButton extends StatelessWidget {
  final double bttnHeight;
  final String bttnName;
  final double bttnNameSize;
  final Function onPress;

  CustomButton(
      {this.bttnHeight, this.bttnName, this.bttnNameSize, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            primary: primaryAppColor,
            onPrimary: Colors.white,
          ),
          child: Text(
            bttnName,
            style: TextStyle(
              fontSize: bttnNameSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          onPressed: onPress,
        ));
  }
}
