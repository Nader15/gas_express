import 'package:shared_preferences/shared_preferences.dart';

String token='token' ;
String BaseToken ;
String BasePhone ;
String userId='userId';
String userPhone='userPhone';
int BaseUderId;

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

  print("BaseToken:: ${BaseToken}");
  print("BaseUderId:: ${BaseUderId}");
  print("token:: ${token}");
}
