import 'package:shared_preferences/shared_preferences.dart';
import '../../../api/api.dart';

class SplashScreenServices {
  static Future autoLogin() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var refresh = prefs.getString('refresh');
      dynamic response = await Api().post('user/refresh-token/', body: {
        'refresh': refresh ?? '',
      });
      return response;
    } catch (e) {
      return e;
    }
  }
}
