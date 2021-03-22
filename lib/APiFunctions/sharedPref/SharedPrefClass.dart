import 'package:shared_preferences/shared_preferences.dart';

String token='token' ;
String BaseToken ;
String userId='userId';
int BaseUderId;

Future setDataToShared(String userToken,int user_Id)async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(token, "Token "+userToken);

  print("tokentoken:: ${userToken}");
  print("tokentoken:: ${token}");
  prefs.setInt(userId, user_Id);
}
Future getDataFromShared()async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  BaseToken=  prefs.getString(token);

  print("BaseToken:: ${BaseToken}");
  print("token:: ${token}");
  BaseUderId=  prefs.getInt(userId);
}
