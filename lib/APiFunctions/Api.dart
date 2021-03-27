import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gas_express/APiFunctions/sharedPref/SharedPrefClass.dart';
import 'package:gas_express/ui/Cart/CartModel.dart';
import 'package:gas_express/ui/Cart/SuccessPromoCodeModel.dart';
import 'package:gas_express/ui/HomeScreens/BannersModel.dart';
import 'package:gas_express/ui/HomeScreens/ProductsModel.dart';
import 'package:gas_express/ui/LoginScreens/UserModel.dart';
import 'package:gas_express/ui/Notifications/NotificationModel.dart';
import 'package:gas_express/ui/Orders/OrdersModel.dart';
import 'package:gas_express/ui/StaticDataModel.dart';
 import 'package:gas_express/ui/UserAddresses/UserAddresses_Model.dart';
import 'package:gas_express/ui/Wallet/BallanceModel.dart';
import 'package:gas_express/ui/Wallet/PointsModel.dart';
import 'package:gas_express/ui/Wallet/PromoCodeModel.dart';
import 'package:gas_express/utils/colors_file.dart';
import 'package:gas_express/utils/global_vars.dart';
import 'package:gas_express/utils/toast.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:xs_progress_hud/xs_progress_hud.dart';

class Api {
  BuildContext context;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  Api(this.context, this.scaffoldKey);

  String baseUrl = 'http://18.188.206.243:8001/api/';
  String images = "Images/";
  String products = "Products";
  String config = "Config/";
  String banners = "banners/";
  String notifications = "AdminMessages/?messageto=$BaseUderId";
  String forgetPassword = "ForgetPassword/";
  String verifyCode = "VerifyCode/";
  String user_coupon_code = "user_coupon_code/";
  String myBalance = "my_balance/";
  String check_coupon = "check_coupon/";
  String usageCount = "usage_count/";
  String deleteMessage = "archive_messages/";
  String checkZone = "/zone_check/";
  String customersAddresses = "CustomersAddresses/?customerid=$BaseUderId";
  String basket = "basket/";
  String orders = "Orders/?customerid=$BaseUderId&orderstatus=with-delivery-agent";
  String ordersHistory = "Orders/?customerid=$BaseUderId&orderstatus!=with-delivery-agent";
  String cancelOrders = "Orders/";
  String orderStatusDetails = "OrderStatusDetails";
  String checkCoupon = "check_coupon/";
  Future ordersHistoryListApi() async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + ordersHistory;
    final response = await http.get(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
    );
    print("DriverlordersListApi::: ${completeUrl}");
    print("DriverlordersListApi::: ${response.statusCode}");

    Map<String, dynamic> dataContent = json.decode(response.body);
    print("DriverlordersListApi::: ${dataContent}");

    XsProgressHud.hide();
    if (response.statusCode == 200) {
      return OrdersModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      print("body :" + json.decode(response.body).toString());
      // return OrdersModel.fromJson(dataContent);
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }
  Future loginFunc(
    String phone,
  ) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + forgetPassword;

