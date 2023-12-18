import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static saveLogin({
    String userId,
    String uname,
    String fname,
    String fcmId,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('UserId', userId);
    prefs.setString('Username', uname);
    prefs.setString('Fname', fname);
    prefs.setString('fcm', fcmId);
  }
}
