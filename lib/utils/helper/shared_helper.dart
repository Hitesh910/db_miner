import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper
{
  Future<void> setTheme(bool theme)
  async {
    SharedPreferences helper =await SharedPreferences.getInstance();
    helper.setBool("theme", theme);
  }

  Future<bool?> getTheme()
  async {
    SharedPreferences helper =await SharedPreferences.getInstance();
   bool? mode = helper.getBool("theme");
   return mode;
  }
}