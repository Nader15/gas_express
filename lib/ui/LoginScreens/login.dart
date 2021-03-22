import 'package:flutter/material.dart';
import 'package:gas_express/APiFunctions/Api.dart';
import 'package:gas_express/ui/LoginScreens/verification.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/navigator.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _autoValidate = false;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  var phoneController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(getTranslated(context, "Login"),
            style:
                TextStyle(fontWeight: FontWeight.w100, color: primaryAppColor)),
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
      child: SingleChildScrollView(
          child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("ادخل رقم الجوال الخاص بك للدخول"),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 8,
                ),
                Row(
                  children: [
                    Container(alignment: Alignment.centerLeft,
                        child: Text("+966")),
                    SizedBox(width: 6,),
                    Container(
                  width:     MediaQuery.of(context).size.width/1.4,

                      child: TextFormField(
                        controller: phoneController,
                        validator: validatePhone,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.phone,

                        cursorColor: grey,
                        decoration: InputDecoration(

                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: grey)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: grey)),
                          labelText: "رقم الجوال",
                          labelStyle: TextStyle(color: grey),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                    child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: primaryAppColor, // background
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: () {
                        _validateInputs();
                        if (_key.currentState.validate()) {
                          Api(context, _scaffoldKey).loginFunc(phoneController.text).then((value) {
                            if(value){
                              navigateAndKeepStack(context, Verify(phoneController.text));

                            }
                          });
                        }
                      },
                      child: Text("تسجيل دخول")),
                ))
              ],
            ),
          )
        ],
      )),
    );
  }

  void _validateInputs() {
    if (_key.currentState.validate()) {
      _key.currentState.save();
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  String validatePhone(String value) {
    if (value.length == 0)
      return "*أدخل رقم الجوال";
    else if (value.length < 9)
      return '*أدخل رقم جوال صحيح';
    else
      return null;
  }
}
