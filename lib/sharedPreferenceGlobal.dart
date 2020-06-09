import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesGlobal {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _kLanguageCode  = "language";
//  static final String _kSecObjDej  = "secobjdej";


  /// ------------------------------------------------------------
  /// Method that returns the user language code, 'en' if not set
  /// ------------------------------------------------------------
  static Future<String> getLanguageCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kLanguageCode) ?? 'en';
  }

//  static Future<String> getSecObjDej() async {
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//    return prefs.getString(_kSecObjDej) ?? 'texto';
//  }

  /// ----------------------------------------------------------
  /// Method that saves the user language code
  /// ----------------------------------------------------------
  static Future<bool> setLanguageCode(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kLanguageCode, value);
  }

//  static Future<bool> setSecObjDej(String value) async {
//    final SharedPreferences prefs = await SharedPreferences.getInstance();
//    return prefs.setString(_kSecObjDej, value);
//  }



}