import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper
{
  static late SharedPreferences _preferences;

  static init()async{
    _preferences=await SharedPreferences.getInstance();
  }
  static Future putBooleanMode({
    required String key,
    required bool mode,
}){
    return _preferences.setBool(key, mode);
  }
  static bool? getBooleanMode({
    required String key,
  }){
    return _preferences.getBool(key);
  }
}