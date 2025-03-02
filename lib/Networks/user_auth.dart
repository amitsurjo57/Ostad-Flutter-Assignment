import 'package:shared_preferences/shared_preferences.dart';

class UserAuth {
  final String _accessToken = "access-token";

  Future<void> saveUserData(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_accessToken, token);
  }

  Future<String?> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? userData = sharedPreferences.getString(_accessToken);
    return userData;
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_accessToken);

    if (token == null){
      return false;
    }else{
      await getUserData();
      return true;
    }
  }

  Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }
}