    var response = await http.post(
      completeUrl,
      body: {"telephoneno": "+966" + phone},
    );
    print("PhoneBody ${response.body}");
    print("PhoneBody ${{"telephoneno": "+966" + phone}}");
    print("PhoneBody ${response.statusCode}");
    XsProgressHud.hide();
    if (response.statusCode == 200) {
      if (!response.body.contains("error")) {
        FN_showToast(
            'Successfully updated', context, Colors.green, scaffoldKey);

        return true;
        // if(response.statusCode == 200){

      } else {
        FN_showToast('${json.decode(response.body)['error']}', context,
            Colors.red, scaffoldKey);
        return false;
      }
    } else {
      FN_showToast('Send Code Failed', context, Colors.red, scaffoldKey);
      return false;
    }
  }


  Future deleteMessageApi(
    int id,bool deleteAll
  ) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + deleteMessage;

    var response = await http.post(
      completeUrl,  headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: BaseToken
    },
      body: jsonEncode({
        "messages": [
          {
            "id": id
          }
        ],
        "archive_all": true
      },)
    );
    print("PhoneBody ${response.body}");
     print("PhoneBody ${response.statusCode}");
    XsProgressHud.hide();
    if (response.statusCode == 200) {
      if (!response.body.contains("error")) {


        return true;
        // if(response.statusCode == 200){

      } else {
        FN_showToast('${json.decode(response.body)['error']}', context,
            Colors.red, scaffoldKey);
        return false;
      }
    } else {
      FN_showToast('Send Code Failed', context, Colors.red, scaffoldKey);
      return false;
    }
  }


  Future checkLocationApi(
    String location
  ) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + checkZone;

    var response = await http.post(
      completeUrl,  headers: {
      // 'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: BaseToken
    },
      body: {


          "gps": location
             },
    );
    print("checkLocationApiBody ${response.body}");
     print("checkLocationApiBody ${response.statusCode}");
    XsProgressHud.hide();
    if (response.statusCode == 200) {

    } else {
      FN_showToast('', context, Colors.red, scaffoldKey);

      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (
              context,
              ) {
            return StatefulBuilder(
              builder: (context, State) {
                return AlertDialog(
                  elevation: 4.0,
                  shape: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(.5),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  titlePadding: EdgeInsets.all(15.0),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        child: Text(
                          translator.translate('serviceNotAvailbe'),
                          textScaleFactor: 1,
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),



                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                          onTap: () {
                            SystemChannels.platform.invokeMethod('SystemNavigator.pop');

                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color:  primaryAppColor),
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: 40,
                            child: Center(
                                child: Text(
                                  translator.translate('ok'),
                                  textScaleFactor: 1,
                                  style: TextStyle(color: Colors.white),
                                )),
                          )),
                      SizedBox(
                        height: 20,
                      ),

                    ],
                  ),
                );
              },
            );
          });
      // return false;
    }
  }

  Future verifyCodeApi(String code, String phone) async {
    XsProgressHud.show(context);
    final String completeUrl = baseUrl + verifyCode;
    var data = {"validationCode": code, "telephoneno": "+966" + phone};
    var userToJson = json.encode(data);
    final response = await http.post(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // HttpHeaders.authorizationHeader: Token
      },
      body: userToJson,
    );
    print(userToJson);
    XsProgressHud.hide();
    if (response.statusCode == 200) {
      print("body :" + json.decode(response.body).toString());
      // return true;
      return UserModel.fromJson(json.decode(response.body));
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast('كود التفعيل غير صحيح', context, Colors.red, scaffoldKey);
      return false;
    }
  }

  Future<dynamic> getProducts({String filterName}) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + products+"/?category=$filterName";

    // TODO: implement getStudents
    final response = await http.get(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
    );
    print("ResponseInfo ${json.decode(response.body)}");
    print("ResponseInfo ${completeUrl}");
    print("ResponseInfo ${BaseToken}");
    XsProgressHud.hide();

    if (response.statusCode == 200) {
      return ProductsModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      // return ProductsModel.fromJson(json.decode(response.body));
      // return EventDetailsModel.fromJson(json.decode(response.body));

    } else {
      FN_showToast('Error', context, Colors.red, scaffoldKey);
      return false;
    }
  }
  Future<dynamic> getStaticData() async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + config;

    // TODO: implement getStudents
    final response = await http.get(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
    );
    print("ResponseInfo ${json.decode(response.body)}");
    print("ResponseInfo ${completeUrl}");
    print("ResponseInfo ${BaseToken}");
    XsProgressHud.hide();

    if (response.statusCode == 200) {
      return StaticDataModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      // return StaticDataModel.fromJson(json.decode(response.body));
      // return EventDetailsModel.fromJson(json.decode(response.body));

    } else {
      FN_showToast('Error', context, Colors.red, scaffoldKey);
      return false;
    }
  }
  Future<dynamic> getBanners() async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + banners;

    // TODO: implement getStudents
    final response = await http.get(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
    );
    print("ResponseInfo ${json.decode(response.body)}");
    print("ResponseInfo ${completeUrl}");
    print("ResponseInfo ${BaseToken}");
    XsProgressHud.hide();

    if (response.statusCode == 200) {
      return BannersModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      // return BannersModel.fromJson(json.decode(response.body));
      // return EventDetailsModel.fromJson(json.decode(response.body));

    } else {
      FN_showToast('Error', context, Colors.red, scaffoldKey);
      return false;
    }
  }
  Future<dynamic> getNotifications({String filterName}) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + notifications;

    // TODO: implement getStudents
    final response = await http.get(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
    );
    print("ResponseInfo ${json.decode(response.body)}");
    print("ResponseInfo ${completeUrl}");
    print("ResponseInfo ${BaseToken}");
    XsProgressHud.hide();

    if (response.statusCode == 200) {
      return NotificationModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      // return NotificationModel.fromJson(json.decode(response.body));
      // return EventDetailsModel.fromJson(json.decode(response.body));

    } else {
      FN_showToast('Error', context, Colors.red, scaffoldKey);
      return false;
    }
  }

  Future ordersListApi() async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + orders;
    final response = await http.get(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
    );
    print("completeUrlordersListApi::: ${completeUrl}");
    print("completeUrlordersListApi::: ${completeUrl}");
    print("completestatusCode::: ${response.statusCode}");

    Map<String, dynamic> dataContent = json.decode(response.body);
    print("completeUrlordersListApi::: ${dataContent}");

    XsProgressHud.hide();
    if (response.statusCode == 200) {
      return OrdersModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      print("body :" + json.decode(response.body).toString());
      // return OrdersModel.fromJson(dataContent);
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }

  Future cancelOrder( int Id) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + cancelOrders+"$Id/";
    print("completeUrlcancelOrder:: ${completeUrl}");
    var data = {"orderstatus": "canceled"};
    var userToJson = json.encode(data);
    final response = await http.patch(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
      body:jsonEncode( data),
    );
    print("dataContenstatusCodecancelOrder:: ${response.statusCode}");

    Map<String, dynamic> dataContent = json.decode(response.body);

    print("dataContent:: ${dataContent}");
    XsProgressHud.hide();
    if (response.statusCode == 200) {
      print("body :" + json.decode(response.body).toString());
      return true;
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }

  Future orderStatus(GlobalKey<ScaffoldState> _scaffoldKey, int Id) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + orderStatusDetails;
    var data = {"order_id": "12321"};
    var userToJson = json.encode(data);
    final response = await http.post(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
      body: userToJson,
    );
    Map<String, dynamic> dataContent = json.decode(response.body);

    print("dataContent:: ${dataContent}");
    XsProgressHud.hide();
    if (response.statusCode == 200) {
      print("body :" + json.decode(response.body).toString());
      return true;
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }

  Future checkCouponApi(Map data) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + checkCoupon;
     var userToJson = json.encode(data);

     print("userToJson::: ${userToJson}");
    final response = await http.post(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
      body: userToJson,
    );
    print("dataContentcheckCouponApi:: ${response.body}");
    print("dataContentcheckCouponApi:: ${response.statusCode}");



    XsProgressHud.hide();
    if (response.statusCode == 200) {
      print("body :" + json.decode(response.body).toString());
      return PromoCodeModelSuccess.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      // return true;
    } else {
      print("body :" + json.decode(response.body).toString());
      // FN_showToast(
      //     '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }

  Future getCustomersAddressesApi(
      GlobalKey<ScaffoldState> _scaffoldKey) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + customersAddresses ;

    final response = await http.get(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
    );
    Map<String, dynamic> dataContent = json.decode(response.body);

    print("completeUrl:: ${completeUrl}");
    print("dataContent:: ${dataContent}");
    XsProgressHud.hide();
    if (response.statusCode == 200) {
      print("body :" + json.decode(response.body).toString());
      return UserAddresses.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      // return UserAddresses.fromJson(dataContent);
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }

  Future getUserPromoCodeApi() async {

    final String completeUrl = baseUrl + user_coupon_code ;

    final response = await http.get(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
    );
    Map<String, dynamic> dataContent = json.decode(response.body);

    print("completeUrl:: ${completeUrl}");
    print("dataContent:: ${dataContent}");
     if (response.statusCode == 200) {
      print("body :" + json.decode(response.body).toString());
      return PromoCodeModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      // return PromoCodeModel.fromJson(dataContent);
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }
  Future getUserCountApi() async {

    final String completeUrl = baseUrl + usageCount ;

    final response = await http.get(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
    );
    Map<String, dynamic> dataContent = json.decode(response.body);

    print("completeUrl:: ${completeUrl}");
    print("dataContent:: ${dataContent}");
     if (response.statusCode == 200) {
      print("body :" + json.decode(response.body).toString());
      return PointsModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      // return PromoCodeModel.fromJson(dataContent);
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }
  Future deleteCustomersAddressesApi(int addressID) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + customersAddresses+addressID.toString()+"/" ;

    final response = await http.delete(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
    );

    print("completeUrl:: ${completeUrl}");
    print("dataContent:: ${response.body}");
    print("statusCode:: ${response.statusCode}");
    XsProgressHud.hide();
    if (response.statusCode == 204) {
       return true;
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }
  Future addCustomersAddressesApi(
      Map data) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + customersAddresses ;

    final response = await http.post(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
      body: jsonEncode(data)
    );

    print("dataContent:: ${data}");
    print("dataContent:: ${response.body}");
    print("dataContent:: ${response.statusCode}");
    Map<String, dynamic> dataContent = json.decode(response.body);

    XsProgressHud.hide();
    if (response.statusCode == 201) {
      print("body :" + json.decode(response.body).toString());
      return true;
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }

  Future getBallanceApi() async {

    final String completeUrl = baseUrl + myBalance ;

    final response = await http.get(
        completeUrl,
        headers: {
          HttpHeaders.authorizationHeader: BaseToken
        },
     );

     print("dataContentaddPromoCodeApi:: ${response.body}");
    print("dataContentaddPromoCodeApi:: ${response.statusCode}");
    Map<String, dynamic> dataContent = json.decode(response.body);

     if (response.statusCode == 200) {
      print("body :" + json.decode(response.body).toString());
      return BallanceModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));

      // return true;
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }

  Future addPromoCodeApi(
      Map data) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + user_coupon_code ;

    final response = await http.post(
        completeUrl,
        headers: {
            HttpHeaders.authorizationHeader: BaseToken
        },
        body: data
    );

    print("dataContentaddPromoCodeApi:: ${data}");
    print("dataContentaddPromoCodeApi:: ${response.body}");
    print("dataContentaddPromoCodeApi:: ${response.statusCode}");
    Map<String, dynamic> dataContent = json.decode(response.body);

    XsProgressHud.hide();
    if (response.statusCode == 201) {
      print("body :" + json.decode(response.body).toString());
      return true;
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }

  Future checkPromoCodeApi(
      Map data) async {
    XsProgressHud.show(context);

    final String completeUrl = baseUrl + check_coupon ;

    final response = await http.post(
        completeUrl,
        headers: {
            HttpHeaders.authorizationHeader: BaseToken
        },
        body: data
    );

    print("dataContentaddPromoCodeApi:: ${data}");
    print("dataContentaddPromoCodeApi:: ${response.body}");
    print("dataContentaddPromoCodeApi:: ${response.statusCode}");
    Map<String, dynamic> dataContent = json.decode(response.body);

    XsProgressHud.hide();
    if (response.statusCode == 201) {
      print("body :" + json.decode(response.body).toString());
      return true;
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }
  Future uploadImageToApi(File fileName) async {

    print("fileName:: ${fileName.path}");
    print("fileName:: ${"$baseUrl${images}"}");
    XsProgressHud.show(context);
    Dio dio = Dio();

    FormData formData = FormData.fromMap({
      "imagedata": await MultipartFile.fromFile("${fileName.path}",
          filename: "${fileName.path.split('/').last}"),
    });
    var response =
    await dio.post("$baseUrl${images}", data: formData,options: Options(
        headers: {'Authorization': BaseToken},
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        }
    ));
    XsProgressHud.hide();
    // final response = await Dio().post("$baseUrl$urlData/set/logo/$id",
    //     data: formData, options: Options(method: "POST", headers: headers));

    print("responseresponse ${formData}");
    print("responseresponse ${response}");
     print("responseresponse ${response.data['id']}");

     return response.data['id'];
  }
  Future addOrderApi(Map data) async {
    XsProgressHud.show(context);
    final String completeUrl = baseUrl + basket;
     var userToJson = json.encode(data);
    final response = await http.post(
      completeUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        HttpHeaders.authorizationHeader: BaseToken
      },
      // body: data,
      body: userToJson,
    );

    print("statusCodestatusCode:: ${completeUrl}");
    print("statusCodestatusCode:: ${BaseToken}");
    print("statusCodestatusCode:: ${data}");
    print("statusCodestatusCode:: ${response.statusCode}");
    print("statusCodestatusCode:: ${response.body}");
     XsProgressHud.hide();
    if (response.statusCode == 200) {
      print("body :" + json.decode(response.body).toString());
      return true;
    } else {
      print("body :" + json.decode(response.body).toString());
      FN_showToast(
          '${json.decode(response.body)}', context, Colors.red, scaffoldKey);
      return false;
    }
  }

  checkItemsInCart(ProductItem productItem){



    for(int x=0;x<cartList.length;x++){
      print("elementname  ${cartList[x].name}");
      if(productItem.id==cartList[x].id){
        print("increseeee");
           cartList[x].quantity +=1;


        return ;

      }

    }

      print ("add new ");
       cartList.add(CartModel(price:productItem.unitprice ,name:translator.currentLanguage == 'ar'
          ?productItem.productnameAr
          : "${productItem.productnameEn}",id: productItem.id,image:  productItem.photoUrl,quantity: 1 ));


  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      return image;

  }
}
