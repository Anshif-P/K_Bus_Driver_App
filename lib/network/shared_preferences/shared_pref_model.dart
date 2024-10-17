import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefModel {
  SharedPrefModel._constactor();
  static final SharedPrefModel _instance = SharedPrefModel._constactor();
  static SharedPrefModel get instance => _instance;

  late SharedPreferences sharePrefObj;

  Future<void> initSharedPref() async {
    sharePrefObj = await SharedPreferences.getInstance();
  }

  insertData(String key, String value) async {
    await sharePrefObj.setString(key, value);
  }

  getData(String key) {
    final token = sharePrefObj.getString(key);
    return token;
  }

  removeData(String key) {
    sharePrefObj.remove(key);
  }
}
