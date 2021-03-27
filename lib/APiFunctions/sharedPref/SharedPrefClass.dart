import 'package:gas_express/utils/global_vars.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token='token' ;
String BaseToken ;
String BasePhone ;
String userId='userId';
String userPhone='userPhone';
int BaseUderId;
String userAddressId='userAddressId';


String userAddressData='userAddressData';



Future setAddressToShared(String AddressData,int AddressId,)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(userAddressData,AddressData );
  prefs.setInt(userAddressId, AddressId);
  selectedAddressString= userAddressData;
  selectedAddressId=AddressId;
 }


Future setDataToShared(String userToken,int user_Id,String phone)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(token, "Token "+userToken);
  prefs.setString(userPhone,phone);
  BaseToken= "Token "+userToken;
  BaseUderId=user_Id;
  print("tokentoken:: ${userToken}");
  print("tokentoken:: ${token}");
  prefs.setInt(userId, user_Id);
}
Future getDataFromShared()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  BaseToken=  prefs.getString(token);
  BaseUderId=  prefs.getInt(userId);
  BasePhone=  prefs.getString(userPhone);
  selectedAddressString=  prefs.getString(userAddressData);
  selectedAddressId=  prefs.getInt(userAddressId);
  print("BaseToken:: ${BaseToken}");
  print("BaseUderId:: ${BaseUderId}");
  print("token:: ${token}");
  print("selectedAddressId:: ${selectedAddressId}");
  print("selectedAddressString:: ${selectedAddressString}");
  print("sBasePhone:: ${BasePhone}");
}
